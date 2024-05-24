`include "../src/tinyriscv/core/defines.v"
//`include "defines.v"

// sID模块
// 10个周期发送学号
// ex 检测出sID指令后，将计算任务转交给sID模块
module sid(
    input clk,
    input rst,

    // from ex 
    input start_i,
    
    // to ex 
    output reg ready_o, // 运算结束信号
    output reg busy_o,  // 正在运算信号

    // to rib 
    output reg [`MemBus] sid_mem_wdata_o, // 输出id结果
    output reg [`MemAddrBus] sid_mem_waddr_o, // sid控制uart使能
    output reg sid_mem_we
);

localparam BAUD_115200 = 32'h1B8; // 115200bps 对应分频系数
reg [3:0] byte_cnt;
reg [31:0] cycle_cnt;

always@(posedge clk) begin
    if(rst == `RstEnable)begin
        byte_cnt <= 4'b0000;  
        cycle_cnt <= 32'h0;      
        ready_o <= `sIDResultReady; //
    end
    // detect start signal from ex
    else if(ready_o==`sIDResultReady)begin
        if(start_i == `sIDStart)begin
            //byte_cnt <= 4'b0001;
            byte_cnt <= 4'h1;
            cycle_cnt <= 32'h1;
            ready_o <= `sIDResultNotReady;
        end
        else begin
            byte_cnt <= 4'h0;
            cycle_cnt <= 32'h0;
            ready_o <= `sIDResultReady; //
        end
    end
    // 1~BAUD_115200o cycles: send data; BAUD_115200+1 cycles: reset uart
    else begin
        if(byte_cnt < `sIDDepth)begin
            ready_o <= `sIDResultNotReady;
            if(cycle_cnt == BAUD_115200<<3+1)begin
                byte_cnt <= byte_cnt + 1;
                cycle_cnt <= 32'h0;
            end
            else begin
                byte_cnt <= byte_cnt;
                cycle_cnt <= cycle_cnt + 1;
            end
        end
        else if (byte_cnt == `sIDDepth)begin
            if(cycle_cnt == BAUD_115200<<3+1)begin
                ready_o <= `sIDResultReady;
                byte_cnt <= byte_cnt + 1;
                cycle_cnt <= 32'h0;
            end
            else begin
                ready_o <= `sIDResultNotReady;
                cycle_cnt <= cycle_cnt + 1;
                byte_cnt <= byte_cnt;
            end
        end
        else begin 
            byte_cnt <= 4'b0000;
            cycle_cnt <= 32'h0;
            ready_o <= `sIDResultReady;
        end
        end
    end


// ASCII -> hex
// 2023310655 -> {8'h32, 8'h30, 8'h32, 8'h33, 8'h33, 8'h31, 8'h30, 8'h36, 8'h35, 8'h35}

always@(*) begin    
    case(byte_cnt)
        4'd0: sid_mem_wdata_o = 32'h1;
        4'd1: sid_mem_wdata_o = {24'h0, 8'h32};
        4'd2: sid_mem_wdata_o = {24'h0, 8'h30};
        4'd3: sid_mem_wdata_o = {24'h0, 8'h32};
        4'd4: sid_mem_wdata_o = {24'h0, 8'h33};
        4'd5: sid_mem_wdata_o = {24'h0, 8'h33};
        4'd6: sid_mem_wdata_o = {24'h0, 8'h31};
        4'd7: sid_mem_wdata_o = {24'h0, 8'h30};
        4'd8: sid_mem_wdata_o = {24'h0, 8'h36};
        4'd9: sid_mem_wdata_o = {24'h0, 8'h35};
        4'd10: sid_mem_wdata_o = {24'h0, 8'h35};
        default: sid_mem_wdata_o = 32'h1;
    endcase
end

always@(*)begin
    busy_o = (byte_cnt > 4'd0);
    if(cycle_cnt <= BAUD_115200<<3)begin
        sid_mem_waddr_o = `UART_TX_ADDR;
        sid_mem_we = `WriteEnable;
    end
    else begin
        sid_mem_waddr_o = `UART_TX_ADDR;
        sid_mem_we = `WriteDisable;
    end

end
endmodule

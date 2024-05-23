`include "defines.v"

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
    output reg [`MemBus] result_o, // 输出id结果
    output reg [`MemAddrBus] mem_waddr_o // sid控制uart使能

);

reg [3:0] cnt_cycle;

always@(posedge clk) begin
    if(rst == `RstEnable)begin
        cnt_cycle <= 4'b0000;        
        busy_o <= `False;
        ready_o <= `sIDResultReady; //
    end

    else if (start_i == `sIDStart) begin
        busy_o <= `True;
        if(cnt_cycle < `sIDDepth-1)begin
            cnt_cycle <= cnt_cycle + 1;
            ready_o <= `sIDResultNotReady;
        end
        else begin 
            cnt_cycle <= 4'b0000;
            ready_o <= `sIDResultReady;
        end
    end

    else begin
        cnt_cycle <= 4'b0000;
        busy_o <= `False;
        ready_o <= `sIDResultReady; //
    end
end

// ASCII码转16进制
// 2023310655 -> {8'h32, 8'h30, 8'h32, 8'h33, 8'h33, 8'h31, 8'h30, 8'h36, 8'h35, 8'h35}

always@(*) begin    
    case(cnt_cycle)
        4'd0: result_o = {24'h0, 8'h32};
        4'd1: result_o = {24'h0, 8'h30};
        4'd2: result_o = {24'h0, 8'h32};
        4'd3: result_o = {24'h0, 8'h33};
        4'd4: result_o = {24'h0, 8'h33};
        4'd5: result_o = {24'h0, 8'h31};
        4'd6: result_o = {24'h0, 8'h30};
        4'd7: result_o = {24'h0, 8'h36};
        4'd8: result_o = {24'h0, 8'h35};
        4'd9: result_o = {24'h0, 8'h35};
        default: result_o = `ZeroWord;
    endcase
end

always@(*)begin
    if(cnt_cycle < `sIDDepth)begin
        mem_waddr_o = `UART_ADDR;
    end
    else begin
        mem_waddr_o = `ZeroWord;
    end

end
endmodule

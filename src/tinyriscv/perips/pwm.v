// PWM module
//`include "../core/defines.v"
`include "../src/tinyriscv/core/defines.v"
module pwm (
    input wire clk,
    input wire rst,

    input wire we_i,                   // write enable
    input wire[`MemAddrBus] addr_i,    // addr `define MemAddrBus 31:0
    input wire[`MemBus] data_i,         // `define MemBus 31:0

    output reg[`MemBus] pwm_out    // PWM 输出信号
    );

    reg [31:0] _pwmRegA [0:3];
    reg [31:0] _pwmRegB [0:3];
    reg [3:0] _pwmRegC;

    reg [31:0] counter [0:3];

    always @(posedge clk) begin
        if (we_i == `WriteEnable) begin
            if (addr_i[23:20] == 4'h0) begin
                if (addr_i[19:16] == 4'h4) begin
                    _pwmRegC <= data_i[3:0];
                end
                else begin
                    _pwmRegA[addr_i[19:16]] <= data_i;
                end
            end
            else if (addr_i[23:20] == 4'h1) begin
                _pwmRegB[addr_i[19:16]] <= data_i;
            end
        end
    end

    always @(posedge clk) begin
        if (rst == `RstEnable) begin
            counter[0] <= `ZeroWord;
            counter[1] <= `ZeroWord;
            counter[2] <= `ZeroWord;
            counter[3] <= `ZeroWord;
            pwm_out <= `ZeroWord;
            _pwmRegC <= 4'b0;
        end else begin
            if (_pwmRegC[0] == 1'b0) begin
                pwm_out[0] <= 1'b0;
            end
            else begin
                if (counter[0] < _pwmRegB[0]) begin
                    pwm_out[0] <= 1'b1;
                    counter[0] <= counter[0] + 1'b1;
                end else if (counter[0] < _pwmRegA[0]-1) begin
                    pwm_out[0] <= 1'b0;
                    counter[0] <= counter[0] + 1'b1;
                end else begin
                    counter[0] <= `ZeroWord;
                end
            end


            if (_pwmRegC[1] == 1'b0) begin
                pwm_out[1] <= 1'b0;
            end
            else begin
                if (counter[1] < _pwmRegB[1]) begin
                    pwm_out[1] <= 1'b1;
                    counter[1] <= counter[1] + 1'b1;
                end else if (counter[1] < _pwmRegA[1]-1) begin
                    pwm_out[1] <= 1'b0;
                    counter[1] <= counter[1] + 1'b1;
                end else begin
                    counter[1] <= `ZeroWord;
                end
            end


            if (_pwmRegC[2] == 1'b0) begin
                pwm_out[2] <= 1'b0;
            end
            else begin
                if (counter[2] < _pwmRegB[2]) begin
                    pwm_out[2] <= 1'b1;
                    counter[2] <= counter[2] + 1'b1;
                end else if (counter[2] < _pwmRegA[2]-1) begin
                    pwm_out[2] <= 1'b0;
                    counter[2] <= counter[2] + 1'b1;
                end else begin
                    counter[2] <= `ZeroWord;
                end
            end


            if (_pwmRegC[3] == 1'b0) begin
                pwm_out[3] <= 1'b0;
            end
            else begin
                if (counter[3] < _pwmRegB[3]) begin
                    pwm_out[3] <= 1'b1;
                    counter[3] <= counter[3] + 1'b1;
                end else if (counter[3] < _pwmRegA[3]-1) begin
                    pwm_out[3] <= 1'b0;
                    counter[3] <= counter[3] + 1'b1;
                end else begin
                    counter[3] <= `ZeroWord;
                end
            end

            
        end
    end



endmodule
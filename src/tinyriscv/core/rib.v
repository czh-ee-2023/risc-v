 /*                                                                      
 Copyright 2020 Blue Liang, liangkangnan@163.com
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
 Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */

`include "defines.v"


// RIB\u603b\u7ebf\u6a21\u5757
module rib(

    input wire clk,
    input wire rst,

    // master 0 interface
    input wire[`MemAddrBus] m0_addr_i,     // \u4e3b\u8bbe\u59070\u8bfb\u3001\u5199\u5730\u5740
    input wire[`MemBus] m0_data_i,         // \u4e3b\u8bbe\u59070\u5199\u6570\u636e
    output reg[`MemBus] m0_data_o,         // \u4e3b\u8bbe\u59070\u8bfb\u53d6\u5230\u7684\u6570\u636e
    input wire m0_req_i,                   // \u4e3b\u8bbe\u59070\u8bbf\u95ee\u8bf7\u6c42\u6807\u5fd7
    input wire m0_we_i,                    // \u4e3b\u8bbe\u59070\u5199\u6807\u5fd7

    // master 1 interface
    input wire[`MemAddrBus] m1_addr_i,     // \u4e3b\u8bbe\u59071\u8bfb\u3001\u5199\u5730\u5740
    input wire[`MemBus] m1_data_i,         // \u4e3b\u8bbe\u59071\u5199\u6570\u636e
    output reg[`MemBus] m1_data_o,         // \u4e3b\u8bbe\u59071\u8bfb\u53d6\u5230\u7684\u6570\u636e
    input wire m1_req_i,                   // \u4e3b\u8bbe\u59071\u8bbf\u95ee\u8bf7\u6c42\u6807\u5fd7
    input wire m1_we_i,                    // \u4e3b\u8bbe\u59071\u5199\u6807\u5fd7

    // master 2 interface
    input wire[`MemAddrBus] m2_addr_i,     // \u4e3b\u8bbe\u59072\u8bfb\u3001\u5199\u5730\u5740
    input wire[`MemBus] m2_data_i,         // \u4e3b\u8bbe\u59072\u5199\u6570\u636e
    output reg[`MemBus] m2_data_o,         // \u4e3b\u8bbe\u59072\u8bfb\u53d6\u5230\u7684\u6570\u636e
    input wire m2_req_i,                   // \u4e3b\u8bbe\u59072\u8bbf\u95ee\u8bf7\u6c42\u6807\u5fd7
    input wire m2_we_i,                    // \u4e3b\u8bbe\u59072\u5199\u6807\u5fd7

    // master 3 interface
    input wire[`MemAddrBus] m3_addr_i,     // \u4e3b\u8bbe\u59073\u8bfb\u3001\u5199\u5730\u5740
    input wire[`MemBus] m3_data_i,         // \u4e3b\u8bbe\u59073\u5199\u6570\u636e
    output reg[`MemBus] m3_data_o,         // \u4e3b\u8bbe\u59073\u8bfb\u53d6\u5230\u7684\u6570\u636e
    input wire m3_req_i,                   // \u4e3b\u8bbe\u59073\u8bbf\u95ee\u8bf7\u6c42\u6807\u5fd7
    input wire m3_we_i,                    // \u4e3b\u8bbe\u59073\u5199\u6807\u5fd7

    // slave 0 interface
    output reg[`MemAddrBus] s0_addr_o,     // \u4ece\u8bbe\u59070\u8bfb\u3001\u5199\u5730\u5740
    output reg[`MemBus] s0_data_o,         // \u4ece\u8bbe\u59070\u5199\u6570\u636e
    input wire[`MemBus] s0_data_i,         // \u4ece\u8bbe\u59070\u8bfb\u53d6\u5230\u7684\u6570\u636e
    output reg s0_we_o,                    // \u4ece\u8bbe\u59070\u5199\u6807\u5fd7

    // slave 1 interface
    output reg[`MemAddrBus] s1_addr_o,     // \u4ece\u8bbe\u59071\u8bfb\u3001\u5199\u5730\u5740
    output reg[`MemBus] s1_data_o,         // \u4ece\u8bbe\u59071\u5199\u6570\u636e
    input wire[`MemBus] s1_data_i,         // \u4ece\u8bbe\u59071\u8bfb\u53d6\u5230\u7684\u6570\u636e
    output reg s1_we_o,                    // \u4ece\u8bbe\u59071\u5199\u6807\u5fd7

    // slave 2 interface
    output reg[`MemAddrBus] s2_addr_o,     // \u4ece\u8bbe\u59072\u8bfb\u3001\u5199\u5730\u5740
    output reg[`MemBus] s2_data_o,         // \u4ece\u8bbe\u59072\u5199\u6570\u636e
    input wire[`MemBus] s2_data_i,         // \u4ece\u8bbe\u59072\u8bfb\u53d6\u5230\u7684\u6570\u636e
    output reg s2_we_o,                    // \u4ece\u8bbe\u59072\u5199\u6807\u5fd7

    // slave 3 interface
    output reg[`MemAddrBus] s3_addr_o,     // \u4ece\u8bbe\u59073\u8bfb\u3001\u5199\u5730\u5740
    output reg[`MemBus] s3_data_o,         // \u4ece\u8bbe\u59073\u5199\u6570\u636e
    input wire[`MemBus] s3_data_i,         // \u4ece\u8bbe\u59073\u8bfb\u53d6\u5230\u7684\u6570\u636e
    output reg s3_we_o,                    // \u4ece\u8bbe\u59073\u5199\u6807\u5fd7

    // slave 4 interface
    output reg[`MemAddrBus] s4_addr_o,     // \u4ece\u8bbe\u59074\u8bfb\u3001\u5199\u5730\u5740
    output reg[`MemBus] s4_data_o,         // \u4ece\u8bbe\u59074\u5199\u6570\u636e
    input wire[`MemBus] s4_data_i,         // \u4ece\u8bbe\u59074\u8bfb\u53d6\u5230\u7684\u6570\u636e
    output reg s4_we_o,                    // \u4ece\u8bbe\u59074\u5199\u6807\u5fd7

    // slave 5 interface
    output reg[`MemAddrBus] s5_addr_o,     // \u4ece\u8bbe\u59075\u8bfb\u3001\u5199\u5730\u5740
    output reg[`MemBus] s5_data_o,         // \u4ece\u8bbe\u59075\u5199\u6570\u636e
    input wire[`MemBus] s5_data_i,         // \u4ece\u8bbe\u59075\u8bfb\u53d6\u5230\u7684\u6570\u636e
    output reg s5_we_o,                    // \u4ece\u8bbe\u59075\u5199\u6807\u5fd7

    // slave 6 interface pwm
    output reg[`MemAddrBus] s6_addr_o,     // \u5411pwm\u8bfb\u3001\u5199\u5730\u5740
    output reg[`MemBus] s6_data_o,         // \u5411pwm\u5199\u6570\u636e
    input wire[`MemBus] s6_data_i,         // pwm\u8bfb\u53d6\u5230\u7684\u6570\u636e
    output reg s6_we_o,                    // \u5411pwm\u5199\u6807\u5fd7

    // slave 7 interface i2c
    output reg[`MemAddrBus] s7_addr_o,     // \u5411i2c\u8bfb\u3001\u5199\u5730\u5740
    output reg[`MemBus] s7_data_o,         // \u5411i2c\u5199\u6570\u636e
    input wire[`MemBus] s7_data_i,         // i2c\u8bfb\u53d6\u5230\u7684\u6570\u636e
    output reg s7_we_o,                    // \u5411i2c\u5199\u6807\u5fd7

    output reg hold_flag_o                 // \u6682\u505c\u6d41\u6c34\u7ebf\u6807\u5fd7

    );


    // \u8bbf\u95ee\u5730\u5740\u7684\u6700\u9ad84\u4f4d\u51b3\u5b9a\u8981\u8bbf\u95ee\u7684\u662f\u54ea\u4e00\u4e2a\u4ece\u8bbe\u5907
    // \u56e0\u6b64\u6700\u591a\u652f\u630116\u4e2a\u4ece\u8bbe\u5907
    parameter [3:0]slave_0 = 4'b0000;
    parameter [3:0]slave_1 = 4'b0001;
    parameter [3:0]slave_2 = 4'b0010;
    parameter [3:0]slave_3 = 4'b0011;
    parameter [3:0]slave_4 = 4'b0100;
    parameter [3:0]slave_5 = 4'b0101;
    parameter [3:0]slave_6 = 4'b0110;  // pwm
    parameter [3:0]slave_7 = 4'b0111;  // i2c

    parameter [1:0]grant0 = 2'h0;
    parameter [1:0]grant1 = 2'h1;
    parameter [1:0]grant2 = 2'h2;
    parameter [1:0]grant3 = 2'h3;

    wire[3:0] req;
    reg[1:0] grant;


    // \u4e3b\u8bbe\u5907\u8bf7\u6c42\u4fe1\u53f7
    assign req = {m3_req_i, m2_req_i, m1_req_i, m0_req_i};

    // \u4ef2\u88c1\u903b\u8f91
    // \u56fa\u5b9a\u4f18\u5148\u7ea7\u4ef2\u88c1\u673a\u5236
    // \u4f18\u5148\u7ea7\u7531\u9ad8\u5230\u4f4e\uff1a\u4e3b\u8bbe\u59073\uff0c\u4e3b\u8bbe\u59070\uff0c\u4e3b\u8bbe\u59072\uff0c\u4e3b\u8bbe\u59071
    always @ (*) begin
        if (req[3]) begin
            grant = grant3;
            hold_flag_o = `HoldEnable;
        end else if (req[0]) begin
            grant = grant0;
            hold_flag_o = `HoldEnable;
        end else if (req[2]) begin
            grant = grant2;
            hold_flag_o = `HoldEnable;
        end else begin
            grant = grant1;
            hold_flag_o = `HoldDisable;
        end
    end

    // \u6839\u636e\u4ef2\u88c1\u7ed3\u679c\uff0c\u9009\u62e9(\u8bbf\u95ee)\u5bf9\u5e94\u7684\u4ece\u8bbe\u5907
    always @ (*) begin
        m0_data_o = `ZeroWord;
        m1_data_o = `INST_NOP;
        m2_data_o = `ZeroWord;
        m3_data_o = `ZeroWord;

        s0_addr_o = `ZeroWord;
        s1_addr_o = `ZeroWord;
        s2_addr_o = `ZeroWord;
        s3_addr_o = `ZeroWord;
        s4_addr_o = `ZeroWord;
        s5_addr_o = `ZeroWord;
        s6_addr_o = `ZeroWord; // pwm
        s0_data_o = `ZeroWord;
        s1_data_o = `ZeroWord;
        s2_data_o = `ZeroWord;
        s3_data_o = `ZeroWord;
        s4_data_o = `ZeroWord;
        s5_data_o = `ZeroWord;
        s6_data_o = `ZeroWord; // pwm
        s0_we_o = `WriteDisable;
        s1_we_o = `WriteDisable;
        s2_we_o = `WriteDisable;
        s3_we_o = `WriteDisable;
        s4_we_o = `WriteDisable;
        s5_we_o = `WriteDisable;
        s6_we_o = `WriteDisable; //pwm


        case (grant)
            grant0: begin
                case (m0_addr_i[31:28])
                    slave_0: begin
                        s0_we_o = m0_we_i;
                        s0_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s0_data_o = m0_data_i;
                        m0_data_o = s0_data_i;
                    end
                    slave_1: begin
                        s1_we_o = m0_we_i;
                        s1_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s1_data_o = m0_data_i;
                        m0_data_o = s1_data_i;
                    end
                    slave_2: begin
                        s2_we_o = m0_we_i;
                        s2_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s2_data_o = m0_data_i;
                        m0_data_o = s2_data_i;
                    end
                    slave_3: begin
                        s3_we_o = m0_we_i;
                        s3_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s3_data_o = m0_data_i;
                        m0_data_o = s3_data_i;
                    end
                    slave_4: begin
                        s4_we_o = m0_we_i;
                        s4_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s4_data_o = m0_data_i;
                        m0_data_o = s4_data_i;
                    end
                    slave_5: begin
                        s5_we_o = m0_we_i;
                        s5_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s5_data_o = m0_data_i;
                        m0_data_o = s5_data_i;
                    end
                    slave_6: begin                          // pwm
                        s6_we_o = m0_we_i;
                        s6_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s6_data_o = m0_data_i;
                        m0_data_o = s6_data_i;
                    end
                    slave_7: begin                          // i2c
                        s7_we_o = m0_we_i;
                        s7_addr_o = {{4'h0}, {m0_addr_i[27:0]}};
                        s7_data_o = m0_data_i;
                        m0_data_o = s7_data_i;
                    end

                    default: begin

                    end
                endcase
            end
            grant1: begin
                case (m1_addr_i[31:28])
                    slave_0: begin
                        s0_we_o = m1_we_i;
                        s0_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s0_data_o = m1_data_i;
                        m1_data_o = s0_data_i;
                    end
                    slave_1: begin
                        s1_we_o = m1_we_i;
                        s1_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s1_data_o = m1_data_i;
                        m1_data_o = s1_data_i;
                    end
                    slave_2: begin
                        s2_we_o = m1_we_i;
                        s2_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s2_data_o = m1_data_i;
                        m1_data_o = s2_data_i;
                    end
                    slave_3: begin
                        s3_we_o = m1_we_i;
                        s3_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s3_data_o = m1_data_i;
                        m1_data_o = s3_data_i;
                    end
                    slave_4: begin
                        s4_we_o = m1_we_i;
                        s4_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s4_data_o = m1_data_i;
                        m1_data_o = s4_data_i;
                    end
                    slave_5: begin
                        s5_we_o = m1_we_i;
                        s5_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s5_data_o = m1_data_i;
                        m1_data_o = s5_data_i;
                    end
                    slave_6: begin                          // pwm
                        s6_we_o = m1_we_i;
                        s6_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s6_data_o = m1_data_i;
                        m1_data_o = s6_data_i;
                    end
                    slave_7: begin                          // i2c
                        s7_we_o = m1_we_i;
                        s7_addr_o = {{4'h0}, {m1_addr_i[27:0]}};
                        s7_data_o = m1_data_i;
                        m1_data_o = s7_data_i;
                    end


                    default: begin

                    end
                endcase
            end
            grant2: begin
                case (m2_addr_i[31:28])
                    slave_0: begin
                        s0_we_o = m2_we_i;
                        s0_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s0_data_o = m2_data_i;
                        m2_data_o = s0_data_i;
                    end
                    slave_1: begin
                        s1_we_o = m2_we_i;
                        s1_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s1_data_o = m2_data_i;
                        m2_data_o = s1_data_i;
                    end
                    slave_2: begin
                        s2_we_o = m2_we_i;
                        s2_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s2_data_o = m2_data_i;
                        m2_data_o = s2_data_i;
                    end
                    slave_3: begin
                        s3_we_o = m2_we_i;
                        s3_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s3_data_o = m2_data_i;
                        m2_data_o = s3_data_i;
                    end
                    slave_4: begin
                        s4_we_o = m2_we_i;
                        s4_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s4_data_o = m2_data_i;
                        m2_data_o = s4_data_i;
                    end
                    slave_5: begin
                        s5_we_o = m2_we_i;
                        s5_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s5_data_o = m2_data_i;
                        m2_data_o = s5_data_i;
                    end
                    slave_6: begin // pwm
                        s6_we_o = m2_we_i;
                        s6_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s6_data_o = m2_data_i;
                        m2_data_o = s6_data_i;
                    end
                    slave_7: begin                          // i2c
                        s7_we_o = m2_we_i;
                        s7_addr_o = {{4'h0}, {m2_addr_i[27:0]}};
                        s7_data_o = m2_data_i;
                        m2_data_o = s7_data_i;
                    end
                    
                    default: begin

                    end
                endcase
            end
            grant3: begin
                case (m3_addr_i[31:28])
                    slave_0: begin
                        s0_we_o = m3_we_i;
                        s0_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s0_data_o = m3_data_i;
                        m3_data_o = s0_data_i;
                    end
                    slave_1: begin
                        s1_we_o = m3_we_i;
                        s1_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s1_data_o = m3_data_i;
                        m3_data_o = s1_data_i;
                    end
                    slave_2: begin
                        s2_we_o = m3_we_i;
                        s2_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s2_data_o = m3_data_i;
                        m3_data_o = s2_data_i;
                    end
                    slave_3: begin
                        s3_we_o = m3_we_i;
                        s3_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s3_data_o = m3_data_i;
                        m3_data_o = s3_data_i;
                    end
                    slave_4: begin
                        s4_we_o = m3_we_i;
                        s4_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s4_data_o = m3_data_i;
                        m3_data_o = s4_data_i;
                    end
                    slave_5: begin
                        s5_we_o = m3_we_i;
                        s5_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s5_data_o = m3_data_i;
                        m3_data_o = s5_data_i;
                    end
                    slave_6: begin // pwm
                        s6_we_o = m3_we_i;
                        s6_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s6_data_o = m3_data_i;
                        m3_data_o = s6_data_i;
                    end
                    slave_7: begin                          // i2c
                        s7_we_o = m3_we_i;
                        s7_addr_o = {{4'h0}, {m3_addr_i[27:0]}};
                        s7_data_o = m3_data_i;
                        m3_data_o = s7_data_i;
                    end


                    default: begin

                    end
                endcase
            end
            default: begin

            end
        endcase
    end

endmodule
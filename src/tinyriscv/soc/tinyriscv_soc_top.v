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

`include "../core/defines.v"

// tinyriscv soc\u9876\u5c42\u6a21\u5757
module tinyriscv_soc_top(

    input wire clk,
    input wire rst,

    output wire over,         // \u6d4b\u8bd5\u662f\u5426\u5b8c\u6210\u4fe1\u53f7
    output wire succ,         // \u6d4b\u8bd5\u662f\u5426\u6210\u529f\u4fe1\u53f7

    output wire halted_ind,  // jtag\u662f\u5426\u5df2\u7ecfhalt\u4f4fCPU\u4fe1\u53f7

    input wire uart_debug_pin, // \u4e32\u53e3\u4e0b\u8f7d\u4f7f\u80fd\u5f15\u811a

    output wire uart_tx_pin, // UART\u53d1\u9001\u5f15\u811a
    input wire uart_rx_pin,  // UART\u63a5\u6536\u5f15\u811a
    inout wire[15:0] gpio_io,    // GPIO\u5f15\u811a

    input wire jtag_TCK,     // JTAG TCK\u5f15\u811a
    input wire jtag_TMS,     // JTAG TMS\u5f15\u811a
    input wire jtag_TDI,     // JTAG TDI\u5f15\u811a
    output wire jtag_TDO,    // JTAG TDO\u5f15\u811a

    input wire spi_miso,     // SPI MISO\u5f15\u811a
    output wire spi_mosi,    // SPI MOSI\u5f15\u811a
    output wire spi_ss,      // SPI SS\u5f15\u811a
    output wire spi_clk      // SPI CLK\u5f15\u811a

    );


    // master 0 interface
    wire[`MemAddrBus] m0_addr_i;
    wire[`MemBus] m0_data_i;
    wire[`MemBus] m0_data_o;
    wire m0_req_i;
    wire m0_we_i;

    // master 1 interface
    wire[`MemAddrBus] m1_addr_i;
    wire[`MemBus] m1_data_i;
    wire[`MemBus] m1_data_o;
    wire m1_req_i;
    wire m1_we_i;

    // master 2 interface
    wire[`MemAddrBus] m2_addr_i;
    wire[`MemBus] m2_data_i;
    wire[`MemBus] m2_data_o;
    wire m2_req_i;
    wire m2_we_i;

    // master 3 interface
    wire[`MemAddrBus] m3_addr_i;
    wire[`MemBus] m3_data_i;
    wire[`MemBus] m3_data_o;
    wire m3_req_i;
    wire m3_we_i;

    // slave 0 interface
    wire[`MemAddrBus] s0_addr_o;
    wire[`MemBus] s0_data_o;
    wire[`MemBus] s0_data_i;
    wire s0_we_o;

    // slave 1 interface
    wire[`MemAddrBus] s1_addr_o;
    wire[`MemBus] s1_data_o;
    wire[`MemBus] s1_data_i;
    wire s1_we_o;

    // slave 2 interface
    wire[`MemAddrBus] s2_addr_o;
    wire[`MemBus] s2_data_o;
    wire[`MemBus] s2_data_i;
    wire s2_we_o;

    // slave 3 interface
    wire[`MemAddrBus] s3_addr_o;
    wire[`MemBus] s3_data_o;
    wire[`MemBus] s3_data_i;
    wire s3_we_o;

    // slave 4 interface
    wire[`MemAddrBus] s4_addr_o;
    wire[`MemBus] s4_data_o;
    wire[`MemBus] s4_data_i;
    wire s4_we_o;

    // slave 5 interface
    wire[`MemAddrBus] s5_addr_o;
    wire[`MemBus] s5_data_o;
    wire[`MemBus] s5_data_i;
    wire s5_we_o;

    // slave 6 pwm interface
    wire[`MemAddrBus] s6_addr_o;
    wire[`MemBus] s6_data_o;
    wire[`MemBus] s6_data_i;
    wire s6_we_o;

    // slave 7 i2c interface
    wire[`MemAddrBus] s7_addr_o;
    wire[`MemBus] s7_data_o;
    wire[`MemBus] s7_data_i;
    wire s7_we_o;
    

    // rib
    wire rib_hold_flag_o;

    // jtag
    wire jtag_halt_req_o;
    wire jtag_reset_req_o;
    wire[`RegAddrBus] jtag_reg_addr_o;
    wire[`RegBus] jtag_reg_data_o;
    wire jtag_reg_we_o;
    wire[`RegBus] jtag_reg_data_i;

    // tinyriscv
    wire[`INT_BUS] int_flag;

    // timer0
    wire timer0_int;

    // gpio
    wire[15:0] io_in;
    wire[31:0] gpio_ctrl;
    wire[31:0] gpio_data;

    // i2c
    wire sda;
    wire scl;


    assign int_flag = {7'h0, timer0_int};

    // \u4f4e\u7535\u5e73\u70b9\u4eaeLED
    // \u4f4e\u7535\u5e73\u8868\u793a\u5df2\u7ecfhalt\u4f4fCPU
    assign halted_ind = ~jtag_halt_req_o;


    // tinyriscv\u5904\u7406\u5668\u6838\u6a21\u5757\u4f8b\u5316
    tinyriscv u_tinyriscv(
        .clk(clk),
        .rst(rst),
        .rib_ex_addr_o(m0_addr_i),
        .rib_ex_data_i(m0_data_o),
        .rib_ex_data_o(m0_data_i),
        .rib_ex_req_o(m0_req_i),
        .rib_ex_we_o(m0_we_i),

        .rib_pc_addr_o(m1_addr_i),
        .rib_pc_data_i(m1_data_o),

        .jtag_reg_addr_i(jtag_reg_addr_o),
        .jtag_reg_data_i(jtag_reg_data_o),
        .jtag_reg_we_i(jtag_reg_we_o),
        .jtag_reg_data_o(jtag_reg_data_i),

        .rib_hold_flag_i(rib_hold_flag_o),
        .jtag_halt_flag_i(jtag_halt_req_o),
        .jtag_reset_flag_i(jtag_reset_req_o),

        .int_i(int_flag),
		
        .over(over),
        .succ(succ)
    );

    // rom\u6a21\u5757\u4f8b\u5316
    rom u_rom(
        .clk(clk),
        .rst(rst),
        .we_i(s0_we_o),
        .addr_i(s0_addr_o),
        .data_i(s0_data_o),
        .data_o(s0_data_i)
    );

    // ram\u6a21\u5757\u4f8b\u5316
    ram u_ram(
        .clk(clk),
        .rst(rst),
        .we_i(s1_we_o),
        .addr_i(s1_addr_o),
        .data_i(s1_data_o),
        .data_o(s1_data_i)
    );

    // timer\u6a21\u5757\u4f8b\u5316
    timer timer_0(
        .clk(clk),
        .rst(rst),
        .data_i(s2_data_o),
        .addr_i(s2_addr_o),
        .we_i(s2_we_o),
        .data_o(s2_data_i),
        .int_sig_o(timer0_int)
    );

    // uart\u6a21\u5757\u4f8b\u5316
    uart uart_0(
        .clk(clk),
        .rst(rst),
        .we_i(s3_we_o),
        .addr_i(s3_addr_o),
        .data_i(s3_data_o),
        .data_o(s3_data_i),
        .tx_pin(uart_tx_pin),
        .rx_pin(uart_rx_pin)
    );

    // io0
    assign gpio_io[0] = (gpio_ctrl[1:0] == 2'b01) ? gpio_data[0] : 1'bz;
    assign io_in[0] = gpio_io[0];
    // io1
    assign gpio_io[1] = (gpio_ctrl[3:2] == 2'b01) ? gpio_data[1] : 1'bz;
    assign io_in[1] = gpio_io[1];
    // io2
    assign gpio_io[2] = (gpio_ctrl[5:4] == 2'b01) ? gpio_data[2] : 1'bz;
    assign io_in[2] = gpio_io[2];
    // io3
    assign gpio_io[3] = (gpio_ctrl[7:6] == 2'b01) ? gpio_data[3] : 1'bz;
    assign io_in[3] = gpio_io[3];
    // io4
    assign gpio_io[4] = (gpio_ctrl[9:8] == 2'b01) ? gpio_data[4] : 1'bz;
    assign io_in[4] = gpio_io[4];
    // io5
    assign gpio_io[5] = (gpio_ctrl[11:10] == 2'b01) ? gpio_data[5] : 1'bz;
    assign io_in[5] = gpio_io[5];
    // io6
    assign gpio_io[6] = (gpio_ctrl[13:12] == 2'b01) ? gpio_data[6] : 1'bz;
    assign io_in[6] = gpio_io[6];
    // io7
    assign gpio_io[7] = (gpio_ctrl[15:14] == 2'b01) ? gpio_data[7] : 1'bz;
    assign io_in[7] = gpio_io[7];
    // io8
    assign gpio_io[8] = (gpio_ctrl[17:16] == 2'b01) ? gpio_data[8] : 1'bz;
    assign io_in[8] = gpio_io[8];
    // io9
    assign gpio_io[9] = (gpio_ctrl[19:18] == 2'b01) ? gpio_data[9] : 1'bz;
    assign io_in[9] = gpio_io[9];
    // io10
    assign gpio_io[10] = (gpio_ctrl[21:20] == 2'b01) ? gpio_data[10] : 1'bz;
    assign io_in[10] = gpio_io[10];
    // io11
    assign gpio_io[11] = (gpio_ctrl[23:22] == 2'b01) ? gpio_data[11] : 1'bz;
    assign io_in[11] = gpio_io[11];
    // io12
    assign gpio_io[12] = (gpio_ctrl[25:24] == 2'b01) ? gpio_data[12] : 1'bz;
    assign io_in[12] = gpio_io[12];
    // io13
    assign gpio_io[13] = (gpio_ctrl[27:26] == 2'b01) ? gpio_data[13] : 1'bz;
    assign io_in[13] = gpio_io[13];
    // io14
    assign gpio_io[14] = (gpio_ctrl[29:28] == 2'b01) ? gpio_data[14] : 1'bz;
    assign io_in[14] = gpio_io[14];
    // io15
    assign gpio_io[15] = (gpio_ctrl[31:30] == 2'b01) ? gpio_data[15] : 1'bz;
    assign io_in[15] = gpio_io[15];

    // gpio\u6a21\u5757\u4f8b\u5316
    gpio gpio_0(
        .clk(clk),
        .rst(rst),
        .we_i(s4_we_o),
        .addr_i(s4_addr_o),
        .data_i(s4_data_o),
        .data_o(s4_data_i),
        .io_pin_i(io_in),
        .reg_ctrl(gpio_ctrl),
        .reg_data(gpio_data)
    );

    // spi\u6a21\u5757\u4f8b\u5316
    spi spi_0(
        .clk(clk),
        .rst(rst),
        .data_i(s5_data_o),
        .addr_i(s5_addr_o),
        .we_i(s5_we_o),
        .data_o(s5_data_i),
        .spi_mosi(spi_mosi),
        .spi_miso(spi_miso),
        .spi_ss(spi_ss),
        .spi_clk(spi_clk)
    );

    pwm pwm_0(
        .clk(clk),
        .rst(rst),
        .we_i(s6_we_o),
        .addr_i(s6_addr_o),
        .data_i(s6_data_o),
        .pwm_out(s6_data_i)
    );

    i2c i2c_0(
        .clk(clk),
        .rst(rst),
        .we_i(s7_we_o),
        .addr_i(s7_addr_o),
        .data_i(s7_data_o),
        .data_o(s7_data_i),
        .sda(sda),
        .scl(scl)
    );



    // rib\u6a21\u5757\u4f8b\u5316
    rib u_rib(
        .clk(clk),
        .rst(rst),

        // master 0 interface
        .m0_addr_i(m0_addr_i),
        .m0_data_i(m0_data_i),
        .m0_data_o(m0_data_o),
        .m0_req_i(m0_req_i),
        .m0_we_i(m0_we_i),

        // master 1 interface 
        .m1_addr_i(m1_addr_i),
        .m1_data_i(`ZeroWord),
        .m1_data_o(m1_data_o),
        .m1_req_i(`RIB_REQ),
        .m1_we_i(`WriteDisable),

        // master 2 interface:
        .m2_addr_i(m2_addr_i),
        .m2_data_i(m2_data_i),
        .m2_data_o(m2_data_o),
        .m2_req_i(m2_req_i),
        .m2_we_i(m2_we_i),

        // master 3 interface: 
        .m3_addr_i(m3_addr_i),
        .m3_data_i(m3_data_i),
        .m3_data_o(m3_data_o),
        .m3_req_i(m3_req_i),
        .m3_we_i(m3_we_i),

        // slave 0 interface
        .s0_addr_o(s0_addr_o),
        .s0_data_o(s0_data_o),
        .s0_data_i(s0_data_i),
        .s0_we_o(s0_we_o),

        // slave 1 interface
        .s1_addr_o(s1_addr_o),
        .s1_data_o(s1_data_o),
        .s1_data_i(s1_data_i),
        .s1_we_o(s1_we_o),

        // slave 2 interface
        .s2_addr_o(s2_addr_o),
        .s2_data_o(s2_data_o),
        .s2_data_i(s2_data_i),
        .s2_we_o(s2_we_o),

        // slave 3 interface
        .s3_addr_o(s3_addr_o),
        .s3_data_o(s3_data_o),
        .s3_data_i(s3_data_i),
        .s3_we_o(s3_we_o),

        // slave 4 interface
        .s4_addr_o(s4_addr_o),
        .s4_data_o(s4_data_o),
        .s4_data_i(s4_data_i),
        .s4_we_o(s4_we_o),

        // slave 5 interface
        .s5_addr_o(s5_addr_o),
        .s5_data_o(s5_data_o),
        .s5_data_i(s5_data_i),
        .s5_we_o(s5_we_o),

        // slave 6  pwm interface
        .s6_addr_o(s6_addr_o),
        .s6_data_o(s6_data_o),
        .s6_data_i(s6_data_i),
        .s6_we_o(s6_we_o),

        // slave 7  i2c interface
        .s7_addr_o(s7_addr_o),
        .s7_data_o(s7_data_o),
        .s7_data_i(s7_data_i),
        .s7_we_o(s7_we_o),


        .hold_flag_o(rib_hold_flag_o)
    );

    // \u4e32\u53e3\u4e0b\u8f7d\u6a21\u5757\u4f8b\u5316
    uart_debug u_uart_debug(
        .clk(clk),
        .rst(rst),
        .debug_en_i(uart_debug_pin),
        .req_o(m3_req_i),
        .mem_we_o(m3_we_i),
        .mem_addr_o(m3_addr_i),
        .mem_wdata_o(m3_data_i),
        .mem_rdata_i(m3_data_o)
    );

    // jtag\u6a21\u5757\u4f8b\u5316
    jtag_top #(
        .DMI_ADDR_BITS(6),
        .DMI_DATA_BITS(32),
        .DMI_OP_BITS(2)
    ) u_jtag_top(
        .clk(clk),
        .jtag_rst_n(rst),
        .jtag_pin_TCK(jtag_TCK),
        .jtag_pin_TMS(jtag_TMS),
        .jtag_pin_TDI(jtag_TDI),
        .jtag_pin_TDO(jtag_TDO),
        .reg_we_o(jtag_reg_we_o),
        .reg_addr_o(jtag_reg_addr_o),
        .reg_wdata_o(jtag_reg_data_o),
        .reg_rdata_i(jtag_reg_data_i),
        .mem_we_o(m2_we_i),
        .mem_addr_o(m2_addr_i),
        .mem_wdata_o(m2_data_i),
        .mem_rdata_i(m2_data_o),
        .op_req_o(m2_req_i),
        .halt_req_o(jtag_halt_req_o),
        .reset_req_o(jtag_reset_req_o)
    );

endmodule
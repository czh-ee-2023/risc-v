// I2C module
//`include "../core/defines.v"
`include "../src/tinyriscv/core/defines.v"

module i2c (
    input wire clk,
    input wire rst,
    
                            // data_i[16]: start
                            // data_i[15]: rw 1：read 0:write
                            // data_i[14:8]: addr (7 bits)
                            // data_i[7:0]: data (8 bits)

    input wire[31:0] data_i, 
    input wire[31:0] addr_i,
    input wire we_i,
    
    output wire [7:0] data_o,


    inout wire sda,
    output wire scl
    );

    parameter CLK_DIV = 100;  // Clock divider for I2C clock generation
    localparam SLAVE_ADDR   = 4'h1;    
    localparam I2C_to_SLAVE   = 4'h2;    
    localparam SLAVE_to_I2C = 4'h3;    


    // I2C state machine states
    localparam IDLE = 0, START = 1, ADDR = 2, RW = 3, ACK1 = 4, DATA_WR = 5, DATA_RD = 6, ACK2 = 7, STOP = 8;
    
    
    reg [2:0] state, next_state;
    reg [7:0] clk_div_counter;
    reg scl_enable;
    reg sda_enable;
    reg sda_out;
    reg [7:0] shift_reg;
    reg [3:0] bit_counter;
    reg ack;

    reg start, rw;
    reg [6:0] slave_addr;
    reg [7:0] data_to_slave;
    reg [7:0] data_from_slave;

    always @ (posedge clk) begin
        if (rst == 1'b0) begin
            start <= 1'b0;
            rw <= 1'b0;
            slave_addr <= 7'b0;
            data_to_slave <= 8'b0;
            data_from_slave <= 8'b0;
        end else begin
            if (we_i == 1'b1) begin
                start <= data_i[16];
                rw <= data_i[15];
                case (addr_i[19:16])
                    SLAVE_ADDR: begin
                        slave_addr <= data_i[14:8];
                    end
                    I2C_to_SLAVE: begin
                        data_to_slave <= data_i[7:0];
                    end
                    default: begin
                    end
                endcase
            end
        end
    end

    wire done;


    assign scl = (scl_enable) ? clk_div_counter[7] : 1'b1;
    assign sda = (sda_enable) ? sda_out : 1'bz;

    // Clock divider
    always @(posedge clk or negedge rst) begin
        if (!rst)
            clk_div_counter <= 0;
        else if (clk_div_counter < CLK_DIV)
            clk_div_counter <= clk_div_counter + 1;
        else
            clk_div_counter <= 0;
    end

    always @(posedge clk or negedge rst) begin
        if (!rst)
            state <= IDLE;
        else if (clk_div_counter == CLK_DIV)
            state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (start)  // start signal in data_i
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = ADDR;
            end
            ADDR: begin
                if (bit_counter == 7)
                    next_state = RW;
                else
                    next_state = ADDR;
            end
            RW: begin
                next_state = ACK1;
            end
            ACK1: begin
                if (ack)
                    next_state = (rw) ? DATA_RD : DATA_WR;  // rw signal in data_i
                else
                    next_state = STOP;
            end
            DATA_WR: begin
                if (bit_counter == 8)
                    next_state = ACK2;
                else
                    next_state = DATA_WR;
            end
            DATA_RD: begin
                if (bit_counter == 8)
                    next_state = ACK2;
                else
                    next_state = DATA_RD;
            end
            ACK2: begin
                if (ack)
                    next_state = STOP;
                else
                    next_state = STOP;
            end
            STOP: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // SDA and SCL control
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            scl_enable <= 1'b0;
            sda_enable <= 1'b0;
            sda_out <= 1'b1;
            shift_reg <= 8'b0;
            bit_counter <= 4'b0;
            ack <= 1'b0;
        end else if (clk_div_counter == CLK_DIV) begin
            case (state)
                IDLE: begin
                    scl_enable <= 1'b0;
                    sda_enable <= 1'b0;
                    sda_out <= 1'b1;
                end
                START: begin
                    scl_enable <= 1'b1;  // scl = 0
                    sda_enable <= 1'b1;  // sda = sda_out
                    sda_out <= 1'b0;
                end
                ADDR: begin
                    sda_out <= slave_addr[6 - bit_counter];  // addr in data_i
                    bit_counter <= bit_counter + 1;
                end
                RW: begin
                    sda_out <= rw;  // rw signal in data_i
                end
                ACK1: begin
                    sda_enable <= 1'b0;  // Release SDA for ACK 
                    ack <= !sda;
                end
                DATA_WR: begin
                    sda_out <= data_to_slave[7 - bit_counter];  // data in data_i
                    bit_counter <= bit_counter + 1;
                end
                DATA_RD: begin
                    sda_enable <= 1'b0;  // Release SDA for reading
                    shift_reg[7 - bit_counter] <= sda; // ??
                    bit_counter <= bit_counter + 1;
                end
                ACK2: begin
                    sda_enable <= 1'b1;  //  ??
                    sda_out <= 1'b0;  // Send ACK  ??
                end
                STOP: begin
                    sda_enable <= 1'b1;
                    sda_out <= 1'b0;
                    scl_enable <= 1'b1;
                end
                default: ;
            endcase
        end
    end

    assign data_o = shift_reg;
    assign done = (state == STOP);













endmodule

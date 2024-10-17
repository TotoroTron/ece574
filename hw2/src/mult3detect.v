
// mult3detect.v

module mult3detect
#(parameter DATA_WIDTH = 32)
    (
        input wire i_clk,
        input wire i_rst,
        input wire i_din,
        output reg o_dout
    );

    parameter S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10;

    reg [3:0] state = S0;
    reg [3:0] next_state;

    // STATE REGISTER
    always @(posedge i_clk) begin
        state <= 2'bxx;
        if (i_rst)  state <= S0;
        else        state <= next_state;
    end

    // OUT LOGIC
    always @(posedge i_clk) begin
        o_dout <= 1'bx;
        if (i_rst) o_dout <= 1'b1;
        else begin
            case (state)
                S0 : o_dout <= 1'b1;
                S1 : o_dout <= 1'b0;
                S2 : o_dout <= 1'b0;
                default : o_dout <= 1'bx;
            endcase
        end
    end

    // STATE MACHINE
    always @(state or i_din) begin
        next_state <= 2'bxx;
        case (state) 
            S0 :    if (i_din)  next_state <= S1;
                    else        next_state <= S0;
            S1 :    if (i_din)  next_state <= S2;
                    else        next_state <= S1;
            S2 :    if (i_din)  next_state <= S0;
                    else        next_state <= S2;
            default : next_state <= 2'bxx;
        endcase
    end


endmodule

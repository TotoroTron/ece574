module ripple_carry_adder
#(
    parameter DATA_WIDTH = 16
)(
    input wire [DATA_WIDTH-1:0] iv_a,
    input wire [DATA_WIDTH-1:0] iv_b,
    input wire i_cin,
    output wire [DATA_WIDTH-1:0] ov_sum,
    output wire o_cout
);

    wire [DATA_WIDTH:0] c; // carry bits
    assign c[0] = i_cin;

    genvar i;
    generate for (i = 0; i < DATA_WIDTH; i = i + 1) begin
        full_adder fa
        (
            .i_a(iv_a[i]),
            .i_b(iv_b[i]),
            .i_cin(c[i]),
            .o_sum(ov_sum[i]),
            .o_cout(c[i+1])
        );
    end endgenerate

    assign o_cout = c[DATA_WIDTH];

endmodule

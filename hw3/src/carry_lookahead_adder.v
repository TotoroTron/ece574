module carry_lookahead_adder
#(
    parameter DATA_WIDTH = 16
)(
    input wire [DATA_WIDTH-1:0] iv_a,
    input wire [DATA_WIDTH-1:0] iv_b,
    input wire i_cin,
    output wire [DATA_WIDTH-1:0] ov_sum,
    output wire o_cout
);

    wire [DATA_WIDTH-1:0] p, g;
    wire [DATA_WIDTH:0] c;

    assign c[0] = i_cin;

    genvar i;

    // compute generate and propagation
    generate for (i = 0; i < DATA_WIDTH; i = i + 1) begin
        assign p[i] = iv_a[i] ^ iv_b[i];
        assign g[i] = iv_a[i] & iv_b[i];
    end endgenerate

    // compute carry for each stage
    generate for (i = 1; i < DATA_WIDTH+1; i = i + 1) begin
        assign c[i] = g[i-1] | ( p[i-1] & c[i-1] );
    end endgenerate

    // compute sum
    generate for (i = 0; i < DATA_WIDTH; i = i + 1) begin
        assign sum[i] = p[i] ^ c[i];
    end endgenerate

    // assign final carry
    assign cout = c[n];

endmodule

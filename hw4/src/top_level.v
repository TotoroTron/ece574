module top_level
#(
    parameter DATA_WIDTH = 16,
    parameter RAM_DEPTH = 8
)(
    input wire i_clk,
    input wire i_rst,
    input wire i_en,
    input wire [DATA_WIDTH-1:0] iv_b,
    output wire [DATA_WIDTH-1:0] ov_sum
);

    memory_modelling
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .RAM_DEPTH(RAM_DEPTH)
    ) memory_modelling_inst (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_en(i_en),
        .iv_b(iv_b),
        .ov_sum(ov_sum)
    );

endmodule

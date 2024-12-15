module mac
#(
    parameter DATA_WIDTH = 16
)(
    input wire i_clk,
    input wire i_rst,
    input wire i_en,
    input wire [DATA_WIDTH-1:0] iv_a,
    input wire [DATA_WIDTH-1:0] iv_b,
    output wire [DATA_WIDTH-1:0] ov_c
);

    reg [DATA_WIDTH*2-1:0] sum_full;
    assign ov_c = sum_full[DATA_WIDTH-1:0];

    always @(posedge i_clk) begin
        if (i_rst) begin
            sum_full <= 0;
        end else if (i_en) begin
            sum_full <= sum_full + iv_a * iv_b;
        end
    end

endmodule

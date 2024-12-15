module memory_modelling
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

    localparam ADDR_WIDTH = $clog2(RAM_DEPTH);
    reg [ADDR_WIDTH-1:0] ram_addr;
    wire [DATA_WIDTH-1:0] ram_din;
    wire [DATA_WIDTH-1:0] ram_dout;

    single_port_ram
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) spram_inst (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_en(i_en),
        .i_we(0),
        .iv_addr(ram_addr),
        .iv_din(ram_din),
        .ov_dout(ram_dout)
    );

    wire [DATA_WIDTH-1:0] sum;
    assign ov_sum = sum;

    mac
    #(
        .DATA_WIDTH(DATA_WIDTH)
    ) mac_inst (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_en(i_en),
        .iv_a(ram_dout),
        .iv_b(iv_b),
        .ov_c(sum)
    );

    always @(posedge i_clk) begin
        if (i_rst) begin
            ram_addr <= 0;
        end else if (i_en) begin
            ram_addr <= ram_addr + 1;
        end
    end

endmodule


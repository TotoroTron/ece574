module single_port_ram
#(
    parameter DATA_WIDTH = 24,
    parameter ADDR_WIDTH = 8
)(
    input wire i_clk,
    input wire i_rst,
    input wire i_en,
    input wire i_we,
    input wire [ADDR_WIDTH-1:0] iv_addr,
    input wire [DATA_WIDTH-1:0] iv_din,
    output reg [DATA_WIDTH-1:0] ov_dout
);
    reg [DATA_WIDTH-1:0] RAM [2**ADDR_WIDTH-1:0];

    initial begin
        RAM[0] = 16'h00A0;
        RAM[1] = 16'h00B1;
        RAM[2] = 16'h00C2;
        RAM[3] = 16'h00D3;
        RAM[4] = 16'h00E4;
        RAM[5] = 16'h00F5;
        RAM[6] = 16'h0006;
        RAM[7] = 16'h0017;
    end

    always @(posedge i_clk) begin
        if (i_rst) begin // reset output register
            ov_dout <= 0;
        end else if(i_en) begin
            if (i_we) begin // write
                RAM[iv_addr] <= iv_din;
                ov_dout <= iv_din;
            end else begin // read
                ov_dout <= RAM[iv_addr];
            end
        end
    end

endmodule

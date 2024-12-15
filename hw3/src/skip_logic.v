module skip_logic
#(
    parameter BLOCK_WIDTH = 4
)(
    input wire [BLOCK_WIDTH-1:0] iv_a,
    input wire [BLOCK_WIDTH-1:0] iv_b,
    input wire i_cin,
    input wire i_rca_cout,
    output wire o_cout
);

    wire [BLOCK_WIDTH-1:0] p;
    wire block_prop;
    
    // WIP!


endmodule
    

// module CSA(input [15:0] a, input [15:0] b, input carryin, output [15:0] sum, output carryout);
//     wire [15:0] p, g;
//     wire [16:0] c;
//     assign c[0] = carryin;
//     genvar i;
//     for (i = 0; i < 16; i = i+1) begin
//       assign p[i] = a[i] ^ b[i];
//       assign g[i] = a[i] & b[i];
//     end
//     for (i = 1; i < 17; i = i+1) begin
//       assign c[i] = g[i-1] | (p[i-1] & c [i-1]);
//     end
//     for (i = 0; i < 16; i = i+1) begin
//       assign sum[i] = p[i] ^ c[i];
//     end
//     assign carryout = &p ? c[0] : c[16];
// endmodule

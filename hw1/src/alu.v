// alu.v
// 32-bit ALU
//
// ALUOps:
// 000: and
// 001: or
// 010: add
// 011: sub
// 100: slt (shift if less than)
// default: 0

module alu 
#(parameter DATA_WIDTH = 32)
(
    input [DATA_WIDTH-1:0] A, B,
    input [2:0] ALUOp,
    output [DATA_WIDTH-1:0] Q,
    output Cout
);

always @(*)
begin
    case (ALUOp)
        
        3'b000: // logical and
            Q = A & B;
        3'b001: // logical or
            Q = A | B;
        3'b010: // addition
            Q = A + B;
        3'b110: // subtraction
            Q = A - B;
        3'b111: // set if A less than B
            if (A < B) begin
                // Q = { (DATA_WIDTH-1){1'b0}, 1'b1 };
                Q = 1;
            end else begin
                // Q = { (DATA_WIDTH-1){1'b0}, 1'b0 };
                Q = 0;
            end
        default:
            // Q = (DATA_WIDTH){1'b0};
            Q = 0;
    endcase
end

endmodule

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

module alu (
    input [31:0] A, B,
    input [2:0] ALUOp,
    output [31:0] Q,
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
        3'b011: // subtraction
            Q = A - B;
        3'b100: // set if A less than B
            if (A < B) begin
                Q = 32'd1;
            end else begin
                Q = 32'd0;
            end
        default:
            Q = 32'd0;
    endcase
end

endmodule

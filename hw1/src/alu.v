// alu.v

module alu 
#(parameter DATA_WIDTH = 32)
(
    input wire [DATA_WIDTH-1:0] A, B,
    input wire [2:0] ALUOp,
    output reg [DATA_WIDTH-1:0] Q,
    output reg Cout
);

always @(*)
begin
    case (ALUOp)
        3'b000: Q = A & B; // logical and
        3'b001: Q = A | B; // logical or
        3'b010: Q = A + B; // addition
        3'b110: Q = A - B; // subtraction
        3'b111: begin // set if A less than B
            if (A < B) begin
                // Q = 1; 
                Q = { { (DATA_WIDTH-1){1'b0} }, 1'b1 };
            end else begin
                // Q = 0;
                Q = { { (DATA_WIDTH-1){1'b0} }, 1'b0 };
            end
        end
        default:
            // Q = 0; 
            Q = { (DATA_WIDTH){1'b0} };
    endcase
end

endmodule

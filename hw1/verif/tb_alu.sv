module tb_alu;

    parameter DATA_WIDTH = 32;

    // inputs
    reg [DATA_WIDTH-1:0] A;
    reg [DATA_WIDTH-1:0] B;
    reg [2:0] ALUOp;

    // outputs
    wire [DATA_WIDTH-1:0] Q;
    wire Cout;

    // instantiation unit under test 
    alu #(DATA_WIDTH) dut (
        .A(A),
        .B(B),
        .ALUOp(ALUOp),
        .Q(Q),
        .Cout(Cout)
    );

    reg clk;
    always #5 clk = ~clk;

    initial begin

        A = 32'd1;
        B = 32'd2;
        ALUOp = 3'b010;
        $display("Expected Result: Q = %d", 3);
        #10;


        A = 32'd3;
        B = 32'd4;
        ALUOp = 3'b110;
        $display("Expected Result: Q = %d", -1);
        #10;

        // Apply stimulus for 10 clock cycles;
        repeat (10) begin
            #10; // Wait for rising edge clock 

            $display("A = %h, B = %h, ALUOp = %b", A, B, ALUOp);
            case (ALULOp)
                3'b000: $display("Expected Result: Q = %h", A & B);
                3'b001: $display("Expected Result: Q = %h", A | B);
                3'b010: $display("Expected Result: Q = %h", A + B);
                3'b110: $display("Expected Result: Q = %h", A - B);
                3'b111: 
                    logic exp;
                    if (A < B) begin
                        exp= 1;
                    end else begin
                        exp= 0;
                    end
                    $display("Expected Result: Q = %h", exp);
                default: $display("Expected Result: Q = 0");
            endcase

            $display("Actual Result: %h", Q);

            A = A + 1;
            B = B + 1;
            ALUOp = ALUOp + 1;
        end // repeat

        $finish
    end // initial
endmodule

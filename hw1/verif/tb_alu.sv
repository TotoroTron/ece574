module tb_alu;

    localparam DATA_WIDTH = 32;

    // inputs
    reg [DATA_WIDTH-1:0] A, B;
    reg [2:0] ALUOp;

    // outputs
    wire [DATA_WIDTH-1:0] Q;
    wire Cout;

    // instantiation unit under test 
    alu #(.DATA_WIDTH(DATA_WIDTH)) dut (
        .A(A),
        .B(B),
        .ALUOp(ALUOp),
        .Q(Q),
        .Cout(Cout)
    );

    reg [DATA_WIDTH-1:0] exp;
    reg clk;
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        exp = { (DATA_WIDTH){1'bx} };

        A = 32'd1;
        B = 32'd2;
        ALUOp = 3'b010;
        #10;
        $display("A = %h, B = %h, ALUOp = %b", A, B, ALUOp);
        $display("Expected Result: Q = %h", 3);
        $display("Actual Result:   Q = %h", Q);
        $display();


        A = 32'd3;
        B = 32'd4;
        ALUOp = 3'b110;
        #10;
        $display("A = %h, B = %h, ALUOp = %b", A, B, ALUOp);
        $display("Expected Result: Q = %h", -1);
        $display("Actual Result:   Q = %h", Q);
        $display();

        // Apply stimulus for 10 clock cycles;
        repeat (100) begin
            #10; // Wait for rising edge clock 

            $display("A = %h, B = %h, ALUOp = %b", A, B, ALUOp);
            case (ALUOp)
                3'b000: $display("Expected Result: Q = %h", A & B);
                3'b001: $display("Expected Result: Q = %h", A | B);
                3'b010: $display("Expected Result: Q = %h", A + B);
                3'b110: $display("Expected Result: Q = %h", A - B);
                3'b111: begin
                    if (A < B) begin
                        // exp= 1;
                        exp = { { (DATA_WIDTH-1){1'b0} }, 1'b1};
                    end else begin
                        // exp= 0;
                        exp = { (DATA_WIDTH){1'b0} };
                    end
                    $display("Expected Result: Q = %h", exp);
                end
                default: $display("Expected Result: Q = %h", 0);
            endcase

            $display("Actual Result:   Q = %h", Q);
            $display();

            A = A + 1;
            B = B + 1;
            ALUOp = ALUOp + 1;
        end // repeat

        $finish;
    end // initial
endmodule

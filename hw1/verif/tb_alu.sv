// tb_alu.sv
//
// https://www.asic-world.com/systemverilog/system_task_function4.html

module tb_alu;

    localparam DATA_WIDTH = 32;
    int num_errors = 0;

    // inputs
    reg [DATA_WIDTH-1:0] A, B;
    reg [2:0] ALUOp;

    // outputs
    wire [DATA_WIDTH-1:0] Q;
    // wire Cout;

    // instantiation unit under test 
    alu #(.DATA_WIDTH(DATA_WIDTH)) dut (
        .A(A),
        .B(B),
        .ALUOp(ALUOp),
        .Q(Q)
        // .Cout(Cout)
    );

    reg [DATA_WIDTH-1:0] exp;
    reg clk;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars;

        clk = 0;
        exp = { (DATA_WIDTH){1'bx} };

        A = 32'd1;
        B = 32'd2;
        exp = 3;
        ALUOp = 3'b010;
        #10;
        $display("A = %h, B = %h, ALUOp = %b", A, B, ALUOp);
        assert(Q == exp) $display("SUCCESS! Expected: %h. Actual: %h", Q, exp);
        else $error("FAILED! Expected: %h. Actual: %h", Q, exp);
        $display();


        A = 32'd3;
        B = 32'd4;
        exp = -1;
        ALUOp = 3'b110;
        #10;
        $display("A = %h, B = %h, ALUOp = %b", A, B, ALUOp);
        assert(Q == exp) $display("SUCCESS! Expected: %h. Actual: %h", Q, exp);
        else $error("FAILED! Expected: %h. Actual: %h", Q, exp);
        $display();

        // Apply stimulus for 10 clock cycles;
        repeat (100) begin
            A = $urandom();
            B = $urandom();
            ALUOp = $urandom();

            #10; // Wait for rising edge clock 

            $display("A = %h, B = %h, ALUOp = %b", A, B, ALUOp);
            case (ALUOp)
                3'b000: begin
                    exp = A & B;
                    assert(Q == exp) $display("SUCCESS! Expected: %h. Actual: %h", Q, exp);
                    else begin $error("FAILED! Expected: %h. Actual: %h", Q, exp); num_errors = num_errors + 1; end
                end
                3'b001: begin
                    exp = A | B;
                    assert(Q == exp) $display("SUCCESS! Expected: %h. Actual: %h", Q, exp);
                    else begin $error("FAILED! Expected: %h. Actual: %h", Q, exp); num_errors = num_errors + 1; end
                end
                3'b010: begin
                    exp = A + B;
                    assert(Q == exp) $display("SUCCESS! Expected: %h. Actual: %h", Q, exp);
                    else begin $error("FAILED! Expected: %h. Actual: %h", Q, exp); num_errors = num_errors + 1; end
                end
                3'b110: begin
                    exp = A - B;
                    assert(Q == exp) $display("SUCCESS! Expected: %h. Actual: %h", Q, exp);
                    else begin $error("FAILED! Expected: %h. Actual: %h", Q, exp); num_errors = num_errors + 1; end
                end
                3'b111: begin
                    if (A < B) begin
                        exp = { { (DATA_WIDTH-1){1'b0} }, 1'b1}; // exp = 1
                    end else begin
                        exp = { (DATA_WIDTH){1'b0} }; // exp = 0
                    end
                    assert(Q == exp) $display("SUCCESS! Expected: %h. Actual: %h", Q, exp);
                    else begin $error("FAILED! Expected: %h. Actual: %h", Q, exp); num_errors = num_errors + 1; end
                end
                default: begin
                    exp = 0;
                    assert(Q == exp) $display("SUCCESS! Expected: %h. Actual: %h", Q, exp);
                    else begin $error("FAILED! Expected: %h. Actual: %h", Q, exp); num_errors = num_errors + 1; end
                end
            endcase

            $display();

        end // repeat

        $display();
        $display("Total number of errors: %d", num_errors);
        $display();

        $finish;
    end // initial
endmodule

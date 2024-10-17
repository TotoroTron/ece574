
// tb_mult3detect.sv
//
// https://www.asic-world.com/systemverilog/system_task_function4.html

module tb_mult3detect;

    // testbench signals
    localparam DATA_WIDTH = 32;
    int num_errors;
    reg [DATA_WIDTH-1:0] tb_word;
    reg tb_exp; // expected output value of tb_dout
    reg tb_err;
    reg tb_clk;
    reg tb_rst;
    reg tb_din;
    wire tb_dout;

    // dut instantiation
    mult3detect #(.DATA_WIDTH(DATA_WIDTH)) dut (
        .i_clk(tb_clk),
        .i_rst(tb_rst),
        .i_din(tb_din),
        .o_dout(tb_dout)
    );

    task assert_and_report(input expected, input actual);
    begin
        if (actual == expected) begin
            $display("SUCCESS! Expected: %h, Actual: %h", expected, actual);
            tb_err = 1'b0;
        end else begin
            $display("FAILURE! Expected: %h, Actual: %h", expected, actual);
            num_errors = num_errors + 1;
            tb_err = 1'bx;
        end
    end
    endtask // assert_and_report

    int ones_count;
    task test_word(input [DATA_WIDTH-1:0] word);
    begin
        for (int i = 0; i < DATA_WIDTH; i++) begin
            if (word[i] == 1) begin
                ones_count++;
            end
        end
        $display("Ones count: %d", ones_count);
        if (ones_count % 3 == 0)    begin tb_exp = 1; end
        else                        begin tb_exp = 0; end
        // serialize word, LSB first in
        for (int i = 0; i < DATA_WIDTH; i++) begin
            tb_din = word[i];
            #10;
        end
        #20; // wait 2 clock cycles for output because dut uses 3-always-block model
        assert_and_report(tb_exp, tb_dout);
        ones_count = 0;
        tb_din = 0;
        tb_rst = 1; // reset the dut
        #20; // 2 clock cycles
        tb_rst = 0;
    end
    endtask // test_word

    always #5 tb_clk = ~tb_clk; // 100MHz clock
    int count = 0;

    initial begin
        $display("Beginning simulation...");
        $dumpfile("waveform.vcd");
        $dumpvars;

        num_errors = 0;
        tb_clk = 1;
        tb_rst = 1;
        tb_exp = 1'bx;

        #20; // buffer first 2 clock cycles to flush X's

        repeat (100) begin
            tb_rst = 0;
            tb_word = $urandom();
            $display("Word: %h = %b", tb_word, tb_word);
            test_word(tb_word);
            $display();
        end

        $display();
        $display("Total number of errors: %d", num_errors);
        $display();

        $finish;
    end // initial
endmodule

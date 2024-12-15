
module tb_memory_modelling;

    localparam DATA_WIDTH = 16;
    localparam RAM_DEPTH = 8;
    reg tb_clk;
    reg tb_rst;
    reg tb_en;
    reg [DATA_WIDTH-1:0] tb_a [0:RAM_DEPTH-1];
    reg [DATA_WIDTH-1:0] tb_b;

    wire [DATA_WIDTH-1:0] dut_sum;

    int num_errors = 0;
    reg [DATA_WIDTH:0] tb_exp_sum;

    top_level
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .RAM_DEPTH(RAM_DEPTH)
    ) top_level_inst (

        .i_clk(tb_clk),
        .i_rst(tb_rst),
        .i_en(tb_en),
        .iv_b(tb_b),
        .ov_sum(dut_sum)
    );

    task assert_and_report(input [DATA_WIDTH-1:0] expected, input [DATA_WIDTH-1:0] actual);
    begin
        if (actual == expected) begin
            $display(" SUCCESS!\n  Expected: %b\n  Actual:   %b", expected, actual);
        end else begin
            $display(" FAILURE!\n  Expected: %b\n  Actual:   %b", expected, actual);
            num_errors = num_errors + 1;
        end
    end
    endtask // assert_and_report

    always_comb begin
        tb_exp_sum = '0;
        for (int i = 0; i < RAM_DEPTH; i = i + 1) begin
            tb_exp_sum += tb_b * tb_a[i];
        end
    end

    always #5 tb_clk = ~tb_clk;
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars;

        tb_a[0] = 16'd111;
        tb_a[1] = 16'd222;
        tb_a[2] = 16'd333;
        tb_a[3] = 16'd25;
        tb_a[4] = 16'd26;
        tb_a[5] = 16'd27;
        tb_a[6] = 16'd28;
        tb_a[7] = 16'd29;

        num_errors = 0;
        tb_clk = 1;
        tb_rst = 1;
        tb_en = 0;

        @(posedge tb_clk);
        tb_rst = 0;
        tb_en = 0;
        @(posedge tb_clk);

        repeat (100) begin
            tb_b = $urandom() & 6'b111111;
            repeat(9) begin
                tb_rst = 0;
                tb_en = 1;
                @(posedge tb_clk);
            end
            tb_en = 0;
            assert_and_report(tb_exp_sum, dut_sum);
            @(posedge tb_clk);
            tb_rst = 1;
            $display();
            repeat (20) begin
                @(posedge tb_clk);
            end
        end

        $display();
        $display("Total number of errors: %d", num_errors);
        $display();

        $finish;
    end // initial


    initial begin
        #1ms;
        $display("Simulation terminated after 1 millisecond.");
        $finish;
    end // initial
endmodule

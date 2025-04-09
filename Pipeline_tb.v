module tb();

    reg clk=0, rst;
    
    always begin
        clk = ~clk;
        #50;
    end

    initial begin
        rst <= 1'b1;
        #200;
        rst <= 1'b0;
        #1000;
        $finish;    
    end

    initial begin
        $dumpfile("final_dump.vcd");
        $dumpvars(0);
    end

    Pipeline_top dut (.clk(clk), .rst(rst));
endmodule
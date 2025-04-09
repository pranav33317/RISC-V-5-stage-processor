module tb();
reg clk,rst;
reg [1:0] ResultSrcW;
reg [31:0] PCPlus4W,ALU_ResultW,ReadDataW;
wire [31:0] ResultW;
// instantiate module :
writeback_cycle dut (clk,rst, ResultSrcW, PCPlus4W, ALU_ResultW, ReadDataW, ResultW);
// clock :
always begin 
    clk = ~ clk;
    #50;
end

// initliase control signals 
initial begin
    rst <= 1'b1;
    #300;
    PCPlus4W<=32'h0062F433;
    ALU_ResultW<=32'h00000100;
    ReadDataW<=32'h0c0f0000;
    ResultSrcW<=2'b00;
    #100;
    ResultSrcW<=2'b10;
    #100;
    ResultSrcW<=2'b01;
    #100;
    ResultSrcW<=2'b00;
    #100;
    ResultSrcW<=2'b11;
    #100;
    $finish;

end

initial begin
    $dumpfile("writeback_dump.vcd");
    $dumpvars(0,tb);
end
endmodule
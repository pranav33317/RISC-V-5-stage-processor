module tb();
reg clk=0,rst,RegWriteM,MemWriteM;
reg [1:0] ResultSrcM;
reg [4:0] RD_M;
reg [31:0] PCPlus4M,WriteDataM,ALU_ResultM;
wire RegWriteW;
wire [1:0] ResultSrcW;
wire [4:0] RD_W;
wire [31:0] PCPlus4W,ALU_ResultW,ReadDataW;
// module under test
memory_cycle dut (clk,rst, RegWriteM, MemWriteM, ResultSrcM,RD_M,PCPlus4M, WriteDataM, 
    ALU_ResultM, RegWriteW,ResultSrcW, RD_W, PCPlus4W,ALU_ResultW, ReadDataW);
// generate clock
always begin
    clk = ~clk;
    #50;
end
// initialise control signals
initial begin
    rst <= 1'b1;
    #300;
    rst <= 1'b0;
    RegWriteM <= 1'b0;
    MemWriteM <= 1'b1;
    ResultSrcM <= 2'b01;
    ALU_ResultM <= 32'h00000080;
    WriteDataM <= 32'h0000d000;
    RD_M <= 32'h00600000;
    PCPlus4M <= 32'h00e00000;
    #500;
    $finish;
end

// create VCD file:
initial begin
    $dumpfile("memory_dump.vcd");
    $dumpvars(0,tb);
end
endmodule
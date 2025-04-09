module tb();
// instantiate module :
reg clk=1,rst,RegWriteW;
reg [4:0] RDW;
reg [31:0] InstrD,PCD,PCPlus4D,ResultW;
wire RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE;
wire [1:0]  ResultSrcE;
wire [4:0] RdE;
wire [2:0] ALUControlE;
wire [31:0] RD1E,RD2E,Imm_ExtE,PCE,PCPlus4E;
decode_cycle dut(clk,rst,InstrD,PCD, PCPlus4D,RDW,ResultW,RegWriteE,
 ResultSrcE, MemWriteE, JumpE, BranchE, ALUControlE, ALUSrcE, RD1E, RD2E, PCE, RdE, Imm_ExtE,  PCPlus4E);
// generate clock
always begin
    clk = ~clk;
    #50;
end

// initliase the control signals :
initial begin
    rst <= 1'b1;
    #300;
    rst <= 1'b0;
    InstrD<=32'h0062F433; //  TAKEN FROM FETCH STAGE , look in doc
    PCD<=32'h00000000;
    PCPlus4D<=32'h00000000;
    RDW<=5'b00000;
    ResultW<=32'h00000000;
    #500;
    $finish;
end

// create VCD file:
initial begin
    $dumpfile("decode_dump.vcd");
    $dumpvars(0,tb);
end
endmodule
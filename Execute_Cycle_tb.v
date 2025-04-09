module tb();
reg clk = 1, rst,RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE;
reg [1:0] ResultSrcE;
reg [2:0] ALUControlE;
reg [31:0] RD1_E,RD2_E,PCE,Imm_Ext_E,PCPlus4E;
reg [4:0] RD_E;
wire PCSrcE,RegWriteM,MemWriteM;
wire [1:0] ResultSrcM;
wire [31:0] PCTargetE,ALU_ResultM,WriteDataM,PCPlus4M;
wire [4:0] RD_M;
// INSTANTIATE THE MODULE:
execute_cycle dut(
    .clk(clk),.rst(rst) , .RegWriteE(RegWriteE) , .MemWriteE(MemWriteE) , .JumpE(JumpE),
    .BranchE(BranchE) , .ALUSrcE(ALUSrcE) , .ResultSrcE(ResultSrcE) , .ALUControlE(ALUControlE),
    .RD1_E(RD1_E) , .RD2_E(RD2_E), .PCE(PCE) , .Imm_Ext_E(Imm_Ext_E) , .PCPlus4E(PCPlus4E),
    .RD_E(RD_E), .PCSrcE(PCSrcE), .RegWriteM(RegWriteM), .MemWriteM(MemWriteM),
    .ResultSrcM(ResultSrcM), .PCTargetE(PCTargetE), .ALU_ResultM(ALU_ResultM),
    .WriteDataM(WriteDataM), .PCPlus4M(PCPlus4M) , .RD_M(RD_M) );

always begin 
    clk = ~ clk;
    #50;
end
// initliase control signals 
initial begin
    rst <= 1'b1;
    #300;
    rst <= 1'b0;
    RegWriteE <= 1'b0;
    MemWriteE <= 1'b0;
    JumpE <= 1'b0;
    BranchE <= 1'b0;
    ALUSrcE <= 1'b0;
    ResultSrcE <= 2'b00;
    ALUControlE <= 3'b000;
    RD1_E <= 32'h00000010;
    RD2_E <= 32'h00000100;
    PCPlus4E <= 32'h10000000;
    PCE <= 32'h0000000a;
    Imm_Ext_E <= 32'h0000000f;
    RD_E <= 5'h0c;
    #500;
    $finish;
end

initial begin
    $dumpfile("execute_dump.vcd");
    $dumpvars(0,tb);
end

endmodule
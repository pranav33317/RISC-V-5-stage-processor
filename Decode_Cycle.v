`include "Register_File.v"
`include "Sign_Extend.v"
`include "Control_Unit_Top.v"

module decode_cycle(
    input clk,
    input rst,
    input [31:0] InstrD,
    input [31:0] PCD,
    input [31:0] PCPlus4D,
    input [4:0] RDW,
    input [31:0] ResultW,
    output RegWriteE,
    output [1:0] ResultSrcE,
    output MemWriteE,
    output JumpE,
    output BranchE,
    output [2:0] ALUControlE,
    output ALUSrcE,
    output [31:0] RD1E,
    output [31:0] RD2E,
    output [31:0] PCE,
    output [4:0] RdE,
    output [31:0] Imm_ExtE,
    output [31:0] PCPlus4E
);

// INSTANTIATE THE MODULES :
// CONTROL UNIT :
wire RegWriteD, MemWriteD, JumpD, ALUSrcD, BranchD;
wire [1:0] ImmSrcD, ResultSrcD;
wire [2:0] ALUControlD;
Control_Unit_Top control_unit (
    .Op(InstrD[6:0]),
    .RegWrite(RegWriteD),
    .ImmSrc(ImmSrcD),
    .ALUSrc(ALUSrcD),
    .MemWrite(MemWriteD),
    .ResultSrc(ResultSrcD),
    .Branch(BranchD),
    .funct3(InstrD[14:12]),
    .funct7(InstrD[30]),
    .ALUControl(ALUControlD),
    .Jump(JumpD)
);

// SIGN EXTENDER :
wire [31:0] Imm_ExtD;
Sign_Extend sign_extender ( // In,Imm_Ext,ImmSrc
    .In(InstrD[31:20]),
    .Imm_Ext(Imm_ExtD),
    .ImmSrc(ImmSrcD)
);

// REGISTER FILE :
wire [31:0] RD1_D, RD2_D;
Register_File reg_file (
    clk,rst,RegWriteW,ResultW,InstrD[19:15],InstrD[24:20],RDW,RD1_D,RD2_D
);

// DECODE REGISTERS (Registers to hold the intermediate values between stages) :
reg RegWriteD_R, MemWriteD_R, JumpD_R, ALUSrcD_R, BranchD_R;
reg [1:0] ImmSrcD_R, ResultSrcD_R;
reg [2:0] ALUControlD_R;
reg [31:0] Imm_ExtD_R;
reg [31:0] RD1_D_R, RD2_D_R, PCD_in_R, PCPlus4D_R;
reg [4:0] RdD_R;
// Clocked process to update the register values on each clock cycle
always @(posedge clk) begin
    if (rst == 1'b1) begin
        // Reset all registers
        RegWriteD_R <= 1'b0;
        ResultSrcD_R <= 2'b00; // Default, points to ALU computed result
        ALUSrcD_R <= 1'b0;
        MemWriteD_R <= 1'b0;
        BranchD_R <= 1'b0;
        ALUControlD_R <= 3'b000;
        RD1_D_R <= 32'h00000000;
        RD2_D_R <= 32'h00000000;
        Imm_ExtD_R <= 32'h00000000;
        RdD_R <= 5'b00000;
        PCD_in_R <= 32'h00000000;
        PCPlus4D_R <= 32'h00000000;
    end else begin
        // Update registers with current values
        RegWriteD_R <= RegWriteD;
        ResultSrcD_R <= ResultSrcD;
        ALUSrcD_R <= ALUSrcD;
        MemWriteD_R <= MemWriteD;
        BranchD_R <= BranchD;
        ALUControlD_R <= ALUControlD;
        RD1_D_R <= RD1_D;
        RD2_D_R <= RD2_D;
        Imm_ExtD_R <= Imm_ExtD;
        RdD_R <= InstrD[11:7];
        PCD_in_R <= PCD;
        PCPlus4D_R <= PCPlus4D;
    end
end

// Assign the output signals from the registers
assign RegWriteE = RegWriteD_R;
assign ResultSrcE = ResultSrcD_R;
assign MemWriteE = MemWriteD_R;
assign JumpE = JumpD_R;
assign BranchE = BranchD_R;
assign ALUControlE = ALUControlD_R;
assign ALUSrcE = ALUSrcD_R;
assign RD1E = RD1_D_R;
assign RD2E = RD2_D_R;
assign PCE = PCD_in_R;
assign RdE = RdD_R;
assign Imm_ExtE = Imm_ExtD_R;
assign PCPlus4E = PCPlus4D_R;

endmodule

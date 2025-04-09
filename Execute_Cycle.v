`include "Mux.v"
`include "ALU.v"
`include "PC_Adder.v"
module execute_cycle(input clk, input rst, input RegWriteE,input ALUSrcE,input MemWriteE,input [1:0] ResultSrcE, input BranchE,input [2:0] ALUControlE, input JumpE,
    input [31:0] RD1_E,input [31:0] RD2_E,input [31:0] Imm_Ext_E,input [4:0] RD_E,input [31:0] PCE,input [31:0] PCPlus4E,output  PCSrcE,output [31:0] PCTargetE,output RegWriteM,output MemWriteM,output [1:0] ResultSrcM,output [4:0] RD_M,output [31:0] PCPlus4M,output [31:0] WriteDataM,output [31:0] ALU_ResultM);

    // Declaration I/Os
    // input [31:0] ResultW;
    // input [1:0] ForwardA_E, ForwardB_E;

    // Declaration of Interim Wires
    //wire [31:0] Src_A, Src_BE, Src_B;
    wire [31:0] Src_BE;
    wire [31:0] ALU_ResultE,WriteDataE;
    wire ZeroE;
    // Declaration of Register
    reg RegWriteE_r, MemWriteE_r;
    reg [1:0]  ResultSrcE_r;
    reg [4:0] RD_E_r;
    reg [31:0] PCPlus4E_r, WriteDataE_r,ALU_ResultE_r;
    
    assign WriteDataE=RD2_E;

    // Declaration of Modules
    // Mux
    Mux mux1 (
                        .a(RD2_E),
                        .b(Imm_Ext_E),
                        .c(Src_BE),
                        .s(ALUSrcE)
                        );

    // ALU Unit
    ALU alu (
            .A(RD1_E),
            .B(Src_BE),
            .Result(ALU_ResultE),
            .ALUControl(ALUControlE),
            .OverFlow(),
            .Carry(),
            .Zero(ZeroE),
            .Negative()
            );

    // Adder
    PC_Adder branch_adder (
            .a(PCE),
            .b(Imm_Ext_E),
            .c(PCTargetE)
            );

    // Register Logic
    always @(posedge clk) begin
        if(rst == 1'b1) begin
            RegWriteE_r <= 1'b0; 
            MemWriteE_r <= 1'b0; 
            ResultSrcE_r <= 2'b00;
            RD_E_r <= 5'h00;
            PCPlus4E_r <= 32'h00000000; 
            WriteDataE_r <= 32'h00000000; 
            ALU_ResultE_r <= 32'h00000000;
        end
        else begin
            RegWriteE_r <= RegWriteE; 
            MemWriteE_r <= MemWriteE; 
            ResultSrcE_r <= ResultSrcE;
            RD_E_r <= RD_E;
            PCPlus4E_r <= PCPlus4E; 
            WriteDataE_r <= WriteDataE; 
            ALU_ResultE_r <= ALU_ResultE;
        end
    end

    // Output Assignments
    assign PCSrcE = ((ZeroE & BranchE) | JumpE );
    assign RegWriteM = RegWriteE_r;
    assign MemWriteM = MemWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign RD_M = RD_E_r;
    assign PCPlus4M = PCPlus4E_r;
    assign WriteDataM = WriteDataE_r;
    assign ALU_ResultM = ALU_ResultE_r;

endmodule
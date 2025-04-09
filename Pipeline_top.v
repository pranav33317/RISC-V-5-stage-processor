

`include "Fetch_Cycle.v"
`include "Decode_Cycle.v"
`include "Execute_Cycle.v"
`include "Memory_Cycle.v"
`include "Writeback_Cycle.v"    
// `include "PC.v"
// `include "PC_Adder.v"
// `include "Mux.v"
// `include "Instruction_Memory.v"
// `include "Control_Unit_Top.v"
// `include "Register_File.v"
// `include "Sign_Extend.v"
// `include "ALU.v"
// `include "Data_Memory.v"
// `include "Hazard_unit.v"


module Pipeline_top(clk, rst);

    // Declaration of I/O
    input clk, rst;

    // Declaration of Interim Wires
    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, BranchE, RegWriteM, MemWriteM,JumpE;
    wire [2:0] ALUControlE;
    wire [4:0] RD_E, RD_M, RDW;
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RD1_E, RD2_E, Imm_Ext_E, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALU_ResultM;
    wire [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    wire [4:0] RS1_E, RS2_E;
    wire [1:0] ForwardBE, ForwardAE, ResultSrcE,ResultSrcM, ResultSrcW;
    

    // Module Initiation
    // Fetch Stage
    fetch_cycle Fetch (
                        .clk(clk), 
                        .rst(rst), 
                        .PCSrcE(PCSrcE), 
                        .PCTargetE(PCTargetE), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D)
                    );

    // Decode Stage
    decode_cycle Decode (
                        clk, 
                        rst, 
                        InstrD,
                        PCD,
                        PCPlus4D,
                        RDW,
                        ResultW,
                        RegWriteE,
                        ResultSrcE,
                        MemWriteE,
                        JumpE,
                        BranchE,
                        ALUControlE,
                        ALUSrcE,
                        RD1_E,
                        RD2_E,
                        PCE,
                        RD_E,
                        Imm_Ext_E,
                        PCPlus4E
                    );

    // Execute Stage
    execute_cycle Execute (
                        clk, 
                        rst, 
                        RegWriteE,
                        ALUSrcE,
                        MemWriteE,
                        ResultSrcE,
                        BranchE,
                        ALUControlE,
                        JumpE,
                        RD1_E,
                        RD2_E,
                        Imm_Ext_E,
                        RD_E,
                        PCE,
                        PCPlus4E,
                        PCSrcE,
                        PCTargetE,
                        RegWriteM,
                        MemWriteM,
                        ResultSrcM,
                        RD_M,
                        PCPlus4M,
                        WriteDataM, 
                        ALU_ResultM);

                    
    
    // Memory Stage
    memory_cycle Memory (
                        .clk(clk), 
                        .rst(rst), 
                        .RegWriteM(RegWriteM), 
                        .MemWriteM(MemWriteM), 
                        .ResultSrcM(ResultSrcM), 
                        .RD_M(RD_M), 
                        .PCPlus4M(PCPlus4M), 
                        .WriteDataM(WriteDataM), 
                        .ALU_ResultM(ALU_ResultM), 
                        .RegWriteW(RegWriteW), 
                        .RD_W(RDW), 
                        .PCPlus4W(PCPlus4W), 
                        .ALU_ResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW)
                    );

    // Write Back Stage
    writeback_cycle WriteBack (
                        .clk(clk), 
                        .rst(rst), 
                        .ResultSrcW(ResultSrcW), 
                        .PCPlus4W(PCPlus4W), 
                        .ALU_ResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW), 
                        .ResultW(ResultW)
                    );

    // Hazard Unit
    // hazard_unit Forwarding_block (
    //                     .rst(rst), 
    //                     .RegWriteM(RegWriteM), 
    //                     .RegWriteW(RegWriteW), 
    //                     .RD_M(RD_M), 
    //                     .RD_W(RDW), 
    //                     .Rs1_E(RS1_E), 
    //                     .Rs2_E(RS2_E), 
    //                     .ForwardAE(ForwardAE), 
    //                     .ForwardBE(ForwardBE)
    //                     );
endmodule
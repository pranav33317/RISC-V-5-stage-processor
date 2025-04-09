`include "Mux.v"
module writeback_cycle(input clk,input rst,input [1:0] ResultSrcW,input [31:0] PCPlus4W,input [31:0] ALU_ResultW, input [31:0] ReadDataW,output [31:0] ResultW);
 
// Declaration of Module
// we need 3*1 mux , so use 2 mux
//
// first mux has ALU_ResultW at 0 , pcplus4w
// second mux first mux output at 0 , ReadDataW at 1 
// 00 -> ALU Result
// 01 -> 
wire [31:0] intermediate_mux;
Mux mux1 (    
                .a(ALU_ResultW),
                .b(PCPlus4W),
                .s(ResultSrcW[1]),
                .c(intermediate_mux)
                );

Mux mux2 (    
                .a(intermediate_mux),
                .b(ReadDataW),
                .s(ResultSrcW[0]),
                .c(ResultW)
                );
endmodule
`include "Mux.v"
`include "PC.v"
`include "PC_Adder.v"
`include "Instruction_Memory.v"
module fetch_cycle(input clk ,input rst , input PCSrcE, input [31:0] PCTargetE,output [31:0] InstrD, output [31:0] PCD, output [31:0]  PCPlus4D);
// module variables 
wire [31:0] PCPlus4F,PCF,PCF_out,Instr_mem;
// PC Mux
Mux pc_mux (PCPlus4F,PCTargetE,PCSrcE,PCF_out);
// register which stores addr
PC_Module pc_reg(clk,rst,PCF,PCF_out);
// FETCH CYLCLE PIPELINE REGISTER:
reg [31:0] InstrD_F, PCD_F,PCPlus4D_F;
always @(posedge clk) begin
    // if reset , then set all to 0
    if (rst==1'b1) begin
        InstrD_F<=32'h00000000;
        PCD_F<=32'h00000000;
        PCPlus4D_F<=32'h00000000;
    end
    // else assign them the values 
    else begin
        InstrD_F<=Instr_mem;
        PCD_F<=PCF;
        PCPlus4D_F<=PCPlus4F;
    end
end
// Adder which finds pc+4
PC_Adder p1 (PCF,32'h00000004,PCPlus4F);
// instr memory
Instruction_Memory MEM(rst,PCF,Instr_mem);
// fetch stage complete
// now assign the register values to the outputs of the module:
assign InstrD    = (rst == 1'b0) ? InstrD_F : 32'h00000000;
assign PCD       = (rst == 1'b0) ? PCD_F : 32'h00000000;
 assign PCPlus4D = (rst == 1'b0) ? PCPlus4D_F : 32'h00000000;
endmodule
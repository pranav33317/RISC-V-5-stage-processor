`include "Data_Memory.v"
module memory_cycle(input clk, input rst,input RegWriteM,input MemWriteM,input [1:0] ResultSrcM,input [4:0] RD_M,input [31:0] PCPlus4M,input [31:0] WriteDataM, 
    input [31:0] ALU_ResultM, output RegWriteW,output [1:0] ResultSrcW,output [4:0] RD_W,output [31:0] PCPlus4W,output [31:0] ALU_ResultW,output [31:0] ReadDataW);
    
    // Declaration of Interim Wires
     wire [31:0] ReadDataM;

    // Declaration of Interim Registers
    reg RegWriteM_r;
    reg [1:0] ResultSrcM_r;
    
    reg [4:0] RD_M_r;
    reg [31:0] PCPlus4M_r, ALU_ResultM_r, ReadDataM_r;

    // Declaration of Module Initiation
    Data_Memory dmem (
                        .clk(clk),
                        .rst(rst),
                        .WE(MemWriteM),
                        .WD(WriteDataM),
                        .A(ALU_ResultM),
                        .RD(ReadDataM)
                    );

    // Memory Stage Register Logic
    always @(posedge clk) begin
        if (rst == 1'b1) begin
            RegWriteM_r <= 1'b0; 
            ResultSrcM_r <= 2'b00;
            RD_M_r <= 5'h00;
            PCPlus4M_r <= 32'h00000000; 
            ALU_ResultM_r <= 32'h00000000; 
            ReadDataM_r <= 32'h00000000;
        end
        else begin
            RegWriteM_r <= RegWriteM; //done
            ResultSrcM_r <= ResultSrcM; // done
            RD_M_r <= RD_M; // done
            PCPlus4M_r <= PCPlus4M; // done
            ALU_ResultM_r <= ALU_ResultM; // done
            ReadDataM_r <= ReadDataM; // done
        end
    end 

    // Declaration of output assignments
    assign RegWriteW = RegWriteM_r;
    assign ResultSrcW = ResultSrcM_r;
    assign RD_W = RD_M_r;
    assign PCPlus4W = PCPlus4M_r;
    assign ALU_ResultW = ALU_ResultM_r;
    assign ReadDataW = ReadDataM_r;

endmodule
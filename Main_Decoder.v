

module Main_Decoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp);
    input [6:0]Op;
    output RegWrite,ALUSrc,MemWrite,Branch,Jump;
    output [1:0]ImmSrc,ALUOp,ResultSrc;

    assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011 | Op == 7'b0010011 | Op == 7'b1101111) ? 1'b1 :
                                                              1'b0 ;
    assign ImmSrc = (Op == 7'b0000011 | Op == 7'b0010011) ? 2'b00 : 
                    (Op == 7'b0100011) ? 2'b01 :  
                    (Op == 7'b1100011) ? 2'b10 :
                    (Op == 7'b1101111) ? 2'b11 :
                     2'bxx;
                                         
    assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011 | Op == 7'b0010011) ? 1'b1 :
                    (Op == 7'b1101111) ? 1'bx : 1'b0 ;
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 :
                                           1'b0 ;
    assign ResultSrc = (Op == 7'b0110011 | Op == 7'b0010011) ? 2'b00 :
                        (Op == 7'b0000011) ? 2'b01 :
                        (Op == 7'b1101111) ? 2'b10 : 2'bxx ; 
    assign Branch = (Op == 7'b1100011) ? 1'b1 :
                                         1'b0 ;
    assign ALUOp = (Op == 7'b0110011 | Op == 7'b0010011) ? 2'b10 :
                   (Op == 7'b0100011 | Op == 7'b0000011) ? 2'b00 :
                   (Op == 7'b1100011) ? 2'b01 :
                                        2'bxx ; 
    assign Jump = (Op == 7'b1101111) ? 1'b1 : 1'b0;
    

    // New OPCODE = 1111111

endmodule
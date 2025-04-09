module tb();
// module to test:
// inputs are regs:
reg clk=1,rst,PC_SrcE;
reg [31:0] PCTargetE;
// outputs are wires
wire [31:0] InstrD,PCD,PCPlus4D;
// instantiate module:
fetch_cycle dut(clk,rst,PC_SrcE,PCTargetE,InstrD,PCD,PCPlus4D);
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
    PC_SrcE<=1'b0;
    PCTargetE <= 32'h00000000;
    #500;
    $finish;
end

// create VCD file:
initial begin
    $dumpfile("fetch_dump.vcd");
    $dumpvars(0,tb);
end


endmodule
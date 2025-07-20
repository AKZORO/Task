`timescale 1ns/1ps


module tbinstructions;
reg [4:0] pc;
reg clk;
reg reset;
reg [4:0] r1;
reg [3:0] r2;

wire [18:0] instructions;
wire [4:0] updatedpc;


instruction memory(
.pc(pc),
.clk(clk),
.reset(reset),
.r1(r1),
.r2(r2),
.instructions(instructions),
.updatedpc(updatedpc)
);


always #5 clk = ~clk;

initial begin

clk = 0;
reset = 1;
pc = 0;
r1 = 0;
r2 = 0;


#10 reset = 0;


#10 pc = 0;
#10 $display("JMP Test: PC=%d, Updated_PC=%d, Instructions=%b", pc, updatedpc, instructions);

r1 = 5'b00001;
r2 = 4'b0001; 
#10 pc = 1; 
#10 $display("BEQ Test (True): PC=%d, Updated_PC=%d, Instructions=%b", pc, updatedpc, instructions);

r1 = 5'b00001;
r2 = 5'b0010; 
#10 pc = 1; 
#10 $display("BEQ Test (False): PC=%d, Updated_PC=%d, Instructions=%b", pc, updatedpc, instructions);


r1 = 5'b00001;
r2 = 5'b0010; 
#10 pc = 2; 
#10 $display("BNE Test (True): PC=%d, Updated_PC=%d, Instructions=%b", pc, updatedpc, instructions);

r1 = 5'b00001;
r2 = 5'b0001; 
#10 pc = 2;
#10 $display("BNE Test (False): PC=%d, Updated_PC=%d, Instructions=%b", pc, updatedpc, instructions);


#10 pc = 3;
#10 $display("CALL Test: PC=%d, Updated_PC=%d, Instructions=%b", pc, updatedpc, instructions);


#10 pc = 4;
#10 $display("RET Test: PC=%d, Updated_PC=%d, Instructions=%b", pc, updatedpc, instructions);


#50 $finish;
end
endmodule
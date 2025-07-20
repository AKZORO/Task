`timescale 1ns/1ps

module tbalu;
reg clk, reset;
reg [5:0] opcode;
reg [18:0] r2, r3;
reg [2:0] imm;
reg aluen;
wire [18:0] r1;
wire [7:0] FLAG;

alu ALU (
.clk(clk),
.reset(reset),
.opcode(opcode),
.r2(r2),
.r3(r3),
.imm(imm),
.aluen(aluen),
.r1(r1),
.FLAG(FLAG)
);


always #5 clk = ~clk;

initial begin

clk = 0;
reset = 1;
aluen = 0;
opcode = 6'b0;
r2 = 19'b0;
r3 = 19'b0;
imm = 3'b0;


#10 reset = 0;

#10 aluen = 1; opcode = 6'b000001; r2 = 19'd10; r3 = 19'd15;
#10 $display("ADD: r2=%d, r3=%d, r1=%d, FLAG=%b", r2, r3, r1, FLAG);

#10 opcode = 6'b000010; r2 = 19'd20; r3 = 19'd5;
#10 $display("SUB: r2=%d, r3=%d, r1=%d, FLAG=%b", r2, r3, r1, FLAG);

#10 opcode = 6'b000011; r2 = 19'd3; r3 = 19'd4;
#10 $display("MUL: r2=%d, r3=%d, r1=%d, FLAG=%b", r2, r3, r1, FLAG);

#10 opcode = 6'b000100; r2 = 19'd40; r3 = 19'd8;
#10 $display("DIV: r2=%d, r3=%d, r1=%d, FLAG=%b", r2, r3, r1, FLAG);

#10 opcode = 6'b000100; r2 = 19'd10; r3 = 19'd0;
#10 $display("DIV (Divide by Zero): r2=%d, r3=%d, r1=%d, FLAG=%b", r2, r3, r1, FLAG);

#10 opcode = 6'b000111; r2 = 19'b1010101010101010101; r3 = 19'b1100110011001100110;
#10 $display("AND: r2=%b, r3=%b, r1=%b, FLAG=%b", r2, r3, r1, FLAG);

#10 opcode = 6'b001000; r2 = 19'b1010101010101010101; r3 = 19'b1100110011001100110;
#10 $display("OR: r2=%b, r3=%b, r1=%b, FLAG=%b", r2, r3, r1, FLAG);

#10 opcode = 6'b001001; r2 = 19'b1010101010101010101; r3 = 19'b1100110011001100110;
#10 $display("XOR: r2=%b, r3=%b, r1=%b, FLAG=%b", r2, r3, r1, FLAG);

#10 opcode = 6'b001011; r2 = 19'b1010101010101010101;
#10 $display("NOT: r2=%b, r1=%b, FLAG=%b", r2, r1, FLAG);

#10 opcode = 6'b111111;
#10 $display("Default: r2=%d, r3=%d, r1=%d, FLAG=%b", r2, r3, r1, FLAG);


#10 aluen = 0;
#10 $stop;
end
endmodule
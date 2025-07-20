`timescale 1ns/1ps

module cputop(
    input clk,
    input reset,
    output [18:0] pcout,
    output [18:0] aluout

);

wire [18:0] dataout;

wire [18:0] instructions;
wire [5:0] opcode;
wire [4:0] rd, rs;
wire [2:0] imm;
wire [18:0] regdata1, regdata2, aluresult, memdata;
wire memwrite, memread, aluen, branch;
wire [7:0] FLAG;

alu aluunit(
    .clk(clk),
    .reset(reset),
    .opcode(opcode),
    .r2(regdata1),
    .r3(regdata2),
    .imm(imm),
    .aluen(aluen),
    .r1(aluresult),
    .FLAG(FLAG)
);

instruction item(

    .pc(pcout),
    .instructions(instructions)
);

assign opcode = instructions[18:13];
assign rd = instructions[12:8];
assign rs = instructions[7:3];
assign imm = instructions[2:0];

regfile reg_file(

    .clk(clk),
    .reset(reset),
    .rs(rs),
    .rd(rd),
    .aluresult(aluresult),
    .regdata1(regdata1),
    .regdata2(regdata2)
);

datamemory datainst(

    .clk(clk),
    .addr(aluresult),
    .r1(memdata),
    .LD(memread),
    .ST(memwrite)
);

programcounter proc(
    .clk(clk),
    .reset(reset),
    .branch(branch),
    .imm(imm),
    .pcout(pcout)
);

custominst custom(
    .clk(clk),
    .instructions(instructions),
    .r1(r1),
    .r2(r2),
    .dataout(dataout)
);

assign aluout = r1;

    
endmodule
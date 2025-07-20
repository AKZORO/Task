`timescale 1ns/1ps

module datamemory(
    input clk,
    input LD,
    input ST,
    input [18:0] addr,
    input [18:0] datain,
    output reg [18:0] r1
);

reg [18:0] memory [0:31] ;

always @(posedge clk) begin
    if(LD)
        memory[addr] = datain;
    
end
always @(posedge clk ) begin
    if(ST)
    r1 = memory[addr];
    
end
    
endmodule
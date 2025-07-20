`timescale 1ns/1ps

module regfile (
    input clk,
    input reset,
    input writeenable,
    input [4:0]rs,
    input [4:0]rd,
    input [18:0] aluresult,
    output reg [18:0] regdata1,
    output reg [18:0] regdata2

);

reg [18:0] register [0:31] ;
integer i;

always @(posedge clk or posedge reset) begin
    if (reset)
    begin
        for (i = 0 ;i<32 ;i = i+1 )
        register[i] <= 19'b0;
    end 
    else if (writeenable && rd !=0)
    begin
        register[rd] <= aluresult;
    end 
    end
    always @(posedge clk) begin

        regdata1 = register[rs];
        regdata2 = register[rd];

        
    end
    
    

    
endmodule
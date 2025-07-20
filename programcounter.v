`timescale 1ns/1ps

module programcounter (
    input clk,
    input reset,
    input branch,
    input [2:0] imm,
    output reg [18:0] pcout
);
    always @(posedge clk or posedge reset) begin
        if(reset)
        pcout <= 0;
        else if (branch)
        pcout <= pcout + imm;
        else 
        pcout <= pcout + 1 ;
        
    end

endmodule
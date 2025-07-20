`timescale 1ns/1ps

module instruction (

input clk,
input reset,
input [4:0] r1,
input [3:0] r2,
input [4:0] pc,
output reg [18:0] instructions,
output reg [4:0] updatedpc

);
reg [3:0] SP;
reg [18:0] memory [0:31] ;
reg [4:0] stack [0:15];

initial begin
    
    SP = 4'b1111;
    memory[0] = 19'b000001_0000000000001;
    memory[1] = 19'b000010_00001_00010_010;
    memory[2] = 19'b000011_00011_00100_011;
    memory[3] = 19'b000101_0000000000000;

end

always @(posedge clk or posedge reset) begin
    
    if(reset) begin

        updatedpc <= 0;
        SP <= 4'b1111;

    end
    else begin
        case (memory[pc][18:14])
        5'b00001: begin
            updatedpc <= memory[pc][13:0];
        end
        5'b00010:begin
            if(r1 == r2)
            updatedpc <= memory[pc][13:0];
            else
            updatedpc <= pc +1;
        end
        5'b00011:begin
            if(r1 != r2)
            updatedpc <= memory[pc][13:0];
            else
            updatedpc <= pc +1;
        end
        5'b00100:begin
            stack[SP] <= pc + 1;
            SP <= SP - 1;
            updatedpc <= memory[pc][13:0];
        end
        5'b00101: begin
            SP <= SP +1;
            updatedpc <= stack[SP];
        end

            default:begin
                updatedpc <= pc + 1;

            end 
        endcase
    end
   
end
always @(posedge clk) begin
    instructions = memory[pc];
end
    
endmodule
`timescale 1ns/1ps

module alu(
    input clk,
    input reset,
    input aluen,
    input [18:0] r2, r3,
    input [2:0] imm,
    input [5:0] opcode,
    output reg [18:0] r1,
    output reg [7:0] FLAG


);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        r1 <= 19'b0;
        FLAG <= 8'b0;
    
    end 
    else if (aluen) begin
        FLAG = 8'b0;
        case (opcode)
            6'b000001: begin
                {FLAG[6], r1} = r2 + r3;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            6'b000010: begin
                {FLAG[6], r1} = r2 - r3;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            6'b000011: begin
                {FLAG[6], r1} = r2 * r3;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            6'b000100: begin
                if (r3 != 0)begin
                    r1 = r2/r3;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            else 
            begin
                r1 = 19'b0;
                FLAG[0] = 1'b1;
            end
            end
            6'b000101: begin
                {FLAG[6], r1} = r2 + 1;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            6'b000110: begin
                {FLAG[6], r1} = r2 - 1;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            6'b000111: begin
                {FLAG[6], r1} = r2 & r3;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            6'b001000: begin
                {FLAG[6], r1} = r2 | r3;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            6'b001001: begin
                {FLAG[6], r1} = r2 ^ r3;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            6'b001011: begin
                {FLAG[6], r1} = ~r2;
                FLAG[1] = (r1 == 0);
                FLAG[7] = r1[18];
            end 
            default: begin
                r1 = 19'b0;
                FLAG = 8'b0;
                $display("Warning - %b", opcode);

            end
        endcase
    end 
    else begin
        r1 <= 19'b0;
        FLAG <= 8'b0;
    end
    
end
    
endmodule
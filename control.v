`timescale 1ns/1ps

module control (
    input clk,
    input reset,
    input [5:0] opcode,
    output reg memwrite,
    output reg memread,
    output reg branch,
    output reg aluen
);

always @(posedge clk or posedge reset) begin
    memwrite = 0;
    aluen = 0;
    memread = 0;
    branch = 0;

    case (opcode)
        6'b010001: memread = 1;
        6'b010000: memwrite = 1;
        6'b100000: branch = 1;

        default: aluen = 1;

    endcase
end

always @(posedge clk or posedge reset) begin
    if(reset) begin
        branch <= 0;
        aluen <= 0;
        memwrite <= 0;
        memread <= 0;
    end
end

endmodule
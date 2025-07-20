`timescale 1ns/1ps

module custominst(
    input clk,
    input [7:0] r1, r2,
    input [1:0] instructions,
    output reg [18:0] dataout
);

reg [18:0] memory [0:255];

reg [15:0] fft_x0real, fft_x0imag, fft_x1real, fft_x1imag ;
wire [15:0] fft_y0real, fft_y0imag, fft_y1real, fft_y1imag ;

fft_2point fft_instance(
    .x0real(fft_x0real),
    .x0imag(fft_x0imag),
    .x1real(fft_x1real),
    .x1imag(fft_x1imag),
    .y0real(fft_y0real),
    .y0imag(fft_y0imag),
    .y1real(fft_y1real),
    .y1imag(fft_y1imag)
);

task encrypt;
input [7:0] test, src;
reg [18:0] key;
integer i;
begin
    key = 19'b1010101010101010101;
    for (i = 0;i<8 ;i = i+1 )
    memory[test +i] <= memory[src + i] ^ key;
end
endtask

task decrypt;
input [7:0] test, src;
reg [18:0] key;
integer i;
begin
    key = 19'b1010101010101010101;
    for(i=0;i<8;i=i+1)
    memory[test+1] <= memory[src +i] ^ key;
end
endtask

always @(posedge clk ) begin
    case (instructions)
        2'b00: begin
            fft_x0real <= memory[r2][15:0];
            fft_x0imag <= memory[r2+1][15:0];
            fft_x1real <= memory[r2+2][15:0];
            fft_x1imag <= memory[r2+3][15:0];

            memory[r1] <= {3'b0, fft_y0real};
            memory[r1+1] <= {3'b0, fft_y0imag};
            memory[r1+2] <= {3'b0, fft_y1real};
            memory[r1+3] <= {3'b0, fft_y1imag};

            dataout <= memory[r1];

        end
        2'b01: begin
            encrypt(r1, r2);
            dataout <= memory[r1];
        end 
        2'b10: begin
            decrypt(r1, r2);
            dataout <= memory [r1];
            
        end
        default: begin
            dataout <= 19'b0;
        end 
    endcase
    
end
endmodule
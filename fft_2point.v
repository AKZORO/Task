`timescale 1ns/1ps

module fft_2point(

    input wire signed [15:0] x0real, x0imag,
    input wire signed [15:0] x1imag, x1real,
    output wire signed [15:0] y0imag, y0real,
    output wire signed [15:0] y1imag, y1real
    
);

wire signed [15:0] sumreal, sumimag, diffreal, diffimag;

assign sumreal = x0real + x1real;
assign sumimag = x0imag + x1imag;

assign diffreal = x0real + x1real;
assign diffimag = x0imag + x1imag;

assign y0real = sumreal;
assign y0imag = sumimag;
assign y1real = diffreal;
assign y1imag = diffimag;    
endmodule
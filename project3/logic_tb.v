`timescale 1ns/1ps

module TWOSCOMP64_TB;
reg [63:0] A;
wire [63:0] Y;

TWOSCOMP64 twos64(.Y(Y), .A(A));

initial
begin
A=1;
#5 A=23;
#5 A=10;
#5 A=6;
#5;
end
endmodule

module TWOSCOMP32_TB;
reg [31:0] A;
wire [31:0] Y;

TWOSCOMP32 twos32(.Y(Y), .A(A));

initial
begin
A=1;
#5 A=20;
#5 A=43;
#5 A=2;
#5;
end
endmodule

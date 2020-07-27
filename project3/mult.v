// Name: mult.v
// Module: MULT32 , MULT32_U
//
// Output: HI: 32 higher bits
//         LO: 32 lower bits
//         
//
// Input: A : 32-bit input
//        B : 32-bit input
//
// Notes: 32-bit multiplication
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module MULT32(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A;
input [31:0] B;
// TBD
wire [31:0] twos1, twos2, mux1, mux2;
wire [63:0] unsign, twosUnsign, mux3;
wire xor1;

TWOSCOMP32 twos_1(.Y(twos1), .A(A));
MUX32_2x1 mux_1(.Y(mux1), .I0(A), .I1(twos1), .S(A[31]));

TWOSCOMP32 twos_2(.Y(twos2), .A(B));
MUX32_2x1 mux_2(.Y(mux2), .I0(B), .I1(twos2), .S(B[31]));

MULT32_U mult_1(.HI(unsign[63:32]), .LO(unsign[31:0]), .A(mux1), .B(mux2));

xor xor_1(xor1, A[31], B[31]);
TWOSCOMP64 twos_3(.Y(twosUnsign), .A(unsign));
MUX32_2x1 mux_3(.Y(LO), .I0(unsign[31:0]), .I1(twosUnsign[31:0]), .S(xor1));
MUX32_2x1 mux_4(.Y(HI), .I0(unsign[63:32]), .I1(twosUnsign[63:32]), .S(xor1));
endmodule

module MULT32_U(HI, LO, A, B);
// output list
output [31:0] HI;
output [31:0] LO;
// input list
input [31:0] A;
input [31:0] B;

// TBD
wire CO [31:0];
wire [31:0] and1 [31:0];

AND32_2x1 and_1(and1[0], A, {32{B[0]}});
buf b_1(CO[0], 1'b0);
buf b_2(LO[0], and1[0][0]);

genvar i;
generate
   for(i=1; i<32; i=i+1)
   begin: mult32_loop
	wire [31:0] and2;
	AND32_2x1 and_2(and2, A, {32{B[i]}});
	RC_ADD_SUB_32 rc(and1[i], CO[i], and2, {CO[i-1],{and1[i-1][31:1]}}, 1'b0);
	buf b_3(LO[i], and1[i][0]);
	if(i==31)
	begin
	genvar j;	
   	   for(j=0; j<32; j=j+1)
   	   begin: buf32_loop
		if(j==31)
		begin
		   buf buf_4(HI[31], CO[31]);
		end
		else
		begin
		   buf buf_5(HI[j], and1[31][j+1]);
		end
   	   end
	end
   end
endgenerate
endmodule

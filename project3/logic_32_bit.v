// Name: logic_32_bit.v
// Module: 
// Input: 
// Output: 
//
// Notes: Common definitions
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 02, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//

// 32-bit NOR
module NOR32_2x1(Y,A,B);
//output 
output [31:0] Y;
//input
input [31:0] A;
input [31:0] B;

// TBD
genvar i;
generate
   for(i=0; i<32; i=i+1)
   begin: nor32_loop
	nor nor_1(Y[i], A[i], B[i]);
   end
endgenerate

endmodule

module AND32_2x1(Y,A,B);
// output
output [31:0] Y;
// input
input [31:0] A;
input [31:0] B;

genvar i;
generate
   for(i=0; i<32; i=i+1)
   begin: and32_loop
	and and_1(Y[i], A[i], B[i]);
   end
endgenerate

endmodule


// 32-bit inverter
module INV32_1x1(Y,A);
//output 
output [31:0] Y;
//input
input [31:0] A;

// TBD
genvar i;
generate
   for(i=0; i<32; i=i+1)
   begin: not32_loop
	not not_1(Y[i], A[i]);
   end
endgenerate

endmodule

// 32-bit OR
module OR32_2x1(Y,A,B);
//output 
output [31:0] Y;
//input
input [31:0] A;
input [31:0] B;

// TBD
genvar i;
generate
   for(i=0; i<32; i=i+1)
   begin: or32_loop
	or or_1(Y[i], A[i], B[i]);
   end
endgenerate

endmodule

//1-bit 32x1 or
module OR32x1(Y, A);
	input [31:0] A;
	wire [29:0] or1;//2 less than op
	output Y;
	or o0(or1[0], A[0], A[1]);
	or o1(or1[1], or1[0], A[2]);
	or o2(or1[2], or1[1], A[3]);
	or o3(or1[3], or1[2], A[4]);
	or o4(or1[4], or1[3], A[5]);
	or o5(or1[5], or1[4], A[6]);
	or o6(or1[6], or1[5], A[7]);	
	or o7(or1[7], or1[6], A[8]);
	or o8(or1[8], or1[7], A[9]);
	or o9(or1[9], or1[8], A[10]);
	or o10(or1[10], or1[9], A[11]);
	or o11(or1[11], or1[10], A[12]);
	or o12(or1[12], or1[11], A[13]);
	or o13(or1[13], or1[12], A[14]);
	or o14(or1[14], or1[13], A[15]);
	or o15(or1[15], or1[14], A[16]);
	or o16(or1[16], or1[15], A[17]);
	or o17(or1[17], or1[16], A[18]);
	or o18(or1[18], or1[17], A[19]);
	or o19(or1[19], or1[18], A[20]);
	or o20(or1[20], or1[19], A[21]);
	or o21(or1[21], or1[20], A[22]);
	or o22(or1[22], or1[21], A[23]);
	or o23(or1[23], or1[22], A[24]);
	or o24(or1[24], or1[23], A[25]);
	or o25(or1[25], or1[24], A[26]);
	or o26(or1[26], or1[25], A[27]);
	or o27(or1[27], or1[26], A[28]);
	or o28(or1[28], or1[27], A[29]);
	or o29(or1[29], or1[28], A[30]);
	or o30(Y, or1[29], A[31]);
endmodule

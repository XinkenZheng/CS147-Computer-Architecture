// Name: full_adder.v
// Module: FULL_ADDER
//
// Output: S : Sum
//         CO : Carry Out
//
// Input: A : Bit 1
//        B : Bit 2
//        CI : Carry In
//
// Notes: 1-bit full adder implementaiton.
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

module FULL_ADDER(S,CO,A,B, CI);
output S,CO;
input A,B, CI;

wire HaY, HaC, Ha2C;

//TBD
HALF_ADDER inst1(.Y(HaY), .C(HaC), .A(A), .B(B));
HALF_ADDER inst2(.Y(S), .C(Ha2C), .A(HaY), .B(CI));
or inst3(CO, Ha2C, HaC);

endmodule

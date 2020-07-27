// Name: alu.v
// Module: ALU
// Input: OP1[32] - operand 1
//        OP2[32] - operand 2
//        OPRN[6] - operation code
// Output: OUT[32] - output result for the operation
//
// Notes: 32 bit combinatorial ALU
// 
// Supports the following functions
//	- Integer add (0x1), sub(0x2), mul(0x3)
//	- Integer shift_right (0x4), shift_left (0x5)
//	- Bitwise and (0x6), or (0x7), nor (0x8)
//  - set less than (0x9)
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//  1.1     Oct 19, 2014        Kaushik Patra   kpatra@sjsu.edu         Added ZERO status output
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module ALU(OUT, ZERO, OP1, OP2, OPRN);
// input list
input [`DATA_INDEX_LIMIT:0] OP1; // operand 1
input [`DATA_INDEX_LIMIT:0] OP2; // operand 2
input [`ALU_OPRN_INDEX_LIMIT:0] OPRN; // operation code

// output list
output [`DATA_INDEX_LIMIT:0] OUT; // result of the operation.
output ZERO;

wire [31:0] add_Subwire, shift_wire, mult_wire, and_wire, or_wire, nor_wire, OUT, co;
wire oprnNot, oprnOr, oprnAnd, slt;

and and_1(oprnAnd, OPRN[0], OPRN[3]);
not not_1(oprnNot, OPRN[0]);
or or_1(oprnOr, oprnNot, oprnAnd);

RC_ADD_SUB_32 addsub_1(.Y(add_Subwire), .CO(co[0]), .A(OP1), .B(OP2), .SnA(oprnOr));
buf buf_1(slt, add_Subwire[31]);
MULT32 mult_1(.HI(co), .LO(mult_wire), .A(OP1), .B(OP2));
SHIFT32 shift_1(.Y(shift_wire), .D(OP1), .S(OP2), .LnR(OPRN[0]));
AND32_2x1 and_2(.Y(and_wire), .A(OP1), .B(OP2));
NOR32_2x1 nor_1(.Y(nor_wire), .A(OP1), .B(OP2));
OR32_2x1 or_2(.Y(or_wire), .A(OP1), .B(OP2));

MUX32_16x1 mux_1(.Y(OUT), .I0(addSub), .I1(add_Subwire), .I2(add_Subwire), .I3(mult_wire),
		 .I4(shift_wire), .I5(shift_wire), .I6(and1), .I7(or_wire), .I8(nor_wire), 
		 .I9({31'b0, slt}), .I10(add_Subwire), .I11(add_Subwire), .I12(add_Subwire), 
		 .I13(add_Subwire), .I14(add_Subwire), .I15(add_Subwire), .S(OPRN[3:0]));
OR32x1 or_3(.Y(ZERO), .A(OUT));
endmodule 

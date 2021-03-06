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
//	- Integer shift_rigth (0x4), shift_left (0x5)
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
output  ZERO;

reg [`DATA_INDEX_LIMIT:0] OUT;
reg ZERO;

always @(OP1 or OP2 or OPRN)
begin
// TBD - Code for the ALU
	case (OPRN)
        `ALU_OPRN_WIDTH'h01 : OUT = OP1 + OP2; 	       // addition
	`ALU_OPRN_WIDTH'h02 : OUT = OP1 - OP2; 	      // subtraction
	`ALU_OPRN_WIDTH'h03 : OUT = OP1 * OP2;       // multiplication
	`ALU_OPRN_WIDTH'h04 : OUT = OP1 & OP2;      //bitwise AND
	`ALU_OPRN_WIDTH'h05 : OUT = OP1 | OP2;     //bitwise OR
	`ALU_OPRN_WIDTH'h06 : OUT = ~(OP1 | OP2); //bitwise NOR
	`ALU_OPRN_WIDTH'h07 : OUT = OP1 < OP2;   //set less than
	`ALU_OPRN_WIDTH'h08 : OUT = OP1 << OP2; //logical left shift
	`ALU_OPRN_WIDTH'h09 : OUT = OP1 >> OP2;//logical right shift
        default: OUT = `DATA_WIDTH'hxxxxxxx;				//defaults to the OPRN
	
	endcase
	

	if (OUT != 0)
		ZERO = 0;
	else
		ZERO = 1;

end

endmodule

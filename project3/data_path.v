// Name: data_path.v
// Module: DATA_PATH
// Output:  DATA : Data to be written at address ADDR
//          ADDR : Address of the memory location to be accessed
//
// Input:   DATA : Data read out in the read operation
//          CLK  : Clock signal
//          RST  : Reset signal
//
// Notes: - 32 bit processor implementing cs147sec05 instruction set
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module DATA_PATH(DATA_OUT, ADDR, ZERO, INSTRUCTION, DATA_IN, CTRL, CLK, RST);

// output list
output [`ADDRESS_INDEX_LIMIT:0] ADDR;
output ZERO;
output [`DATA_INDEX_LIMIT:0] DATA_OUT, INSTRUCTION;

// input list
input [`CTRL_WIDTH_INDEX_LIMIT:0]  CTRL;
input CLK, RST;
input [`DATA_INDEX_LIMIT:0] DATA_IN;

// TBD
wire notuse;
wire [31:0] pc, add1, add2, pc_sel_1, ir, pc_sel_2, pc_sel_3, r1_sel_1, wa_sel_1,
	   wa_sel_2, wa_sel_3, op2_sel_1, op2_sel_2, op2_sel_3, wd_sel_1, wd_sel_2, wd_sel_3,
	   sp, r1_data, r2_data, op1_sel_1, op2_sel_4, alu, ma_sel_1,addr;

defparam pc_inst.PATTERN = `INST_START_ADDR;
REG32_PP pc_inst(.Q(pc), .D(pc_sel_3), .LOAD(CTRL[0]), .CLK(CLK), .RESET(RST));

RC_ADD_SUB_32 add_1(.Y(add1), .CO(notuse), .A(1), .B(pc), .SnA(0));

MUX26_2x1 pcsel_1(.Y(pc_sel_1), .I0(r1_data), .I1(add1), .S(CTRL[1]));
RC_ADD_SUB_32 add_2(.Y(add2), .CO(notuse), .A(add1), .B({{16{ir[15]}},ir[15:0]}), .SnA(0));
MUX26_2x1 pcsel_2(.Y(pc_sel_2), .I0(pc_sel_1), .I1(add2), .S(CTRL[2]));
MUX26_2x1 pcsel_3(.Y(pc_sel_3), .I0(ir[25:0]), .I1(pc_sel_2), .S(CTRL[3]));

REG32 ir_reg(.Q(ir), .D(DATA_IN), .LOAD(CTRL[4]), .CLK(CLK), .RESET(RST));
MUX5_2x1 r1sel_1(.Y(r1_sel_1), .I0(ir[25:21]), .I1(0), .S(CTRL[5]));
MUX5_2x1 wasel_1(.Y(wa_sel_1), .I0(ir[15:11]), .I1(ir[20:16]), .S(CTRL[26]));
MUX5_2x1 wasel_2(.Y(wa_sel_2), .I0(0), .I1(5'b11111), .S(CTRL[27]));
MUX5_2x1 wasel_3(.Y(wa_sel_3), .I0(wa_sel_2), .I1(wa_sel_1), .S(CTRL[28]));
MUX32_2x1 op2sel_1(.Y(op2_sel_1), .I0(1), .I1({27'b0, ir[10:6]}), .S(CTRL[10]));
MUX32_2x1 op2sel_2(.Y(op2_sel_2), .I0({16'b0, ir[15:0]}), .I1({{16{ir[15]}},ir[15:0]}), .S(CTRL[11]));
MUX32_2x1 op2sel_3(.Y(op2_sel_3), .I0(op2_sel_2), .I1(op2_sel_1), .S(CTRL[12]));
MUX32_2x1 wdsel_1(.Y(wd_sel_1), .I0(alu), .I1(DATA_IN), .S(CTRL[23]));
MUX32_2x1 wdsel_2(.Y(wd_sel_2), .I0(wd_sel_1), .I1({ir[15:0],16'b0}), .S(CTRL[24]));
MUX32_2x1 wdsel_3(.Y(wd_sel_3), .I0(add1), .I1(wd_sel_2), .S(CTRL[25]));

REGISTER_FILE_32x32 reg_inst(.DATA_R1(r1_data), .DATA_R2(r2_data), .ADDR_R1(r1_sel_1), .ADDR_R2(ir[20:16]),
		 .DATA_W(wd_sel_3), .ADDR_W(wa_sel_3), .READ(CTRL[6]), .WRITE(CTRL[7]), .CLK(CLK), .RST(RST));
defparam sp_inst.PATTERN = `INIT_STACK_POINTER;
REG32_PP sp_inst(.Q(sp), .D(alu), .LOAD(CTRL[8]), .CLK(CLK), .RESET(RST));

MUX32_2x1 op1sel_1(.Y(op1_sel_1), .I0(r1_data), .I1(sp), .S(CTRL[9]));
MUX32_2x1 op2sel_4(.Y(op2_sel_4), .I0(op2_sel_3), .I1(r2_data), .S(CTRL[13]));
MUX32_2x1 md_sel_1(.Y(DATA_OUT), .I0(r2_data), .I1(r1_data), .S(CTRL[22]));

ALU alu_inst(.OUT(alu), .ZERO(ZERO), .OP1(op1_sel_1), .OP2(op2_sel_2), .OPRN(CTRL[19:14]));

MUX32_2x1 masel_1(.Y(ma_sel_1), .I0(alu), .I1(sp), .S(CTRL[20]));
MUX26_2x1 masel_2(.Y(ADDR), .I0(ma_sel_1[25:0]), .I1(pc[25:0]), .S(CTRL[21]));


endmodule

// Name: register_file.v
// Module: REGISTER_FILE_32x32
// Input:  DATA_W : Data to be written at address ADDR_W
//         ADDR_W : Address of the memory location to be written
//         ADDR_R1 : Address of the memory location to be read for DATA_R1
//         ADDR_R2 : Address of the memory location to be read for DATA_R2
//         READ    : Read signal
//         WRITE   : Write signal
//         CLK     : Clock signal
//         RST     : Reset signal
// Output: DATA_R1 : Data at ADDR_R1 address
//         DATA_R2 : Data at ADDR_R1 address
//
// Notes: - 32 bit word accessible dual read register file having 32 regsisters.
//        - Reset is done at -ve edge of the RST signal
//        - Rest of the operation is done at the +ve edge of the CLK signal
//        - Read operation is done if READ=1 and WRITE=0
//        - Write operation is done if WRITE=1 and READ=0
//        - X is the value at DATA_R* if both READ and WRITE are 0 or 1
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
//
`include "prj_definition.v"
module REGISTER_FILE_32x32(DATA_R1, DATA_R2, ADDR_R1, ADDR_R2, 
                            DATA_W, ADDR_W, READ, WRITE, CLK, RST);

// input list
input READ, WRITE, CLK, RST;
input [`DATA_INDEX_LIMIT:0] DATA_W;
input [`REG_ADDR_INDEX_LIMIT:0] ADDR_R1, ADDR_R2, ADDR_W;

// output list
output [`DATA_INDEX_LIMIT:0] DATA_R1;
output [`DATA_INDEX_LIMIT:0] DATA_R2;

wire [31:0] decodes, ands, reg1, reg2;
wire [31:0] af_Reg [31:0];
wire nRST;

DECODER_5x32 decode(.D(decodes), .I(ADDR_W));
not not_1(nRST, RST);
genvar i;
generate
for(i=0; i<32; i=i+1)
begin : reg32_loop
   and and_1(ands[i], decodes[i], WRITE);
   REG32 reg_1(.Q(af_Reg[i]),.D(DATA_W), .LOAD(ands[i]),.CLK(CLK), .RESET(nRST));
end
endgenerate

MUX32_32x1 mux_1(.Y(reg1), .I0(af_Reg[0]), .I1(af_Reg[1]), .I2(af_Reg[2]), .I3(af_Reg[3]), .I4(af_Reg[4]), 
		.I5(af_Reg[5]), .I6(af_Reg[6]), .I7(af_Reg[7]), .I8(af_Reg[8]), .I9(af_Reg[9]), 
		.I10(af_Reg[10]), .I11(af_Reg[11]), .I12(af_Reg[12]), .I13(af_Reg[13]), .I14(af_Reg[14]), 
		.I15(af_Reg[15]), .I16(af_Reg[16]), .I17(af_Reg[17]), .I18(af_Reg[18]), .I19(af_Reg[19]), 
		.I20(af_Reg[20]), .I21(af_Reg[21]), .I22(af_Reg[22]), .I23(af_Reg[23]), .I24(af_Reg[24]), 
		.I25(af_Reg[25]), .I26(af_Reg[26]), .I27(af_Reg[27]), .I28(af_Reg[28]), .I29(af_Reg[29]), 
		.I30(af_Reg[30]), .I31(af_Reg[31]), .S(ADDR_R1)); 

MUX32_32x1 mux_2(.Y(reg2), .I0(af_Reg[0]), .I1(af_Reg[1]), .I2(af_Reg[2]), .I3(af_Reg[3]), .I4(af_Reg[4]), 
		.I5(af_Reg[5]), .I6(af_Reg[6]), .I7(af_Reg[7]), .I8(af_Reg[8]), .I9(af_Reg[9]), 
		.I10(af_Reg[10]), .I11(af_Reg[11]), .I12(af_Reg[12]), .I13(af_Reg[13]), .I14(af_Reg[14]), 
		.I15(af_Reg[15]), .I16(af_Reg[16]), .I17(af_Reg[17]), .I18(af_Reg[18]), .I19(af_Reg[19]), 
		.I20(af_Reg[20]), .I21(af_Reg[21]), .I22(af_Reg[22]), .I23(af_Reg[23]), .I24(af_Reg[24]), 
		.I25(af_Reg[25]), .I26(af_Reg[26]), .I27(af_Reg[27]), .I28(af_Reg[28]), .I29(af_Reg[29]), 
		.I30(af_Reg[30]), .I31(af_Reg[31]), .S(ADDR_R2));

MUX32_2x1 mux_3(.Y(DATA_R1), .I0(32'bZ), .I1(reg1), .S(READ));
MUX32_2x1 mux_4(.Y(DATA_R2), .I0(32'bZ), .I1(reg2), .S(READ));


endmodule
module bit32_regester(q, clk, load, d, reset);
	input clk, load, reset;
	input [31:0] d;
	output [31:0] q;
	wire q2;
	wire notR;
	
	genvar i;
	generate
		for (i=0; i<32; i=i+1) begin : bitreg_gen_loop
			//not n(notR, reset);
			bit_regesterB r(q[i], q2, 1'b1, d[i], load, clk, notR);
		end
	endgenerate
endmodule



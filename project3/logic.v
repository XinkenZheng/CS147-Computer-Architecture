// Name: logic.v
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
// 64-bit two's complement
module TWOSCOMP64(Y,A);
//output list
output [63:0] Y;
//input list
input [63:0] A;
wire [63:0] notr;
wire dontCare;
reg [63:0] one = 64'b1;

// TBD
genvar i;
for(i=0; i<64; i=i+1)
begin: twos_64_loop
   not not_1(notr[i], A[i]);
end
RC_ADD_SUB_64 rc_1(.Y(Y), .CO(dontCare), .A(notr), .B(one), .SnA(1'b0));

endmodule

// 32-bit two's complement
module TWOSCOMP32(Y,A);
//output list
output [31:0] Y;
//input list
input [31:0] A;
wire [31:0] notr;
wire dontCare;
reg [31:0] one = 32'b1;

// TBD
genvar i;
for(i=0; i<32; i=i+1)
begin: twos_64_loop
   not not_1(notr[i], A[i]);
end
RC_ADD_SUB_32 rc_1(.Y(Y), .CO(dontCare), .A(notr), .B(one), .SnA(1'b0));

endmodule

// 32-bit registere +ve edge, Reset on RESET=0
module REG32(Q, D, LOAD, CLK, RESET);
output [31:0] Q;

input CLK, LOAD;
input [31:0] D;
input RESET;
// TBD
wire Qbar, notR;

genvar i;
generate
for(i=0; i<32; i=i+1)
begin : reg_loop
   not not_1(notR, RESET);
   REG1 reg_1(.Q(Q[i]), .Qbar(Qbar), .D(D[i]), .L(LOAD), .C(CLK), .nP(1'b1), .nR(notR));
end
endgenerate
endmodule

// 1 bit register +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module REG1(Q, Qbar, D, L, C, nP, nR);
input D, C, L;
input nP, nR;
output Q,Qbar;

// TBD
wire mux, ff;
MUX1_2x1 mux_1(.Y(mux), .I0(ff), .I1(D), .S(L));
D_FF dff(.Q(ff), .Qbar(Qbar), .D(mux), .C(CLK), .nP(nP), .nR(nR));
buf buf_1(Q, ff);

endmodule

// 1 bit flipflop +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_FF(Q, Qbar, D, C, nP, nR);
input D, C;
input nP, nR;
output Q,Qbar;

// TBD
wire DQ, DQbar, notC;

not not_1(notC, C);

D_LATCH d1(.Q(DQ), .Qbar(DQbar), .D(D), .C(C), .nP(nP), .nR(nR));
SR_LATCH s1(.Q(Q), .Qbar(Qbar), .S(DQ), .R(DQbar), .C(notC), .nP(nP), .nR(nR));
endmodule

// 1 bit D latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_LATCH(Q, Qbar, D, C, nP, nR);
input D, C;
input nP, nR;
output Q,Qbar;

// TBD
wire nand1, nand2, nand3, nand4;
wire notD;

not not_1(notD, D);
nand nand_1(nand1, D, C);
nand nand_2(nand2, notD, C);
nand nand_3(nand3, nand1, nand4, nP);
nand nand_4(nand4, nand2, nand3, nR);
buf b3(Q, nand3);
buf b4(Qbar, nand4);

endmodule

// 1 bit SR latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module SR_LATCH(Q,Qbar, S, R, C, nP, nR);
input S, R, C;
input nP, nR;
output Q,Qbar;

// TBD
wire nand1, nand2, nand3, nand4;

nand n1(nand1, S, C);
nand n2(nand2, R, C);
nand nand_1(nand3, nand1, nand4, nP);
nand nand_2(nand4, nand2, nand3, nR);
buf buf_1(Q, nand3);
buf buf_2(Qbar, nand4);

endmodule

// 5x32 Line decoder
module DECODER_5x32(D,I);
// output
output [31:0] D;
// input
input [4:0] I;

// TBD
wire [16:0] bundle;

DECODER_4x16 d1(.D(bundle[15:0]), .I(I[3:0]));

not n1(bundle[16], I[4]);

genvar i;
generate
for (i = 0; i < 16; i = i + 1)
begin:decoder_5x32_loop
   and a1(D[i], bundle[i], bundle[16]);
   and a2(D[i+16], bundle[i], I[4]);
end
endgenerate

endmodule

// 4x16 Line decoder
module DECODER_4x16(D,I);
// output
output [15:0] D;
// input
input [3:0] I;

// TBD
wire [8:0] bundle;

DECODER_3x8 d1(.D(bundle[7:0]), .I(I[2:0]));

not n1(bundle[8], I[3]);

genvar i;
generate
for(i = 0; i < 8; i = i + 1)
begin:decoder_4x16_loop
   and a1(D[i], bundle[i], bundle[8]);
   and a2(D[i+8], bundle[i], I[3]);
end
endgenerate

endmodule

// 3x8 Line decoder
module DECODER_3x8(D,I);
// output
output [7:0] D;
// input
input [2:0] I;

//TBD
wire [4:0] bundle;

DECODER_2x4 d(.D(bundle[3:0]), .I(I[1:0]));

not n1(bundle[4], I[2]);

genvar i;
generate
for(i = 0; i < 4; i = i + 1)
begin: decoder_3x8_loop
   and a1(D[i], bundle[i], bundle[4]);
   and a2(D[i + 4], bundle[i], I[2]);
end
endgenerate
endmodule

// 2x4 Line decoder
module DECODER_2x4(D,I);
// output
output [3:0] D;
// input
input [1:0] I;

// TBD
wire not1, not2;

not not_1(not1, I[0]);
not not_2(not2, I[1]);
and and_1(D[0], not1, not2);
and and_2(D[1], not2, I[0]);
and and_3(D[2], I[1], not1);
and and_4(D[3], I[1], I[0]);

endmodule


module REG32_PP(Q, D, LOAD, CLK, RESET);
parameter PATTERN = 32'h00000000;
output [31:0] Q;

input CLK, LOAD;
input [31:0] D;
input RESET;

wire [31:0] qbar;

genvar i;
generate
for(i=0; i<32; i=i+1)
     begin : reg32_gen_loop
    if (PATTERN[i] == 0)
        REG1 reg_inst(.Q(Q[i]), .Qbar(qbar[i]), .D(D[i]), .L(LOAD), .C(CLK), .nP(1'b1), .nR(RESET));
    else
        REG1 reg_inst(.Q(Q[i]), .Qbar(qbar[i]), .D(D[i]), .L(LOAD), .C(CLK), .nP(RESET), .nR(1'b1));
    end
endgenerate

endmodule

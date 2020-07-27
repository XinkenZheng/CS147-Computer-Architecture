// Name: barrel_shifter.v
// Module: SHIFT32_L , SHIFT32_R, SHIFT32
//
// Notes: 32-bit barrel shifter
// 
//
// Revision History:
//
// Version	Date		Who		email			note
//------------------------------------------------------------------------------------------
//  1.0     Sep 10, 2014	Kaushik Patra	kpatra@sjsu.edu		Initial creation
//------------------------------------------------------------------------------------------
`include "prj_definition.v"

// 32-bit shift amount shifter
module SHIFT32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [31:0] S;
input LnR;

// TBD
wire [31:0] leftS, rightS, muxS, ors;
wire orS, cur;

SHIFT32_R shift_r(.Y(rightS), .D(D), .S(S[4:0]));
SHIFT32_L shift_l(.Y(leftS), .D(D), .S(S[4:0]));

MUX32_2x1 mux_1(.Y(muxS), .I0(rightS), .I1(leftS), .S(LnR));
OR32x1 or1(.Y(orS), .A({5'b0,{S[31:5]}}));
//or or1(orS, {5'b0,{S[31:5]}});
MUX32_2x1 mux_2(.Y(Y), .I0(muxS), .I1(32'b0), .S(orS));

endmodule

// Shift with control L or R shift
module BARREL_SHIFTER32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;
input LnR;

// TBD
wire [31:0] leftS, rightS, muxS;
wire orS;

SHIFT32_R shift_r(.Y(rightS), .D(D), .S(S));
SHIFT32_L shift_l(.Y(leftS), .D(D), .S(S));

MUX32_2x1 mux_1(.Y(Y), .I0(rightS), .I1(leftS), .S(LnR));
endmodule

// Right shifter
module SHIFT32_R(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

// TBD
wire [31:0] mux[3:0];

genvar i, j, k, m;
generate
for(i=0; i<32; i=i+1)
begin: input_loop
   if(i<31)
   begin
	MUX1_2x1 mux_1(.Y(mux[0][i]), .I0(D[i]), .I1(D[i+1]), .S(S[0]));
   end
   else
   begin
	MUX1_2x1 mux_2(.Y(mux[0][i]), .I0(D[i]), .I1(1'b0), .S(S[0]));
   end
end
for(j=1; j<4; j=j+1)
begin: inner_state_loop
   for(k=0; k<32; k=k+1)
   begin: inner_loop
	if(k<32-2**j)
	begin 
	   MUX1_2x1 mux_3(.Y(mux[j][k]), .I0(mux[j-1][k]), .I1(mux[j-1][k+2**j]), .S(S[j]));
	end
	else
	begin
	   MUX1_2x1 mux_4(.Y(mux[j][k]), .I0(mux[j-1][k]), .I1(1'b0), .S(S[j]));
	end
   end
end
for(m=0; m<32; m=m+1)
begin: final_loop
   if(m < 16)
   begin
	MUX1_2x1 mux_5(.Y(Y[m]), .I0(mux[3][m]), .I1(mux[3][m+16]), .S(S[4]));
   end
   else
   begin
	MUX1_2x1 mux_6(.Y(Y[m]), .I0(mux[3][m]), .I1(1'b0), .S(S[4]));
   end
end
endgenerate

endmodule


// Left shifter
module SHIFT32_L(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

// TBD
wire [31:0] mux[3:0];

genvar i, j, k, m;
generate
for(i=0; i<32; i=i+1)
begin: input_loop
   if(i>0)
   begin
	MUX1_2x1 mux_1(.Y(mux[0][i]), .I0(D[i]), .I1(D[i-1]), .S(S[0]));
   end
   else
   begin
	MUX1_2x1 mux_2(.Y(mux[0][i]), .I0(D[i]), .I1(1'b0), .S(S[0]));
   end
end
for(j=1; j<4; j=j+1)
begin: inner_state_loop
   for(k=0; k<32; k=k+1)
   begin: inner_loop
	if(k>=2**j)
	begin 
	   MUX1_2x1 mux_3(.Y(mux[j][k]), .I0(mux[j-1][k]), .I1(mux[j-1][k-2**j]), .S(S[j]));
	end
	else
	begin
	   MUX1_2x1 mux_4(.Y(mux[j][k]), .I0(mux[j-1][k]), .I1(1'b0), .S(S[j]));
	end
   end
end
for(m=0; m<32; m=m+1)
begin: final_loop
   if(m > 16)
   begin
	MUX1_2x1 mux_5(.Y(Y[m]), .I0(mux[3][m]), .I1(mux[3][m-16]), .S(S[4]));
   end
   else
   begin
	MUX1_2x1 mux_6(.Y(Y[m]), .I0(mux[3][m]), .I1(1'b0), .S(S[4]));
   end
end
endgenerate
endmodule


`timescale 1ns/1ps

module RC_ADD_SUB_32_TB;

wire [31:0]  Y;
wire CO;

reg [31:0]  A;
reg [31:0]  B;
reg SnA;

RC_ADD_SUB_32 rc32(.Y(Y), .CO(CO), .A(A), .B(B), .SnA(SnA));

initial 
begin
#5 A=0; B=0; SnA=0;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=0; B=1; SnA=0;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=4; B=0; SnA=0;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=7; B=5; SnA=1;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=5; B=9; SnA=1;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=3; B=4; SnA=0;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=65; B=23; SnA=1;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=1; B=1; SnA=1;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5;
end
endmodule 



module RC_ADD_SUB_64_TB;

wire [63:0] Y;
wire CO;

reg [63:0] A;
reg [63:0] B;
reg SnA;

RC_ADD_SUB_64 rc64(.Y(Y), .CO(CO), .A(A), .B(B), .SnA(SnA));

initial 
begin
#5 A=0; B=0; SnA=0;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=0; B=1; SnA=0;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=4; B=0; SnA=0;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=7; B=5; SnA=1;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=5; B=9; SnA=1;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=3; B=4; SnA=0;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=9; B=2; SnA=1;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5 A=1; B=1; SnA=1;
#5 $write("\nOp1 = %0.1d   Op2 = %0.1d   SnA = %0.1d   result = %0.1d   CO = %0.1d\n", A,B,SnA,Y,CO);
#5;
end

endmodule 
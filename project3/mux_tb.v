`timescale 1ns/1ps

//1-bit mux 2x1
module MUX1_2x1_TB;
reg I0, I1, S;
wire Y;
MUX1_2x1 mux(.Y(Y), .I0(I0), .I1(I1), .S(S));

initial
begin
S=0; I0=1; I1=0;
#5 S=0; I0=0; I1=1;
#5 S=1; I0=1; I1=0;
#5 S=1; I0=0; I1=1;
#5;
end
endmodule

//32-bit mux 2x1
module MUX32_2x1_TB;
reg [31:0] I0, I1;
reg S;
wire [31:0] Y;
MUX32_2x1 mux(.Y(Y), .I0(I0), .I1(I1), .S(S));

initial
begin
S=0; I0=1; I1=0;
#5 S=0; I0=12; I1=5;
#5 S=1; I0=7; I1=2;
#5 S=1; I0=0; I1=1;
#5;
end
endmodule

//32-bit mux 4x1
module MUX32_4x1_TB;
reg [31:0] I0, I1, I2, I3;
reg [1:0] S;
wire [31:0] Y;
MUX32_4x1 mux(.Y(Y), .I0(I0), .I1(I1), .I2(I2), .I3(I3),.S(S));

initial
begin
S=0; I0=1; I1=0; I2=3; I3=4;
#5 S=1; I0=1; I1=0; I2=3; I3=4;
#5 S=2; I0=7; I1=2; I2=9; I3=20;
#5 S=3; I0=0; I1=4; I2=1; I3=8;
#5;
end
endmodule

//32-bit mux 8x1
module MUX32_8x1_TB;
reg [31:0] I0, I1, I2, I3, I4, I5, I6, I7;
reg [2:0] S;
wire [31:0] Y;
MUX32_8x1 mux(.Y(Y), .I0(I0), .I1(I1), .I2(I2), .I3(I3), 
		.I4(I4), .I5(I5), .I6(I6), .I7(I7), .S(S));

initial
begin
S=0; I0=1; I1=0; I2=3; I3=4; I4=6; I5=7; I6=8; I7=4;
#5 S=1; I0=1; I1=0; I2=3; I3=4; I4=12; I5=10; I6=9; I7=23;
#5 S=2; I0=7; I1=2; I2=9; I3=20; I4=6; I5=28; I6=7; I7=19;
#5 S=3; I0=0; I1=4; I2=1; I3=8; I4=3; I5=45; I6=8; I7=5;
#5 S=5; I0=0; I1=2; I2=3; I3=25; I4=18; I5=15; I6=18; I7=22;
#5 S=7; I0=0; I1=4; I2=1; I3=8; I4=2; I5=13; I6=8; I7=3;
#5;
end
endmodule

//32-bit mux 16x1
module MUX32_16x1_TB;
reg [31:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
reg [3:0] S;
wire [31:0] Y;
MUX32_16x1 mux(.Y(Y), .I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .I5(I5), .I6(I6), .I7(I7), .I8(I8),
		 .I9(I9), .I10(I10), .I11(I11), .I12(I12), .I13(I13), .I14(I14), .I15(I15),.S(S));

initial
begin
S=0; I0=0; I1=1; I2=2; I3=3; I4=5; I5=6; I6=8; I7=4; 
     I8=1; I9=9; I10=32; I11=41; I12=15; I13=18; I14=10; I15=14;
#5 S=1; I0=1; I1=0; I2=3; I3=4; I4=12; I5=10; I6=9; I7=23;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=18; I14=19; I15=67;
#5 S=5; I0=7; I1=2; I2=9; I3=20; I4=6; I5=28; I6=7; I7=19;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=18; I14=56; I15=67;
#5 S=8; I0=0; I1=4; I2=1; I3=8; I4=3; I5=45; I6=9; I7=5;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=18; I14=19; I15=67;
#5 S=12; I0=0; I1=2; I2=3; I3=25; I4=18; I5=15; I6=18; I7=22;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=18; I14=19; I15=67;
#5 S=15; I0=0; I1=4; I2=1; I3=8; I4=2; I5=13; I6=8; I7=3;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=18; I14=19; I15=67;
#5;
end
endmodule

//32-bit mux 32x1
module MUX32_32x1_TB;
reg [31:0] I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15;
reg [31:0] I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31;
reg [4:0] S;
integer total_test;
integer pass_test;

wire [31:0] Y;
MUX32_32x1 mux(.Y(Y), .I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .I5(I5), .I6(I6), .I7(I7), .I8(I8),
		 .I9(I9), .I10(I10), .I11(I11), .I12(I12), .I13(I13), .I14(I14), .I15(I15), .I16(I16), 
		 .I17(I17), .I18(I18), .I19(I19), .I20(I20), .I21(I21), .I22(I22), .I23(I23), .I24(I24),
		 .I25(I25), .I26(I26), .I27(I27), .I28(I28), .I29(I29), .I30(I30), .I31(I31), .S(S));

initial
begin
total_test = 0;
pass_test = 0;

S=0; I0=0; I1=1; I2=2; I3=3; I4=5; I5=6; I6=8; I7=4; 
     I8=1; I9=9; I10=32; I11=41; I12=15; I13=18; I14=10; I15=14;
     I16=45; I17=67; I18=52; I19=77; I20=32; I21=9; I22=50; I23=34;
     I24=54; I25=51; I26=32; I27=42; I28=16; I29=16; I30=19; I31=69;
#5 test_and_count(total_test, pass_test, 
                   test_golden(0,Y));
#5 S=8; I0=1; I1=0; I2=3; I3=4; I4=12; I5=10; I6=9; I7=23;
     I8=14; I9=11; I10=38; I11=41; I12=15; I13=18; I14=19; I15=67;
     I16=45; I17=67; I18=52; I19=77; I20=32; I21=9; I22=50; I23=34;
     I24=54; I25=51; I26=32; I27=42; I28=16; I29=16; I30=39; I31=69;
#5 test_and_count(total_test, pass_test, 
                   test_golden(14,Y));
#5 S=16; I0=7; I1=2; I2=9; I3=26; I4=6; I5=23; I6=04; I7=19;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=18; I14=56; I15=17;
     I16=44; I17=67; I18=52; I19=77; I20=12; I21=99; I22=14; I23=32;
     I24=54; I25=51; I26=32; I27=42; I28=16; I29=18; I30=18; I31=88;
#5 test_and_count(total_test, pass_test, 
                   test_golden(45,Y));
#5 S=25; I0=0; I1=4; I2=1; I3=8; I4=3; I5=45; I6=9; I7=5;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=18; I14=19; I15=67;
     I16=45; I17=87; I18=52; I19=77; I20=32; I21=69; I22=50; I23=34;
     I24=54; I25=51; I26=32; I27=42; I28=16; I29=16; I30=19; I31=69;
#5 test_and_count(total_test, pass_test, 
                   test_golden(51,Y));
#5 S=28; I0=0; I1=2; I2=3; I3=25; I4=18; I5=15; I6=18; I7=22;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=38; I14=19; I15=67;
     I16=45; I17=67; I18=52; I19=77; I20=32; I21=9; I22=50; I23=34;
     I24=54; I25=51; I26=32; I27=42; I28=16; I29=18; I30=12; I31=69;
#5 test_and_count(total_test, pass_test, 
                   test_golden(16,Y));
#5 S=31; I0=0; I1=4; I2=1; I3=8; I4=2; I5=13; I6=90; I7=3;
     I8=14; I9=11; I10=32; I11=41; I12=15; I13=18; I14=19; I15=67;
     I16=45; I17=67; I18=52; I19=77; I20=32; I21=9; I22=50; I23=34;
     I24=54; I25=51; I26=32; I27=42; I28=16; I29=16; I30=19; I31=69;
#5 test_and_count(total_test, pass_test, 
                   test_golden(69,Y));
#5  $write("\n");
    $write("\tTotal number of tests %d\n", total_test);
    $write("\tTotal number of pass  %d\n", pass_test);
    $write("\n");
    $stop; // stop simulation here
end

task test_and_count;
inout total_test;
inout pass_test;
input test_status;

integer total_test;
integer pass_test;
begin
    total_test = total_test + 1;
    if (test_status)
    begin
	pass_test = pass_test + 1;
    end
end
endtask

function test_golden;
input [31:0] exp;
input [31:0] res;

begin
   test_golden = (res === exp)?1'b1:1'b0; 
   if(exp !== res)
   begin
	$write("Expect %0d, got %0d ... [FAILED]", exp, res);
	$write("\n");
   end
   else
   begin
	$write("Expect %0d, got %0d ... [PASSED]", exp, res);
	$write("\n");
   end
end

endfunction
endmodule





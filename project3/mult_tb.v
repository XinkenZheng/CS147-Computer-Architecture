`timescale 1ns/1ps

module MULT_TB;

reg [31:0] A, B;
wire [31:0] HI, LO;
integer total_test;
integer pass_test;

MULT32 m(.HI(HI), .LO(LO), .A(A), .B(B));

initial 
begin
total_test = 0;
pass_test = 0;

A=32'b0; B=32'b0;
#5 test_and_count(total_test, pass_test, 
                   test_golden('0, '0,HI, LO));

#5 A=32'b111101; B=32'b0110101;
#5 test_and_count(total_test, pass_test, 
                   test_golden('h0, 'hca1,HI, LO));

#5 A=32'b1111; B=32'b10;
#5 test_and_count(total_test, pass_test, 
                   test_golden('h0, 'h1e,HI, LO));

#5 A=32'b11; B=32'b1;
#5 test_and_count(total_test, pass_test, 
                   test_golden('h0, 'h3,HI, LO));

#5 A=32'hffffffff; B=32'b1;
#5 test_and_count(total_test, pass_test, 
                   test_golden('hffffffff, 'hffffffff,HI, LO));

#5 A=32'b1111111111111111111111111111111; B=32'b1;
#5 test_and_count(total_test, pass_test, 
                   test_golden('h0, 'h7fffffff,HI, LO));

#5 A=32'b0111111111111111111111111111111; B=32'b111111;
#5 test_and_count(total_test, pass_test, 
                   test_golden('h0000000f, 'hbfffffc1,HI, LO));
#5 A=32'b0111111111111111111111111111111; B=32'b111111;
#5 test_and_count(total_test, pass_test, 
                   test_golden('h0000000f, 'hbfffffc1,HI, LO));
#5 A=32'hffffffff; B=32'b1;
#5 test_and_count(total_test, pass_test, 
                   test_golden('hffffffff, 'hffffffff,HI, LO));
#5 A=32'b1111; B=32'b10;
#5 test_and_count(total_test, pass_test, 
                   test_golden('h0, 'h1e,HI, LO));

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
input [31:0] hiexp;
input [31:0] loexp;
input [31:0] hires;
input [31:0] lores;

begin
   test_golden = ((hires === hiexp ) && (lores ===loexp))?1'b1:1'b0; 
   if((hires === hiexp ) && (lores ===loexp))
   begin
	$write("Expect HI = %0d LO = %0d, got HI = %0d LO = %0d ... [PASSED]", hiexp, loexp, hires, lores);
	$write("\n");
   end
   else
   begin
	$write("Expect HI = %0d LO = %0d, got HI = %0d LO = %0d ... [FAILED]", hiexp, loexp, hires, lores);
	$write("\n");
   end
end

endfunction
endmodule





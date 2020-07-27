
`include "prj_definition.v"

module register_file_tb;

reg [`ADDRESS_INDEX_LIMIT: 0] ADDR_R1;
reg [`ADDRESS_INDEX_LIMIT: 0] ADDR_R2;
reg [`ADDRESS_INDEX_LIMIT: 0] ADDR_W;

reg READ, WRITE, RST;

reg [`DATA_INDEX_LIMIT:0] DATA_REG;
integer i;
integer total_test, pass_test;


wire CLK;
wire [`DATA_INDEX_LIMIT:0] DATA_W;
wire [`DATA_INDEX_LIMIT:0] DATA_R1;
wire [`DATA_INDEX_LIMIT:0] DATA_R2;

assign DATA_W = ((READ === 1'b0)&&(WRITE === 1'b1))?DATA_REG:{`DATA_WIDTH{1'bz}};

CLK_GENERATOR clk_gen_inst(.CLK(CLK));

REGISTER_FILE_32x32 reg_inst(.DATA_R1(DATA_R1), .DATA_R2(DATA_R2), .ADDR_R1(ADDR_R1), .ADDR_R2(ADDR_R2), .DATA_W(DATA_W), 
.ADDR_W(ADDR_W), .READ(READ), .WRITE(WRITE), .CLK(CLK), .RST(RST));

initial
begin
RST = 1'b1;
READ = 1'b0;
WRITE = 1'b0;

total_test = 0;
pass_test = 0;

#10 RST = 1'b0;
#10 RST = 1'b1;

for (i = 1; i < 20; i = i + 1)
begin
#10 DATA_REG = i; READ = 1'b0; WRITE = 1'b1; ADDR_W = i;
end


#5 READ = 1'b0; 
#5 WRITE = 1'b0;
#10 total_test = total_test + 1;
	if (DATA_R1 !== {`DATA_WIDTH{1'bz}})
		$write("[TEST] Read %1b, Write %1b, Expecting 32'hzzzzzzzz, got %8h [FAILED]\n", READ, WRITE, DATA_R1);
	else
		pass_test = pass_test + 1;

for (i = 0; i < 20; i = i + 1)
begin
#5 READ = 1'b1; 
#5 WRITE = 1'b0; 
#5 ADDR_R1 = i;
#10 total_test = total_test + 1;
	if (DATA_R1 !== i)
		$write("[TEST] Read %1b, Write %1b, Expecting %8h, got %8h[FAILED]\n", READ, WRITE, i, DATA_R1);
	else
		pass_test = pass_test + 1;
end


for (i = 0; i < 20; i = i + 1)
begin
#5 READ = 1'b1; 
#5 WRITE = 1'b0; 
#5 ADDR_R2 = i;
#10 total_test = total_test + 1;
	if (DATA_R2 !== i)
		$write("[TEST] Read %1b, Write %1b, Expecting %8h, got %8h[FAILED]\n", READ, WRITE, i, DATA_R1);
	else
		pass_test = pass_test + 1;
end

#10 READ = 1'b0; WRITE = 1'b0;

#10 $write("/n");
	$write("\tTotal number of tests %d\n", total_test);
	$write("\tTotal number of pass %d\n", pass_test);
	$write("\n");
	$stop;

end
endmodule;



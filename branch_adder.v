module branch_adder(
	 input branchValid,
	 input branch,     
    input wire [31:0] add_out,
	 input wire [31:0] target,
	 output taken,
    output wire [31:0] targetShifted 
);



assign taken = (branch && branchValid);
assign targetShifted = target + add_out ;





endmodule
module bmux2to1 (
	 input branchYes,
	 input branch,     
    input wire [31:0] add_out,// 32-bit original pc + 1
	 input wire [31:0] target,// 32-bit extended target(immediate) address
    output wire [31:0] addressBranch // 32-bit output
);
wire select1; // select signal
wire [31:0] targetShifted; // 2 x address + (PC +1)
assign select1 = (branch && branchYes);
assign targetShifted = target + add_out;
assign addressBranch = (select1) ? targetShifted : add_out;
endmodule
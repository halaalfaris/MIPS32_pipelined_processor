module bmux2to1 (
	 input branchYes,
	 input branch,     
    input wire [31:0] add_out,
	 input wire [31:0] target,
	 input wire [31:0] pc_plus1,
    output wire [31:0] addressBranch 
);

wire select1; 
wire [31:0] targetShifted;
assign select1 = (branch && branchYes);
assign targetShifted = target + add_out ;
assign addressBranch = (select1) ? targetShifted : pc_plus1;
endmodule

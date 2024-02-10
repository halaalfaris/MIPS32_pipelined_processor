module adder (
	input [7:0] IN,
	output [31:0] add_out);
	
	assign add_out= IN + 32'h1;
	
endmodule

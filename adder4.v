module adder4 (A, add_out);
	input [7:0] A ;
	output [31:0] add_out;
	assign add_out=A+ 32'h1;
endmodule

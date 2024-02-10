
module sign_extension (IR, sign_out);
	input [31:0] IR;
	output [31:0] sign_out;
	wire [15:0] sign_in;
	assign sign_in=IR[15:0];
	assign sign_out[15:0]=sign_in[15:0];
	assign sign_out[31:16]=sign_in[15]?16'b1111_1111_1111_1111:16'b0;
endmodule

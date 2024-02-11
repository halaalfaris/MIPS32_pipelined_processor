module interface(
input KEY0, KEY1,
input [4:0] SW,
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5

);

wire [31:0] reg_value, pc_value;


pipeline Pipeline(
	.clk(~KEY0),
	.reset(~KEY1),
	.interface_input(SW),
	.interface_output(reg_value),
	.pc_MEMWB(pc_value)


);


hex7seg digit_5 (pc_value[7:4], HEX5);
hex7seg digit_4 (pc_value[3:0], HEX4);

hex7seg digit_3 (reg_value[15:12], HEX3);
hex7seg digit_2 (reg_value[11:8], HEX2);
hex7seg digit_1 (reg_value[7:4], HEX1);
hex7seg digit_0 (reg_value[3:0], HEX0);




endmodule


module hex7seg (hex, display);
	input [3:0] hex;
	output [0:6] display;

	reg [0:6] display;


	always @ (hex)
		case (hex)
			4'h0: display = 7'b1000000;
			4'h1: display = 7'b1111001;
			4'h2: display = 7'b0100100;
			4'h3: display = 7'b0110000;
			4'h4: display = 7'b0011001;
			4'h5: display = 7'b0010010;
			4'h6: display = 7'b0000010;
			4'h7: display = 7'b1111000;
			4'h8: display = 7'b0000000;
			4'h9: display = 7'b0010000;
			4'hA: display = 7'b0001000;
			4'hb: display = 7'b0000011;
			4'hC: display = 7'b1000110;
			4'hd: display = 7'b0100001;
			4'hE: display = 7'b0000110;
			4'hF: display = 7'b0001110;
		endcase
endmodule

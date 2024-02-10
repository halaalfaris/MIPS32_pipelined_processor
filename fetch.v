module fetch (
input clk,reset,hold,
input [7:0] next_pc,
output [31:0] pc_plus,
output [31:0] instruction

);

wire [7:0] pc;


instruction_memory IM(
	.address(pc),
	.data(instruction));

PC_reg PC(
    .clock(clk),     
    .reset(reset),     
	 .hold(hold),
    .data_in(next_pc), 
    .data_out(pc));
	 

adder Add(
	.IN(pc),
	.add_out(pc_plus));
	
endmodule


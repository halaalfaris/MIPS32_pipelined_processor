module execute(
input [31:0] instruction,read_data1_IDEX,read_data2_IDEX,write_data,alu_res_EXMEM,sign_ext_IDEX,
input [7:0] RS1_IDEX, RS2_IDEX,write_addr_EXMEM,write_addr_MEMWB,
input [3:0] aluop,
input reset,alusrc_IDEX,reg_write_EXMEM,reg_write_MEMWB,


output [31:0] alu_res, RS2_sw
);


wire [31:0] alu_input1,alu_input2,alusrc_input;
wire [5:0] funct;
wire [3:0] alu_control;
wire [1:0] ForwardA,ForwardB;


assign funct = instruction[5:0];


ALU alu(
	.aluCON(alu_control),
	.In1(alu_input1),
	.In2(alu_input2),
	.res(alu_res));
	

	
aluCON alu_con(
	.aluop(aluop),
	.funct(funct),
	.out_to_alu(alu_control));
	



mux4to1 muxA(
		.data_input_0(read_data1_IDEX),
		.data_input_1(write_data),
		.data_input_2(alu_res_EXMEM),
		.data_input_3(),
		.select(ForwardA),
		.data_output(alu_input1));

mux4to1 muxB(
		.data_input_0(read_data2_IDEX),
		.data_input_1(write_data),
		.data_input_2(alu_res_EXMEM),
		.data_input_3(),
		.select(ForwardB),
		.data_output(alusrc_input));
		
		
mux2to1	alu_src_mux(
	.select(alusrc_IDEX),
	.data1(alusrc_input),
	.data2(sign_ext_IDEX),
	
	.outputdata(alu_input2));

	

mux4to1  RS2_sw_input(
		.data_input_0(read_data2_IDEX),
		.data_input_1(write_data),
		.data_input_2(alu_res_EXMEM),
		.data_input_3(),
		.select(ForwardB),
		.data_output(RS2_sw));



forwarding_unit forward(
	.rst(reset),
	.RS1_IDEX(RS1_IDEX),
	.RS2_IDEX(RS2_IDEX),
	.RD_EXMEM(write_addr_EXMEM),
	.RD_MEMWB(write_addr_MEMWB),
	.writeBack_EXMEM(reg_write_EXMEM),
	.writeBack_MEMWB(reg_write_MEMWB),
	.ForwardA(ForwardA),
	.ForwardB(ForwardB));
	




endmodule


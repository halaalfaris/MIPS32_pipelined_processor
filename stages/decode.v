module decode(
input [31:0] instruction, write_data, alu_res_MEM,
input [31:0] pc_plus,pc,
input [4:0] write_addr_WB,
input clk, reset, reg_write_WB, branch_hazard_A, branch_hazard_B, 


output [31:0] read_data_1, read_data_2,sign_extended,
output [7:0] next_pc,
output [4:0] read_address_1, read_address_2, write_address,
output [3:0] aluop,
output [1:0] reg_dest, jump,
output pc_to_reg, mem_read, mem_to_reg, mem_write, alusrc, reg_write, branch_valid, branch


);

wire [31:0] branch_data_A,branch_data_B;
wire [15:0] sign_in;
wire [31:0] jump_dest, address_branch, branch_res;
wire [5:0] opcode;
wire [4:0] adress1,adress2,adress3;
wire taken;


assign adress1 = instruction[20:16];
assign adress2 = instruction[15:11];
assign adress3 = 5'b11111;
assign jump_dest = {pc_plus[31:26],instruction[25:0]};
assign opcode = instruction[31:26];
assign sign_in = instruction[15:0];

assign read_address_1 = instruction[25:21];
assign read_address_2 = instruction[20:16];


control_unit controlUnit(
	.opcode(opcode),
	
	.branch(branch),
	.pc_to_reg(pc_to_reg),
	.mem_read(mem_read),
	.mem_to_reg(mem_to_reg),
	.mem_write(mem_write),
	.alusrc(alusrc),
	.reg_write(reg_write),
	.jump(jump),
	.aluop(aluop),
	.reg_dest(reg_dest));


register_file	rf(


	.reg_write(reg_write_WB),
	.clk(clk),
	.reset(reset),
	.read_addr_1(read_address_1),
	.read_addr_2(read_address_2),
	
	.write_addr(write_addr_WB),
	
	.write_data(write_data),
	.read_data_1(read_data_1),
	.read_data_2(read_data_2));

		
Comparator comparator(
  .In1(branch_data_A),
  .In2(branch_data_B),
  .opcode(opcode),
  .reset(reset),
  .branchValid(branch_valid));
  
  
mux2to1	muxBranchA(
	.select(branch_hazard_A),
	.data1(read_data_1),
	.data2(alu_res_MEM),
	.outputdata(branch_data_A));

mux2to1 muxBranchB(
		.select(branch_hazard_B),
		.data1(read_data_2),
		.data2(alu_res_MEM),
		.outputdata(branch_data_B));
		
branch_adder branchAdder(
	 .branchValid(branch_valid),
	 .branch(branch),     
    .add_out(pc_plus),
	 .target(sign_extended),
	 .taken(taken),
    .targetShifted(address_branch));
	 
sign_extension Extention(
	.sign_in(sign_in),
	.sign_out(sign_extended));
	

mux2to1 BranchTaken(
		.select(taken),
		.data1(pc),
		.data2(address_branch),
		.outputdata(branch_res));
		
mux4to1 jmux(
  .data_input_0(branch_res),
  .data_input_1(jump_dest),
  .data_input_2(read_data_1),
  .data_input_3(),
  .select(jump),
  .data_output(next_pc));
 
mux4to1 write_addr(
  .data_input_0(adress1),
  .data_input_1(adress2),
  .data_input_2(adress3),
  .data_input_3(),
  .select(reg_dest),
  .data_output(write_address)); 

 

endmodule

	

module pipeline (
input clk,reset

);


 

wire [31:0] instruction_D,pc_plus, instruction_IFID, instruction_IDEX,instruction_EXMEM, instruction_MEMWB, instruction_F, write_data,
 alu_res_EXMEM,read_data_1_D, read_data_2_D, sign_extended_D, read_data1_IDEX, read_data2_IDEX, sign_ext_IDEX,alu_res,
RS_2, RS2_EXMEM, Dmemory_res, alu_res_MEMWB, Dmem_res_MEMWB, write_back_jr;

wire [31:0]  pc_IFID, next_pc,pc_IDEX, pc_EXMEM, pc_MEMWB;
wire [4:0] write_address_MEMWB, RS1_D, RS2_D, write_address_D, RS2_IDEX, write_address_IDEX, RS1_IDEX, write_address_EXMEM;
wire [3:0] aluop_D, aluop_IDEX;
wire [1:0] jump;
wire hold, reg_write_MEMWB, forwardA_Branch, forwardB_Branch, pc_to_reg, mem_read, mem_to_reg, mem_write, branch_valid, branch, mem_read_IDEX, mem_to_reg_EXMEM, 
reg_write_EXMEM, reg_write_IDEX, ld_has_hazard, branch_has_hazard, mem_to_reg_IDEX, pc_to_reg_IDEX, mem_write_IDEX, alusrc_IDEX, mem_read_EXMEM, pc_to_reg_EXMEM, 
mem_write_EXMEM, mem_to_reg_MEMWB, pc_to_reg_MEMWB,alusrc,reg_write;



fetch Fetch(
	.clk(clk),
	.reset(reset),
	.hold(hold),
	.next_pc(next_pc),
	.pc_plus(pc_plus),
	.instruction(instruction_F));

IFID	ifid(
	.clk(clk),
	.reset(reset), 
	.hold(hold),
	.iInstruction(instruction_F),
	.iPC(pc_plus),
	.flush(branch_has_hazard),
	.oInstruction(instruction_IFID),
	.oPC(pc_IFID));



decode Decode(
	 
	.instruction(instruction_IFID), 
	.write_data(write_data), 
	.alu_res_MEM(alu_res_EXMEM),
	
	.pc_plus(pc_IFID),
	.pc(pc_plus),
	.write_addr_WB(write_address_MEMWB),
	
	.clk(clk), 
	.reset(reset), 
	
	.reg_write_WB(reg_write_MEMWB), 
	.branch_hazard_A(forwardA_Branch), 
	.branch_hazard_B(forwardB_Branch), 


	.read_address_1(RS1_D), 
	.read_address_2(RS2_D),
	.read_data_1(read_data_1_D), 
	.read_data_2(read_data_2_D),
	.write_address(write_address_D),
	.sign_extended(sign_extended_D),
	 
	.next_pc(next_pc),
	 
	.aluop(aluop_D),
	 
	.reg_dest(), 
	.jump(jump),
	 
	.pc_to_reg(pc_to_reg), 
	.mem_read(mem_read), 
	.mem_to_reg(mem_to_reg), 
	.mem_write(mem_write), 
	.alusrc(alusrc), 
	.reg_write(reg_write), 
	.branch_valid(branch_valid), 
	.branch(branch)
);


hazard_detection HDU(
	.src1_ID(RS1_D), 
	.src2_ID(RS2_D), 
	.RD_IDEX(write_address_IDEX), 
	.RD_EXMEM(write_address_EXMEM),
	.RD_MEMWB(write_address_MEMWB),  
   .dest_EXE(RS2_IDEX),   
  .mem_read_IDEX(mem_read_IDEX),
  .mem_to_reg_EXMEM(mem_to_reg_EXMEM),
  .branch(branch), 
  .branchValid(branch_valid), 
  .writeBack_MEMWB(reg_write_MEMWB), 
  .writeBack_EXMEM(reg_write_EXMEM), 
  .writeBack_IDEX(reg_write_IDEX),
  .jump(jump),
  .ld_has_hazard(ld_has_hazard), 
  .branch_has_hazard(branch_has_hazard), 
  .hold(hold),
  .forwardA_Branch(forwardA_Branch),
  .forwardB_Branch(forwardB_Branch));
  
  
IDEX idex(

	.clock(clk), 
	.reset(reset), 
	 
	.imem_read(mem_read), 
	.imem_to_reg(mem_to_reg), 
	.ipc_to_reg(pc_to_reg), 
	.imem_write(mem_write), 
	.ialusrc(alusrc), 
	.ireg_write(reg_write), 
	
	
	.iPC(pc_IFID), 
	.iInstruction(instruction_IFID), 
	.iread_data1(read_data_1_D), 
	.iread_data2(read_data_2_D), 
	.isign_ext(sign_extended_D),
	
	.iwrite_addr(write_address_D),
	.iRS1(RS1_D),
	.iRS2(RS2_D),
	
	.ialuop(aluop_D),

	.flush(ld_has_hazard),

	
	.omem_read(mem_read_IDEX), 
	.omem_to_reg(mem_to_reg_IDEX), 
	.opc_to_reg(pc_to_reg_IDEX), 
	.omem_write(mem_write_IDEX), 
	.oalusrc(alusrc_IDEX), 
	.oreg_write(reg_write_IDEX),


	.oPC(pc_IDEX), 
	.oInstruction(instruction_IDEX), 
	.oread_data1(read_data1_IDEX), 
	.oread_data2(read_data2_IDEX), 
	.osign_ext(sign_ext_IDEX),
	
	.owrite_addr(write_address_IDEX),
	.oRS1(RS1_IDEX),
	.oRS2(RS2_IDEX),
	
	.oaluop(aluop_IDEX)
	


);



execute Execute(
	
	.instruction(instruction_IDEX),
	.read_data1_IDEX(read_data1_IDEX),
	.read_data2_IDEX(read_data2_IDEX),
	.write_data(write_data),
	.alu_res_EXMEM(alu_res_EXMEM),
	.sign_ext_IDEX(sign_ext_IDEX),
	
	.RS1_IDEX(RS1_IDEX), 
	.RS2_IDEX(RS2_IDEX),
	.write_addr_EXMEM(write_address_EXMEM),
	.write_addr_MEMWB(write_address_MEMWB),
	
	.reset(reset),
	.aluop(aluop_IDEX),
	.alusrc_IDEX(alusrc_IDEX),
	.reg_write_EXMEM(reg_write_EXMEM),
	.reg_write_MEMWB(reg_write_MEMWB),


	.alu_res(alu_res),
	.RS2_sw(RS_2)
);




EXMEM exmem(
	.clock(clk), 
	.reset(reset),
	.imem_read(mem_read_IDEX), 
	.imem_to_reg(mem_to_reg_IDEX),
	.ipc_to_reg(pc_to_reg_IDEX), 
	.imem_write(mem_write_IDEX),  
	.ireg_write(reg_write_IDEX),
	
	.iPC(pc_IDEX), 
	.iInstruction(instruction_IDEX), 
	.ialu_res(alu_res),
	.iRS2(RS_2),
	
	.iwrite_addr(write_address_IDEX),

	
	.omem_read(mem_read_EXMEM), 
	.omem_to_reg(mem_to_reg_EXMEM), 
	.opc_to_reg(pc_to_reg_EXMEM), 
	.omem_write(mem_write_EXMEM), 
	.oreg_write(reg_write_EXMEM),
	
	.oPC(pc_EXMEM), 
	.oInstruction(instruction_EXMEM),
	.oalu_res(alu_res_EXMEM), 
	.oRS2(RS2_EXMEM),
	.owrite_addr(write_address_EXMEM)
	
);


data_memory DataMemory(
	.clk(clk), 
	.reset(reset),
	.addr(alu_res_EXMEM),
	.write_data(RS2_EXMEM),
	.read_data(Dmemory_res), 
	.mem_read(mem_read_EXMEM), 
	.mem_write(mem_write_EXMEM));
	
	

	
MEMWB memwb(

	.clock(clk), 
	.reset(reset), 
	.imem_to_reg(mem_to_reg_EXMEM), 
	.ipc_to_reg(pc_to_reg_EXMEM),  
	.ireg_write(reg_write_EXMEM), 
	.iPC(pc_EXMEM), 
	.iInstruction(instruction_EXMEM), 
	.ialu_res(alu_res_EXMEM),
	.iData_mem_res(Dmemory_res),
	
	.iwrite_addr(write_address_EXMEM),

	.omem_to_reg(mem_to_reg_MEMWB), 
	.opc_to_reg(pc_to_reg_MEMWB), 
	.oreg_write(reg_write_MEMWB),
	.oPC(pc_MEMWB), 
	.oInstruction(instruction_MEMWB),
	.oalu_res(alu_res_MEMWB),
	.oData_mem_res(Dmem_res_MEMWB),
	 
	.owrite_addr(write_address_MEMWB));


	
mux2to1	writeBack_mux(
	.select(mem_to_reg_MEMWB),
	.data1(alu_res_MEMWB),
	.data2(Dmem_res_MEMWB),
	.outputdata(write_back_jr));
	

mux2to1	WB_jr(
	.select(pc_to_reg_MEMWB),
	.data1(write_back_jr),
	.data2(pc_MEMWB),
	.outputdata(write_data));





endmodule
















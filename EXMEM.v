module EXMEM(


	input clock, reset, imem_read, imem_to_reg, ipc_to_reg, imem_write,  ireg_write,
	input [31:0] iPC, iInstruction, ialu_res,iRS2,
	input[4:0] iwrite_addr,

	output reg  omem_read, omem_to_reg, opc_to_reg, omem_write, oreg_write,
	output reg [31:0] oPC, oInstruction,oalu_res, oRS2,
	output reg [4:0] owrite_addr
);

	
initial begin
	oPC =32'b0;
	oInstruction =32'b0;
end


always@ (posedge clock) 
begin
	if(~reset) begin
    oalu_res<=ialu_res;
    oRS2<=iRS2;
		omem_read <= imem_read;
		omem_to_reg <= imem_to_reg;
		opc_to_reg <= ipc_to_reg;
		omem_write <= imem_write;

		oreg_write <= ireg_write;
		oPC <= iPC;
		oInstruction <= iInstruction;

		owrite_addr <= iwrite_addr;

	end
end
endmodule

module EXMEM(clock, reset, iPC, iIR, iwrite_addr, imem_read, imem_to_reg, ipc_to_reg, imem_write, ireg_write, iRS2,
oPC, oIR, owrite_addr, omem_read, opc_to_reg, omem_write, oreg_write,ialu_res,oalu_res,omem_to_reg,oRS2);


	input clock, reset, imem_read, imem_to_reg, ipc_to_reg, imem_write,  ireg_write;
	input [31:0] iPC, iIR, ialu_res,iRS2;
	input[4:0] iwrite_addr;

	output reg  omem_read, omem_to_reg, opc_to_reg, omem_write, oreg_write;
	output reg [31:0] oPC, oIR,oalu_res, oRS2;
	output reg [4:0] owrite_addr;

	
initial begin
	oPC=32'b0;
	oIR=32'b0;
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
		oIR <= iIR;

		owrite_addr <= iwrite_addr;

	end
end
endmodule

module MEMWB(

input clock, reset, imem_to_reg, ipc_to_reg,  ireg_write,
input [31:0] iPC, iInstruction, ialu_res,iData_mem_res,
input[4:0] iwrite_addr,

output reg   omem_to_reg, opc_to_reg, oreg_write,
output reg [31:0] oPC, oInstruction,oalu_res,oData_mem_res,
output reg [4:0] owrite_addr);

initial begin
	oPC=32'b0;
	oInstruction=32'b0;
end

always@ (posedge clock) 
begin
	if(~reset) begin
    
		oalu_res <= ialu_res;
   
		
		omem_to_reg <= imem_to_reg;
		opc_to_reg <= ipc_to_reg;
		
		oreg_write <= ireg_write;
		oPC <= iPC;
		oInstruction <= iInstruction;

		owrite_addr <= iwrite_addr;
		if ( iData_mem_res === 32'bX) begin
			oData_mem_res <= oData_mem_res;
			end
		else begin
			oData_mem_res <= iData_mem_res;
			end
	end
end
endmodule

module IDEX(

input clock, reset,  imem_read, imem_to_reg, ipc_to_reg, imem_write, ialusrc, ireg_write,
input [31:0] iPC, iInstruction, iread_data1, iread_data2, isign_ext,
input[4:0] iwrite_addr,iRS1,iRS2,
input [3:0] ialuop,

input flush,

output reg  omem_read, omem_to_reg, opc_to_reg, omem_write, oalusrc, oreg_write,
output reg [31:0] oPC, oInstruction, oread_data1, oread_data2, osign_ext,
output reg [4:0] owrite_addr,oRS1,oRS2,
output reg [3:0] oaluop


);


initial begin
	oPC=32'b0;
	oInstruction=32'b0;
end

always@ (posedge clock) 
begin
	if(~flush) begin
	
		omem_read <= imem_read;
		omem_to_reg <= imem_to_reg;
		opc_to_reg <= ipc_to_reg;
		omem_write <= imem_write;
		oalusrc <= ialusrc;
		oreg_write <= ireg_write;
		oPC <= iPC;
		oInstruction <= iInstruction;
		oread_data1 <= iread_data1;
		oread_data2 <= iread_data2;
		owrite_addr <= iwrite_addr;
		oaluop <= ialuop;
		osign_ext <= isign_ext;
		oRS1 <=iRS1;
		oRS2 <=iRS2;
	end
	else begin
 
		omem_read <= 0;
		omem_to_reg <= 0;
		opc_to_reg <= 0;
		omem_write <= 0;
		oalusrc <= 0;
		oreg_write <= 0;
		oRS1 <=0;
		oRS2 <=0;
		oPC <= iPC;
		oInstruction <= iInstruction;
		oread_data1 <= 0;
		oread_data2 <= 0;
		owrite_addr <= 0;
		oaluop <=0;
		osign_ext <= 0;
	end
end
endmodule

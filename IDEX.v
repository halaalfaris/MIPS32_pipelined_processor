module IDEX(clock, reset, iPC, iIR, iwrite_addr, ibranch,ibranch_yes, ijump, imem_read, imem_to_reg, ipc_to_reg, ialuop, imem_write, ialusrc, ireg_write, iread_data1, iread_data2, isign_ext,iRS1,iRS2,
omem_to_reg,oPC, oIR, owrite_addr, omem_read, opc_to_reg,obranch,obranch_yes, ojump, oaluop, omem_write, oalusrc, oreg_write, oread_data1, oread_data2, osign_ext, hazard_detected,oRS1,oRS2,flush);



input clock, reset, ibranch,ibranch_yes,  imem_read, imem_to_reg, ipc_to_reg, imem_write, ialusrc, ireg_write, hazard_detected;
input [31:0] iPC, iIR, iread_data1, iread_data2, isign_ext;
input[4:0] iwrite_addr,iRS1,iRS2;
input [3:0] ialuop;
input [1:0] ijump;


output reg  omem_read, omem_to_reg, opc_to_reg, omem_write, oalusrc, oreg_write,obranch,obranch_yes;
output reg [31:0] oPC, oIR, oread_data1, oread_data2, osign_ext;
output reg [4:0] owrite_addr,oRS1,oRS2;
output reg [3:0] oaluop;
output reg [1:0] ojump;
input flush;


initial begin
	oPC=32'b0;
	oIR=32'b0;
end

always@ (posedge clock) 
begin
	if(~flush) begin
		obranch <= ibranch;
		obranch_yes <= ibranch_yes;
		ojump <= ijump; 
		omem_read <= imem_read;
		omem_to_reg <= imem_to_reg;
		opc_to_reg <= ipc_to_reg;
		omem_write <= imem_write;
		oalusrc <= ialusrc;
		oreg_write <= ireg_write;
		oPC <= iPC;
		oIR <= iIR;
		oread_data1 <= iread_data1;
		oread_data2 <= iread_data2;
		owrite_addr <= iwrite_addr;
		oaluop <= ialuop;
		osign_ext <= isign_ext;
		oRS1 <=iRS1;
		oRS2 <=iRS2;
	end
	else begin
		obranch <= 0;
		obranch_yes <= 0;
		ojump <= 0; 
		omem_read <= 0;
		omem_to_reg <= 0;
		opc_to_reg <= 0;
		omem_write <= 0;
		oalusrc <= 0;
		oreg_write <= 0;
		oRS1 <=0;
		oRS2 <=0;
		oPC <= iPC;
		oIR <= iIR;
		oread_data1 <= 0;
		oread_data2 <= 0;
		owrite_addr <= 0;
		oaluop <=0;
		osign_ext <= 0;
	end
end
endmodule

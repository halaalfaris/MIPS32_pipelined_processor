module IDEX(clock, reset, iPC, iIR, iwrite_addr, ibranch, ijump, imem_read, imem_to_reg, ipc_to_reg, ialuop, imem_write, ialusrc, ireg_write, iread_data1, iread_data2, isign_ext,iRS1,iRS2,
omem_to_reg,oPC, oIR, owrite_addr, omem_read, opc_to_reg, oaluop, omem_write, oalusrc, oreg_write, oread_data1, oread_data2, osign_ext, hazardA,hazardB,oRS1,oRS2,flush,hazard_A_IDEX,hazard_B_IDEX);



input clock, reset, ibranch, ijump, imem_read, imem_to_reg, ipc_to_reg, imem_write, ialusrc, ireg_write, hazardA,hazardB;
input [31:0] iPC, iIR, iread_data1, iread_data2, isign_ext;
input[4:0] iwrite_addr,iRS1,iRS2;
input [3:0] ialuop;



output reg  omem_read, omem_to_reg, opc_to_reg, omem_write, oalusrc, oreg_write,hazard_A_IDEX,hazard_B_IDEX;
output reg [31:0] oPC, oIR, oread_data1, oread_data2, osign_ext;
output reg [4:0] owrite_addr,oRS1,oRS2;
output reg [3:0] oaluop;

input flush;


initial begin
	oPC=32'b0;
	oIR=32'b0;
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
		oIR <= iIR;
		oread_data1 <= iread_data1;
		oread_data2 <= iread_data2;
		owrite_addr <= iwrite_addr;
		oaluop <= ialuop;
		osign_ext <= isign_ext;
		oRS1 <=iRS1;
		oRS2 <=iRS2;
		hazard_A_IDEX<=0;
		hazard_B_IDEX<=0;
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
		oIR <= iIR;
		oread_data1 <= 0;
		oread_data2 <= 0;
		owrite_addr <= 0;
		oaluop <=0;
		osign_ext <= 0;
		hazard_A_IDEX<=hazardA;
		hazard_B_IDEX<=hazardB;
	end
end
endmodule

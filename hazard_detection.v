
module hazard_detection(
  // Inputs:
  input  [4:0] src1_ID, src2_ID, RD_IDEX, RD_EXMEM, RD_MEMWB,  // Source registers in ID stage and beyond
  input [4:0] dest_EXE,   // Destination registers in EXE and MEM stages
  input  mem_read_IDEX,branch, branchYes, writeBack_MEMWB, writeBack_EXMEM, writeBack_IDEX,mem_to_reg_EXMEM, // Write-back enable signals for EXE and MEM and WB stages
  input [1:0]jump,
  
  // Output:
  output  ld_has_hazard, branch_has_hazard, hold, hazard,  // Signal indicating a hazard
  output  forwardA_Branch, forwardB_Branch
);

// Detect hazards between ID and EXE stages:
assign ld_has_hazard = (mem_read_IDEX && 
                         (src1_ID == dest_EXE || src2_ID == dest_EXE)); 

assign branch_has_hazard = (branch && branchYes) || jump[1] || jump[0];
/*branch forwarding is as follows = 00 => normal value/ 01=> from mem/ 10=> from writeback. a stall will happen
when dependecy with ex stage for one cycle, the result should appear in memory stage and then forwarded normally and the stall signal becomes 0
*/
//----------------------------------------------------------------------------------rs1 branch forward

assign forwardA_Branch = (writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM == src1_ID));

//---------------------------------------------------------------------------------- rs2 branch forward

			 
assign forwardB_Branch= (writeBack_EXMEM && (RD_EXMEM != 5'b0) && (RD_EXMEM == src2_ID));  

//----------------------------------------------------------------------------------execution stage stall signal

assign branch_hold = branch && ( ((writeBack_IDEX && (RD_IDEX != 5'b0) ) && ((RD_IDEX == src1_ID) || (RD_IDEX == src2_ID))) || (mem_to_reg_EXMEM && ((RD_EXMEM == src1_ID) || (RD_EXMEM == src2_ID))));

// Combine hazards:


assign hold = ld_has_hazard || branch_hold;

assign hazard = ld_has_hazard || branch_has_hazard;




endmodule
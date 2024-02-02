
module hazard_detection(
  // Inputs:
  input  [4:0] src1_ID, src2_ID,  // Source registers in ID stage
  input [4:0] dest_EXE,   // Destination registers in EXE and MEM stages
  input  mem_read_IDEX,branch, branchYes , // Write-back enable signals for EXE and MEM stages
 
  
  // Output:
  output  ld_has_hazard,ld_has_hazard_A,ld_has_hazard_B, branch_has_hazard, hazard, hold  // Signal indicating a hazard
);

// Detect hazards between ID and EXE stages:
assign ld_has_hazard_A = (mem_read_IDEX && 
                         (src1_ID == dest_EXE )); 

assign ld_has_hazard_B = (mem_read_IDEX && 
                         ( src2_ID == dest_EXE)); 

assign branch_has_hazard = (branch && branchYes);

// Combine hazards:
assign ld_has_hazard = ld_has_hazard_A ||ld_has_hazard_B ;
assign hazard = ld_has_hazard_A ||ld_has_hazard_B || branch_has_hazard; 
assign hold = ld_has_hazard_A||ld_has_hazard_B;



endmodule

module hazard_detection(
  // Inputs:
  input  [4:0] src1_ID, src2_ID,  // Source registers in ID stage
  input [4:0] dest_EXE,   // Destination registers in EXE and MEM stages
  input  mem_read_IDEX,branch, branchYes , // Write-back enable signals for EXE and MEM stages
  input [0:1]jump,
  
  // Output:
  output  ld_has_hazard, branch_has_hazard, hazard, hold  // Signal indicating a hazard
);

// Detect hazards between ID and EXE stages:
assign ld_has_hazard = (mem_read_IDEX && 
                         (src1_ID == dest_EXE || src2_ID == dest_EXE)); 

assign branch_has_hazard = (branch && branchYes) || jump[1] || jump[0];

// Combine hazards:
assign hazard = ld_has_hazard || branch_has_hazard; 
assign hold = ld_has_hazard;



endmodule
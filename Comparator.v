module Comparator (
  input wire [31:0] In1,
  input wire [31:0] In2,
  input wire [5:0] opcode,
  input wire reset,
  output reg branchValid
  
);


	
  always @(*)
	begin
    if (reset == 1) branchValid <=0;
    else begin
    case(opcode) 
        6'h6: begin if(In1 == In2) branchValid <= 1; else branchValid<= 0;  end
        6'h7: begin if(In1 != In2) branchValid <= 1; else branchValid<= 0;  end
        6'h8: begin if(In1 >= In2) branchValid <= 1; else branchValid<= 0;  end
        6'h9: begin if(In1 > In2) branchValid <= 1; else branchValid<= 0;   end
        6'hA: begin if(In1 <= In2) branchValid <= 1; else branchValid<= 0;  end
        6'hB: begin if(In1 < In2) branchValid <= 1; else branchValid<= 0;   end
		  default: begin branchValid<= 0; end
		  
      endcase
      end
  end

endmodule

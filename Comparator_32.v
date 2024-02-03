module Comparator_32bit (
  input wire [31:0] In1,
  input wire [31:0] In2,
  input wire [31:0] IR,
  input wire rst,
  output reg branchYes
  
);


	wire [5:0] opcode;
	reg eq, lt, gt, ge, le;
	assign opcode =  IR[31:26];
	
	
  always @(*)
	begin
    if (rst == 1) branchYes <=0;
    else begin
    case(opcode) 
        6'h8: begin if(In1 == In2) branchYes <= 1; else branchYes<= 0;  end
        6'h9: begin if(In1 != In2) branchYes <= 1; else branchYes<= 0;  end
        6'hA: begin if(In1 >= In2) branchYes <= 1; else branchYes<= 0;  end
        6'hB: begin if(In1 > In2) branchYes <= 1; else branchYes<= 0;   end
        6'hC: begin if(In1 <= In2) branchYes <= 1; else branchYes<= 0;  end
        6'hD: begin if(In1 < In2) branchYes <= 1; else branchYes<= 0;   end
      endcase
      end
  end

endmodule

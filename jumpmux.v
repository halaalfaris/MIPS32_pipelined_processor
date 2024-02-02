module jumpMux(input wire [31:0] newAddr,input wire [31:0] reg_value, input wire [31:0] addressBranch, input wire [1:0] jump, output reg [31:0] newPc);
always @(*)
 begin
	case(jump)
		2'b00:
		 newPc <= addressBranch;
		2'b01:
		 newPc <= newAddr; 
		2'b10:
		newPc <= reg_value; // select the 31st reg
	endcase
end
endmodule

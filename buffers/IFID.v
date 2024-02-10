module IFID(
input clk, reset, hold,
input [31:0] iInstruction,
input [31:0]iPC,
input flush,
output reg [31:0] oInstruction,
output reg [31:0] oPC);

initial begin
	oInstruction <= 32'b0;
	oPC <= 32'b0;
end

always @(posedge clk)
begin
if(~hold && ~reset && ~flush) begin
	oInstruction <= iInstruction;
	oPC <= iPC;
	end
else if(reset || flush) begin
	oInstruction <= 32'b0;
	oPC <= 32'b0;
	end

end
endmodule

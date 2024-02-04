module IFID(clk, reset,flush, iIR, iPC, oIR, oPC,hold);
input clk, reset, hold;
input [31:0] iIR;
input [7:0]iPC;
input flush;
output reg [31:0] oIR;
output reg [31:0] oPC;

initial begin
	oIR <= 32'b0;
	oPC <= 32'b0;
end

always @(posedge clk)
begin
if(~hold && ~reset && ~flush) begin
	oIR <= iIR;
	oPC <= iPC;
	end
else if(reset || flush) begin
	oIR <= 32'b0;
	oPC <= 32'b0;
	end

end
endmodule

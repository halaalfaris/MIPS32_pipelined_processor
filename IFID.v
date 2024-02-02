module IFID(clk, reset, iIR, iPC, oIR, oPC,hold);
input clk, reset, hold;
input [31:0] iIR;
input [7:0]iPC;
output reg [31:0] oIR;
output reg [31:0] oPC;

initial begin
	oIR <= 32'b0;
	oPC <= 32'b0;
end

always @(posedge clk)
begin
if(~hold && ~reset) begin
	oIR <= iIR;
	oPC <= iPC;
	end
else if(reset) begin
	oIR <= 32'b0;
	oPC <= 32'b0;
	end
else if(hold) begin
	oIR <= oIR;
	oPC <= oPC;
	end
end
endmodule

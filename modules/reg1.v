module reg1(clk,dataIn,dataOut);
input clk;
input [31:0] dataIn;
output reg [31:0] dataOut;

always @(posedge clk)begin
    dataOut<=dataIn;
end
endmodule

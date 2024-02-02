module mux2to1 (
    input wire select1,     // Select signal
    input wire [31:0] data1,// 32-bit input data
	 input wire [31:0] data2,// 32-bit input data
    output wire [31:0] outputdata // 32-bit output
);

assign outputdata = (select1) ? data2 : data1;

endmodule
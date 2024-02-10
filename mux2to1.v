module mux2to1 (
    input wire select,     
    input wire [31:0] data1,
	 input wire [31:0] data2,
    output wire [31:0] outputdata 
);

assign outputdata = (select) ? data2 : data1;

endmodule
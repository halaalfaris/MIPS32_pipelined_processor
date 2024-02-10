module extract_reg_adrr(
input wire [31:0] IR,
output wire [4:0] addr1,
output wire [4:0] addr2
);
assign addr1=IR[25:21];
assign addr2=IR[20:16];
endmodule

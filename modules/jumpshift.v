module jumpShift(input wire [31:0] target1, input wire [31:0] pcin, output wire [31:0] newAddr);
wire [31:26] pc = pcin[31:26];
wire [25:0] target = target1[25:0];
assign newAddr = {pc, target};
endmodule

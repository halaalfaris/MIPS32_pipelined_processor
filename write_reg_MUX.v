module write_reg_MUX (
    input wire[1:0] select1,     // Select signal
     input wire [31:0] data,// 32-bit input data
    output reg [4:0] outputdata 
);

always @(*)
 begin
    case(select1)
        2'b00:
        outputdata <= data[20:16];
        2'b01:
        outputdata <= data[15:11]; 
            2'b10:
        outputdata <= 5'b11111; // select the 31st reg
    endcase
end

endmodule
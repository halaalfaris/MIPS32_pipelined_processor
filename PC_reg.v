module PC_reg(
    input wire clock,     // Clock input
    input wire reset,     // Reset input (active high)
	 input wire hold,
    input wire [31:0] data_in1, // Data input (8-bit wide)
    output reg [7:0] data_out // Data output (8-bit wide)
);

wire [7:0] data_in;
assign data_in=data_in1[5:0];
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            data_out <= 8'b0;
				// Reset the register to 0 when reset is active
        end 
		  else if (hold) begin
				data_out <= data_out;
				end
		  else begin
            data_out <= data_in; // Load data_in into the register on the rising edge of the clock
        end
    end

endmodule

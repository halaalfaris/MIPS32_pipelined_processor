module PC_reg(
    input wire clock,     
    input wire reset,     
	 input wire hold,
    input wire [7:0] data_in, 
    output reg [7:0] data_out);


    always @(posedge clock or posedge reset) begin
        if (reset) begin
            data_out <= 8'b0;
				
        end 
		  else if (~hold) begin
				data_out <= data_in; 
				end

    end

endmodule

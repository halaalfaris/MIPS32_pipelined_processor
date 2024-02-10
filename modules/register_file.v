module register_file (
	input [4:0] read_addr_1, read_addr_2, write_addr, interfaceInput,
	input [31:0] write_data,
	input clk, reset, reg_write,
	output [31:0] read_data_1, read_data_2, interfaceOutput);


	reg [31:0] reg_file [31:0];
	
	integer k;
	
	assign read_data_1 = reg_file[read_addr_1];
	assign read_data_2 = reg_file[read_addr_2];
	assign interfaceOutput = reg_file[interfaceInput];
	
	always @(negedge clk or posedge reset) // Ou combines the block of reset into the block of posedge clk
	begin
		
		if (reset==1'b1)
		begin
			for (k=0; k<32; k=k+1) 
			begin
				reg_file[k] = 32'b0;
			end
		end 
		
		else if (reg_write == 1'b1)
			begin	
				 reg_file[write_addr] = write_data; 
				reg_file[0] = 32'b0;
			end
	end


endmodule

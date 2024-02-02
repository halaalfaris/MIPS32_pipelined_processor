

module data_memory (addr, write_data, read_data, clk, reset, mem_read, mem_write);
	input [31:0] addr;
	input [31:0] write_data;
	output [31:0] read_data;
	input clk, reset, mem_read, mem_write;
	reg [31:0] dmemory [255:0];
	integer k;
	
	//wire [5:0] shifted_addr;
	//assign shifted_addr=addr[7:2];
	assign read_data = (mem_read  && (addr<256)) ? dmemory[addr] : 32'bx;

	always @(posedge clk or posedge reset)// Ou modifies reset to posedge
	begin
		if (reset == 1'b1) 
			begin
				for (k=0; k<256; k=k+1) begin
					dmemory[k] = 32'b0;
				end
			end
		else
			if (mem_write && (addr<256)) dmemory[addr] = write_data;
	end
endmodule

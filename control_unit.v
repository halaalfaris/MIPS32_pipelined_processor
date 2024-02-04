module control_unit (IR, reg_dest, branch,flush, jump, mem_read, mem_to_reg,pc_to_reg, aluop, mem_write, alusrc, reg_write);
	input [31:0] IR;
	input flush;
	output reg  branch, pc_to_reg, mem_read, mem_to_reg, mem_write, alusrc, reg_write;
	output reg [1:0] jump;
	output reg [3:0] aluop;
	output reg [1:0] reg_dest;
	wire [5:0] opcode;
	assign opcode = IR[31:26];
	
	
	/*
	r-type   0
	sw 		1
	lw 		2
	addi		3
	andi		4
	ori		5
	beq 		6
	bne		7
	bge		8
	bgt		9
	ble		10
	blt		11
	jump		12
	jal 		13
	jr			14
	*/
	always @(*)
		begin 
		
			case(opcode)
				6'h0:	// r- type
				begin
					reg_dest <= 2'b01;
					branch <= 0;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 0;
					reg_write <= 1;
					pc_to_reg <= 0;
					aluop <= 4'b0010;
				end
				6'h1:	// sw
				begin
					reg_dest <= 2'b00;
					branch <= 0;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 1;
					alusrc <= 1;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b0000;
					end
				6'h2:	//lw
				begin
					reg_dest <= 2'b00;
					branch <= 0;
					jump <= 2'b00;
					mem_read <= 1;
					mem_to_reg <= 1;	
					mem_write <= 0;
					alusrc <= 1;
					reg_write <= 1;
					pc_to_reg <= 0;
					aluop <= 4'b0000;
					end
				6'h3:	//addi
				begin
					reg_dest <= 2'b00;
					branch <= 0;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 1;
					reg_write <= 1;
					pc_to_reg <= 0;
					aluop <= 4'b0000;
					end
				6'h4:	//andi
				begin
					reg_dest <= 2'b00;
					branch <= 0;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 1;
					reg_write <= 1;
					pc_to_reg <= 0;
					aluop <= 4'b0011;
				end
				6'h5:	//ori
				begin
					reg_dest <= 2'b00;
					branch <= 0;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 1;
					reg_write <= 1;
					pc_to_reg <= 0;
					aluop <= 4'b0100;
				end
				6'h6:	//beq
				begin
					reg_dest <= 2'b00;
					branch <= 1;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 0;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b0101;
				end
				6'h7:	//bne
				begin
					reg_dest <= 2'b00;
					branch <= 1;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 0;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b0110;
				end
				6'h8:	//bge
				begin
					reg_dest <= 2'b00;
					branch <= 1;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 0;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b0111;
				end
				6'h9:	//bgt
				begin
					reg_dest <= 2'b00;
					branch <= 1;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 0;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b1000;
				end
				6'hA:	//ble
				begin
					reg_dest <= 2'b00;
					branch <= 1;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 0;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b1001;
				end
				6'hB:	//blt
				begin
					reg_dest <= 2'b00;
					branch <= 1;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 0;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b1010;
				end
				6'hC:	//jump
				begin
					reg_dest <= 2'b00;
					branch <= 0;
					jump <= 2'b01;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 1;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b0000;
				end
				6'hD:	//jal
				begin
					reg_dest <= 2'b10;
					branch <= 0;
					jump <= 2'b01;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 1;
					reg_write <= 1;
					pc_to_reg <= 1;
					aluop <= 4'b0000;
				end
				6'hE:	//jr
				begin
					reg_dest <= 2'b10;
					branch <= 0;
					jump <= 2'b10;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 1;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b0000;
				end

				default: 
				begin
					reg_dest <= 2'b00;
					branch <= 0;
					jump <= 2'b00;
					mem_read <= 0;
					mem_to_reg <= 0;	
					mem_write <= 0;
					alusrc <= 0;
					reg_write <= 0;
					pc_to_reg <= 0;
					aluop <= 4'b0000;
				end
			
			endcase
			
		end
endmodule
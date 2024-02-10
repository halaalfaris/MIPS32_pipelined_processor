module aluCON (
input [3:0] aluop,
input [5:0] funct,
output reg [3:0] out_to_alu);
    
    
    /*
add 0
sub 1
and 2
or  3
xor 4
nor 5 
sll 6
srl 7
beq 8
bneq 9
bge 10
bgt 11
ble 12
blt 13
    */
always @(*)
    begin
        case(aluop)
            4'b0000:
                out_to_alu <= 4'd0;
            4'b0001:
                out_to_alu <= 4'd1;
            4'b0010:
                begin
                    case(funct)
                        4'h0: out_to_alu <= 4'h0; 
                        4'h1: out_to_alu <= 4'h1; 
                        4'h2: out_to_alu <= 4'h2; 
                        4'h3: out_to_alu <= 4'h3; 
                        4'h4: out_to_alu <= 4'h4; 
                        4'h5: out_to_alu <= 4'h5; 
                        4'h6: out_to_alu <= 4'h6;
                        4'h7: out_to_alu <= 4'h7;
                        4'hE: out_to_alu <= 4'hE;
                        4'hF: out_to_alu <= 4'hF;
								default:  out_to_alu <= 4'hx;
                    endcase
                end
            4'b0011:
                out_to_alu <= 4'd2;
            4'b0100:
                out_to_alu <= 4'd3;
            4'b0101:
                out_to_alu <= 4'd8;
            4'b0110:
                out_to_alu <= 4'd9;
            4'b0111:
                out_to_alu <= 4'd10;
            4'b1000:
                out_to_alu <= 4'd11;
            4'b1001:
                out_to_alu <= 4'd12;
            4'b1010:
                out_to_alu <= 4'd13;
				default:
					out_to_alu <= 4'd13;
        endcase
        
    end
    
    
endmodule

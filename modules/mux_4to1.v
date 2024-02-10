module mux_4to1 (
  input wire [31:0] data_input_0,
  input wire [31:0] data_input_1,
  input wire [31:0] data_input_2,
  input wire [31:0] data_input_3,
  input wire [1:0] select,
  output reg [31:0] data_output
);

always @* begin
  case (select)
    2'b00: data_output = data_input_0;
    2'b01: data_output = data_input_1;
    2'b10: data_output = data_input_2;
    2'b11: data_output = data_input_3;
    default: data_output = 32'b0; // Default case
  endcase
end

endmodule

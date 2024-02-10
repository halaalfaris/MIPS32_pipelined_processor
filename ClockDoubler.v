module ClockDoubler (
  input clk_in, // 50 MHz input clock
  output clk_out // 100 MHz output clock
);

  // Clock buffer for isolation
  wire clk_buf;
  BUFG bufg_inst (
    .I(clk_in),
    .O(clk_buf)
  );

  // Flip-flop for toggling
  reg toggle_reg;
  always @(posedge clk_buf) begin
    toggle_reg <= ~toggle_reg;
  end

  // Tristate gates for output control
  wire gated_clk1, gated_clk2;
  OBUF tristate_gate1 (
    .I(clk_buf),
    .O(gated_clk1),
    .T(toggle_reg)
  );
  OBUF tristate_gate2 (
    .I(clk_buf),
    .O(gated_clk2),
    .T(~toggle_reg)
  );

  // Combine the gated outputs for 100 MHz
  assign clk_out = gated_clk1 | gated_clk2;

endmodule

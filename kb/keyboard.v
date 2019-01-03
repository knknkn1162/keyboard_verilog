module keyboard (
  input wire i_ps2_kbclk, i_ps2_kbdat,
  output wire o_ledr0, o_ledr1
);

  assign o_ledr0 = i_ps2_kbclk;
  assign o_ledr1 = i_ps2_kbdat;

endmodule

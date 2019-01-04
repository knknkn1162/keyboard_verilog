`ifndef _keyboard_negedge_detector
`define _keyboard_negedge_detector

`include "enable_gen.v"
`include "posedge_detector.v"

module keyboard_negedge_detector (
  input wire clk, i_sclr, i_ps2_clk_n,
  output wire o_edge_en
);

  wire s_sampling_en;

  localparam SAMPLING_BIT_SIZE = 5; // approx. 1.6 MHz

  enable_gen #(SAMPLING_BIT_SIZE) enable_gen0(
    .clk(clk),
    .i_sclr(i_sclr),
    .o_en(s_sampling_en)
  );

  posedge_detector clk_posedge_detector (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(s_sampling_en),
    .i_dat(~i_ps2_clk_n),
    .o_posedge(o_edge_en)
  );

endmodule

`endif

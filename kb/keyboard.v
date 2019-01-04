`ifndef _keyboard
`define _keyboard


`include "keyboard_negedge_detector.v"
`include "flopr_en.v"
`include "toggle.v"
`include "hex_display.v"
`include "recv.v"

module keyboard (
  input wire clk, i_sclr,
  input wire i_ps2_clk_n, i_ps2_dat,
  output wire [6:0] o_hex0, o_hex1, o_hex2, o_hex3, o_hex4, o_hex5
);

  wire s_ps2_clk;
  wire s_edge_en;
  wire [23:0] s_data;

  keyboard_negedge_detector keyboard_negedge_detector0 (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_ps2_clk_n(i_ps2_clk_n),
    .o_edge_en(s_edge_en)
  );

  recv recv0(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(s_edge_en),
    .i_dat(i_ps2_dat),
    .o_data(s_data[7:0])
  );
  assign s_data[23:8] = 16'h0000;

  hex_display hex_display0 (
    .i_num(s_data),
    .o_hex0(o_hex0),
    .o_hex1(o_hex1),
    .o_hex2(o_hex2),
    .o_hex3(o_hex3),
    .o_hex4(o_hex4),
    .o_hex5(o_hex5)
  );

endmodule

`endif

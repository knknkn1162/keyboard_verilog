`ifndef _keyboard
`define _keyboard

`include "keyboard_negedge_detector.v"
`include "toggle.v"
`include "hex_display.v"
`include "recv.v"
`include "counter_en.v"

module keyboard (
  input wire clk, i_sclr,
  input wire i_ps2_clk_n, i_ps2_dat,
  output wire [6:0] o_hex0, o_hex1, o_hex2, o_hex3, o_hex4, o_hex5
);

  wire s_ps2_clk;
  wire s_edge_en;
  wire [23:0] s_byte;
  wire s_byte_en;

  keyboard_negedge_detector keyboard_negedge_detector0 (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_ps2_clk_n(i_ps2_clk_n),
    .o_edge_en(s_edge_en)
  );

  wire [7:0] s_cnt;
  counter_en #(8) counter_en0(
    .clk(clk), .i_sclr(i_sclr), .i_en(s_edge_en), .o_cnt(s_cnt)
  );

  recv recv0(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(s_edge_en),
    .i_dat(i_ps2_dat),
    .o_byte_en(s_byte_en),
    .o_byte(s_byte[7:0])
  );

  assign s_byte[23:16] = s_cnt;
  assign s_byte[15:8] = 8'h00;

  hex_display hex_display0 (
    .i_num(s_byte),
    .o_hex0(o_hex0),
    .o_hex1(o_hex1),
    .o_hex2(o_hex2),
    .o_hex3(o_hex3),
    .o_hex4(o_hex4),
    .o_hex5(o_hex5)
  );

endmodule

`endif

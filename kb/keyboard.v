`ifndef _keyboard
`define _keyboard

`include "kb_sampling_en.v"
`include "hex_display.v"
`include "recv.v"
`include "counter_en.v"
`include "shift_key.v"
`include "keydown.v"

`include "scancode2ascii.v"

module keyboard (
  input wire clk, i_sclr,
  input wire i_ps2_clk_n, i_ps2_dat,
  output wire [9:0] o_ledr,
  output wire [6:0] o_hex0, o_hex1, o_hex2, o_hex3, o_hex4, o_hex5
);

  wire s_kbclk_en;
  wire [7:0] s_byte0, s_byte1;
  wire s_byte_en;
  wire s_scan_valid;
  wire [7:0] s_scancode;
  wire s_shift, s_capslock;
  // for debug
  wire [23:0] s_num;
  wire [7:0] s_ascii;

  kb_sampling_en kb_sampling_en0 (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_ps2_clk_n(i_ps2_clk_n),
    .o_edge_en(s_kbclk_en)
  );

  recv recv0(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(s_kbclk_en),
    .i_dat(i_ps2_dat),
    .o_byte_en(s_byte_en),
    .o_byte(s_byte0)
  );

  // o_valid .. the i_byte signal is valid or not.
  keydown keydown0 (
    .clk(clk), .i_sclr(i_sclr),
    .i_byte_en(s_byte_en), .i_byte(s_byte0),
    .o_capslock(s_capslock),
    .o_byte(s_byte1),
    .o_valid(s_scan_valid)
  );

  shift_key shift_key0 (
    .clk(clk), .i_sclr(i_sclr),
    .i_byte_en(s_byte_en), .i_byte(s_byte0),
    .o_shift(s_shift)
  );

  scancode2ascii scancode2ascii0 (
    .clk(clk), .i_sclr(i_sclr),
    .i_scancode(s_byte1),
    .i_valid(s_scan_valid),
    .i_shift(s_shift),
    .i_capslock(s_capslock),
    .o_ascii(s_ascii)
  );

  // for debug
  assign o_ledr[7:0] = s_byte1;
  assign o_ledr[8] = s_shift;
  assign o_ledr[9] = s_scan_valid; //s_capslock;

  assign s_num[23:8] = 16'h0000;
  assign s_num[7:0] = s_ascii;
  hex_display hex_display0 (
    .i_num(s_num),
    .o_hex0(o_hex0),
    .o_hex1(o_hex1),
    .o_hex2(o_hex2),
    .o_hex3(o_hex3),
    .o_hex4(o_hex4),
    .o_hex5(o_hex5)
  );

endmodule

`endif

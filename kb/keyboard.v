`ifndef _keyboard
`define _keyboard

`include "kb_sampling_en.v"
`include "hex_display.v"
`include "recv.v"
`include "counter_en.v"
`include "keydown.v"

module keyboard (
  input wire clk, i_sclr,
  input wire i_ps2_clk_n, i_ps2_dat,
  output wire [9:0] o_ledr,
  output wire [6:0] o_hex0, o_hex1, o_hex2, o_hex3, o_hex4, o_hex5
);

  wire s_edge_en;
  wire [7:0] s_byte;
  wire s_byte_en;
  wire [7:0] s_char;
  // for debug
  wire [23:0] s_num;

  kb_sampling_en kb_sampling_en0 (
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
    .o_byte_en(s_byte_en),
    .o_byte(s_byte)
  );

  wire s_char_en;
  keydown keydown0 (
    .clk(clk), .i_sclr(i_sclr),
    .i_byte_en(s_byte_en), .i_byte(s_byte), .o_char(s_char),
    // for debug
    .o_char_en(s_char_en)
  );

  // for debug
  assign o_ledr[7:0] = s_char;
  assign o_ledr[9:8] = 2'b00;

  counter_en #(24) counter_en0(
    .clk(clk), .i_sclr(i_sclr), .i_en(s_char_en), .o_cnt(s_num)
  );
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

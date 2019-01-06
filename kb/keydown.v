`ifndef _keydown
`define _keydown

`include "bflopr_en.v"
`include "flopr_en.v"

module keydown (
  input wire clk, i_sclr,
  input wire i_byte_en,
  input wire [7:0] i_byte,
  output wire [7:0] o_char,
  // for debug
  output wire o_char_en
);

  localparam INIT_STATE = 1'b0;
  wire s_state, s_nextstate;
  wire s_char_en;
  wire s_f0_enb;

  bflopr_en flopr_fsm (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_byte_en),
    .i_a(s_nextstate), .o_y(s_state)
  );

  assign s_f0_enb = (i_byte == 8'hF0) ? 1'b1 : 1'b0;
  assign s_nextstate = (s_state == INIT_STATE) ? (s_state + s_f0_enb) : INIT_STATE;

  // s_char_en depends on current byte and state.
  assign s_char_en = ((s_state == INIT_STATE) & ~s_f0_enb) & i_byte_en;
  assign o_char_en = s_char_en; // for debug
  flopr_en #(8) flopr_char (
    .clk(clk), .i_sclr(i_sclr), .i_en(s_char_en),
    .i_a(i_byte), .o_y(o_char)
  );

endmodule

`endif

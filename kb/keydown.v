`ifndef _keydown
`define _keydown

`include "bflopr_en.v"
`include "flopr_en.v"
`include "toggle.v"

module keydown (
  input wire clk, i_sclr,
  input wire i_byte_en,
  input wire [7:0] i_byte,
  output wire [7:0] o_scancode,
  // for debug
  output wire o_scancode_en,
  output wire o_capslock
);

  localparam INIT_STATE = 1'b0;
  wire s_state, s_nextstate;
  wire s_scancode_en;
  wire s_f0, s_capslock;

  bflopr_en flopr_fsm (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_byte_en),
    .i_a(s_nextstate), .o_y(s_state)
  );

  assign s_f0 = (i_byte == 8'hF0);
  assign s_capslock = (i_byte == 8'h58);
  assign s_nextstate = (s_state == INIT_STATE) ? (s_state + s_f0) : INIT_STATE;

  // s_scancode_en depends on current byte and state.
  assign s_scancode_en = ((s_state == INIT_STATE) & ~s_f0) & i_byte_en;
  assign s_capslock_en = s_scancode_en & s_capslock;
  assign o_scancode_en = s_scancode_en; // for debug
  flopr_en #(8) flopr_scancode (
    .clk(clk), .i_sclr(i_sclr), .i_en(s_scancode_en),
    .i_a(i_byte), .o_y(o_scancode)
  );

  toggle #(1'b0) toggle0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(s_capslock_en),
    .o_sw(o_capslock)
  );

endmodule

`endif

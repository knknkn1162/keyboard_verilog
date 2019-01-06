`ifndef _keydown
`define _keydown

`include "bflopr_en.v"
`include "flopr_en.v"
`include "toggle.v"

module keydown (
  input wire clk, i_sclr,
  input wire i_byte_en,
  input wire [7:0] i_byte,
  output wire o_valid,
  output wire [7:0] o_byte,
  output wire o_capslock
);

  localparam INIT_STATE = 1'b0;
  wire s_state, s_nextstate;
  wire s_valid, s_capslock_en;
  wire s_f0, s_capslock;
  wire [8:0] s_byte_info0, s_byte_info1;

  bflopr_en flopr_fsm (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_byte_en),
    .i_a(s_nextstate), .o_y(s_state)
  );

  assign s_f0 = (i_byte == 8'hF0);
  assign s_capslock = (i_byte == 8'h58);
  assign s_nextstate = (s_state == INIT_STATE) ? (s_state + s_f0) : INIT_STATE;

  // s_scancode_en depends on current byte and state.
  assign s_valid = ((s_state == INIT_STATE) & ~s_f0);

  assign s_byte_info0 = {s_valid, i_byte};
  flopr_en #(9) flopr_en0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_byte_en),
    .i_a(s_byte_info0), .o_y(s_byte_info1)
  );
  assign o_valid = s_byte_info1[8];
  assign o_byte = s_byte_info1[7:0];

  assign s_capslock_en = s_valid & s_capslock & i_byte_en;
  toggle #(1'b0) toggle0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(s_capslock_en),
    .o_sw(o_capslock)
  );

endmodule

`endif

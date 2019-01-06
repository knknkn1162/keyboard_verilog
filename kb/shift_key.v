`ifndef _shift_key
`define _shift_key

`include "flopr_en.v"

module shift_key (
  input wire clk, i_sclr,
  input wire i_byte_en,
  input wire [7:0] i_byte,
  output wire o_shift
);

  localparam STATE_BIT_SIZE = 2;
  localparam INIT_STATE = {STATE_BIT_SIZE{1'b0}};
  localparam LSHIFT_SCANCODE = 8'h12;
  localparam RSHIFT_SCANCODE = 8'h59;

  wire [STATE_BIT_SIZE-1:0] s_state, s_nextstate;
  wire s_f0, s_shift;

  flopr_en #(STATE_BIT_SIZE) flopr_fsm (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_byte_en),
    .i_a(s_nextstate), .o_y(s_state)
  );

  assign s_f0 = (i_byte == 8'hF0);
  assign s_shift = (i_byte == LSHIFT_SCANCODE) | (i_byte == RSHIFT_SCANCODE);
  assign s_nextstate = nextstate(s_state, s_shift, s_f0);
  assign o_shift = (s_state == 2'b01 || s_state == 2'b10);

  function [STATE_BIT_SIZE-1:0] nextstate;
    input [STATE_BIT_SIZE-1:0] state;
    input shift;
    input f0;
  begin
    case (state)
      INIT_STATE: nextstate = (shift) ? 2'b01 : INIT_STATE;
      2'b01: nextstate = (f0) ? 2'b10 : 2'b01;
      2'b10: nextstate = (shift) ? INIT_STATE : 2'b01;
      default: nextstate = INIT_STATE;
    endcase
  end
  endfunction

endmodule

`endif

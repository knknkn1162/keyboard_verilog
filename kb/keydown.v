`ifndef _keydown
`define _keydown

`include "flopr_en.v"

module keydown (
  input wire clk, i_sclr,
  input wire i_byte_en,
  input wire [7:0] i_byte,
  output wire [7:0] o_char
);

  localparam STATE_BIT_SIZE = 2;
  localparam INIT_STATE = 2'b00;
  wire [STATE_BIT_SIZE-1:0] s_state, s_nextstate;
  wire s_char_en;

  flopr_en #(2) flopr_fsm (
    .clk(clk), .i_sclr(i_sclr), .i_en(s_byte_en),
    .i_a(s_nextstate), .o_y(s_state)
  );

  assign s_nextstate = nextstate(s_state, i_byte);

  assign s_char_en = (s_state == INIT_STATE) & s_byte_en;
  flopr_en #(8) flopr_char (
    .clk(clk), .i_sclr(i_sclr), .i_en(s_char_en),
    .i_a(i_byte), .o_y(o_char)
  );

  function [STATE_BIT_SIZE-1:0] nextstate;
    input [STATE_BIT_SIZE-1:0] state;
    input [7:0] byte;
    begin
      if (state == INIT_STATE) begin
        nextstate = (byte == 8'hF0) ? state + 1'b1 : state;
      end else if (state == 2'b01) begin
        nextstate = 2'b10;
      end else if (state == 2'b10) begin
        nextstate = INIT_STATE;
      end
    end
  endfunction

endmodule

`endif

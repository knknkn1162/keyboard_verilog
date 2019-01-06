`ifndef _recv
`define _recv

`include "flopr_en.v"
`include "bflopr_en.v"

module recv (
  input wire clk, i_sclr, i_en, i_dat,
  output wire o_byte_en,
  output wire [7:0] o_byte
);

  localparam BIT_SIZE = 8;
  wire [BIT_SIZE-1:0] s_byte0, s_byte1;
  wire s_parity0, s_parity1;
  wire [3:0] s_state, s_nextstate;

  flopr_en #(4) flopr_state (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(s_nextstate),
    .o_y(s_state)
  );

  flopr_en #(BIT_SIZE) flopr_byte0 (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(s_byte0),
    .o_y(s_byte1)
  );
  assign s_byte0 = (s_state >=4'b0001 && s_state <= 4'b1000) ? {i_dat, s_byte1[BIT_SIZE-1:1]} : s_byte1;

  bflopr_en bflopr_parity (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(s_parity0),
    .o_y(s_parity1)
  );
  assign s_parity0 = (s_state >= 4'b0001 && s_state <= 4'b1000) ? s_parity1 + i_dat : 1'b1;

  assign s_nextstate = nextstate(s_state, i_dat, s_parity1);

  assign o_byte_en = (s_state == 4'b1010) ? 1'b1 : 1'b0;
  assign o_byte = s_byte1;

  localparam START_BIT = 1'b0;
  localparam INIT_STATE = 4'b0000;
  function [3:0] nextstate;
    input [3:0] state;
    input dat;
    input parity;
  begin
    // start bit
    if (state == 4'b0000) begin
      nextstate = (dat== START_BIT) ? 4'b0001 : INIT_STATE;
    // byte
    end else if (state >= 4'b0001 && state <= 4'b1000) begin
      nextstate = state + 1'b1;
    // parity bit
    end else if (state == 4'b1001) begin
      nextstate = (parity==dat) ? 4'b1010 : INIT_STATE;
    // stop bit
    end else if (state == 4'b1010) begin
      nextstate = INIT_STATE;
    end else
      nextstate = INIT_STATE;
    end
  endfunction
endmodule

`endif

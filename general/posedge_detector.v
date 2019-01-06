`ifndef _posedge_detector
`define _posedge_detector

`include "shift_left_register.v"

module posedge_detector #(
  parameter BITS = 3,
  parameter TRIGGER = 3'b011
)(
  input wire clk, i_sclr, i_en, i_dat,
  output wire o_posedge
);

  wire [BITS-1:0] s_dat;
  shift_left_register #(BITS) slr0(
    .clk(clk), .i_sclr(i_sclr),
    .i_en(i_en), .i_dat(i_dat),
    .o_data(s_dat)
  );

  assign o_posedge = (s_dat == TRIGGER) & i_en;
endmodule

`endif

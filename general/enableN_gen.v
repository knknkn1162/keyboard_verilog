`ifndef _enableN_gen
`define _enableN_gen

`include "counterN_en.v"

module enableN_gen #(
  parameter ULIMIT = 10,
  parameter WIDTH = 4
) (
  input wire clk, i_sclr,
  output wire o_en
);

  wire [WIDTH-1:0] s_cnt;
  counterN_en #(ULIMIT, WIDTH) counterN_en0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(1'b1),
    .o_cnt(s_cnt)
  );

  assign o_en = (s_cnt == ULIMIT-1) ? 1'b1 : 1'b0;
endmodule

`endif

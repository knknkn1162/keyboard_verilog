`include "mux2.v"
`include "testbench.v"

module mux2_tb;

  parameter WIDTH = 32;
  parameter CLK_PERIOD = 10;

  reg [WIDTH-1:0] i_d0, i_d1;
  reg i_s;
  wire [WIDTH-1:0] o_y;

  mux2 #(WIDTH) mux2_0(
    .i_d0(i_d0),
    .i_d1(i_d1),
    .i_s(i_s),
    .o_y(o_y)
  );

  `dump_block

  initial begin
    #(CLK_PERIOD)
      i_d0 = 32'h00000001; i_d1 = 32'h00000002;
      i_s = 1'b0;
    #1
      `assert_eq(o_y, 32'h00000001);
      i_s = 1'b1;
    #1
      `assert_eq(o_y, 32'h00000002);

      `end_tb
  end

endmodule

`include "mux4.v"
`include "testbench.v"

module mux4_tb;

  parameter WIDTH = 32;
  parameter CLK_PERIOD = 10;

  reg [WIDTH-1:0] i_d00, i_d01, i_d10, i_d11;
  reg [1:0] i_s;
  wire [WIDTH-1:0] o_y;

  mux4 #(WIDTH) mux4_0(
    .i_d00(i_d00),
    .i_d01(i_d01),
    .i_d10(i_d10),
    .i_d11(i_d11),
    .i_s(i_s),
    .o_y(o_y)
  );

  `dump_block

  initial begin
    #(CLK_PERIOD)
      i_d00 = 32'h00000001;
      i_d01 = 32'h00000002;
      i_d10 = 32'h00000003;
      i_d11 = 32'h00000004;
      i_s = 2'b00;
    #1
      `assert_eq(o_y, 32'h00000001);
      i_s = 2'b01;
    #1
      `assert_eq(o_y, 32'h00000002);
      i_s = 2'b10;
    #1
      `assert_eq(o_y, 32'h00000003);
      i_s = 2'b11;
    #1
      `assert_eq(o_y, 32'h00000004);

      `end_tb
  end

endmodule

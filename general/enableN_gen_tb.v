`include "testbench.v"
`include "enableN_gen.v"

module enableN_gen_tb;
  parameter ULIMIT = 10;
  parameter WIDTH = 4;
  reg clk, i_sclr;
  wire o_en;

  parameter CLK_PERIOD = 10;

  enableN_gen #(ULIMIT, WIDTH) uut (
    .clk(clk),
    .i_sclr(i_sclr),
    .o_en(o_en)
  );

  `dump_block
  `conf_clk_block(clk, CLK_PERIOD)

  initial begin
    #(CLK_PERIOD)
      i_sclr = 1'b1;
    @(posedge clk) #1
      i_sclr = 1'b0;
      `assert_eq(o_en, 1'b0); // 0
    repeat(8) @(posedge clk) #1
      `assert_eq(o_en, 1'b0); // 8
    @(posedge clk) #1
      `assert_eq(o_en, 1'b1); // 9
    @(posedge clk) #1
      `assert_eq(o_en, 1'b0);
    @(posedge clk) #1
      `assert_eq(o_en, 1'b0);
    `end_tb
  end
endmodule

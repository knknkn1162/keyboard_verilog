`include "testbench.v"
`include "counterN_en.v"

module counterN_en_tb;

  reg clk, i_sclr, i_en;
  wire [3:0] o_cnt;

  parameter CLK_PERIOD = 10;
  parameter ULIMIT = 10;
  parameter WIDTH = 4;

  counterN_en #(ULIMIT, WIDTH) uut(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .o_cnt(o_cnt)
  );

  `dump_block
  `conf_clk_block(clk, CLK_PERIOD)

  initial begin
    #(CLK_PERIOD)
    @(posedge clk)
      i_sclr = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0000);
      i_sclr = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0000);
      i_en = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0001);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0010);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0011);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0100);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0101);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0110);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0111);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b1000);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b1001);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0000);
    @(posedge clk) #1
      `assert_eq(o_cnt, 4'b0001);

    `end_tb
  end
endmodule

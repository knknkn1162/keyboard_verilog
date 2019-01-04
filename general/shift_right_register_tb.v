`include "testbench.v"
`include "shift_right_register.v"

module shift_right_register_tb;
  parameter BITS = 5;
  reg clk, i_sclr, i_en, i_dat;
  wire [BITS-1:0] o_data;

  parameter CLK_PERIOD = 10;
  shift_right_register #(BITS) uut(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_dat(i_dat),
    .o_data(o_data)
  );

  `dump_block
  `conf_clk_block(clk, CLK_PERIOD)

  initial begin
    #(CLK_PERIOD)
      i_sclr = 1'b1;
    @(posedge clk) #1
      i_sclr = 1'b0;
      `assert_eq(o_data, 5'b00000);
      i_dat = 1'b1;
      i_en = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_data, 5'b10000);
      i_dat = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_data, 5'b01000);
      i_dat = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_data, 5'b10100);
      i_dat = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_data, 5'b11010);
      i_dat = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_data, 5'b11101);
      i_dat = 1'b1;
    @(posedge clk) #1
      `assert_eq(o_data, 5'b11110);
      i_dat = 1'b0;
    @(posedge clk) #1
      `assert_eq(o_data, 5'b01111);


    `end_tb
  end

endmodule

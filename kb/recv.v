`ifndef _recv
`define _recv

`include "flopr_en.v"
`include "bflopr_en.v"

module recv (
  input wire clk, i_sclr, i_en, i_dat,
  output wire [7:0] o_data
);

  localparam BIT_SIZE = 8;
  wire [BIT_SIZE-1:0] s_data0, s_data1, s_data2;
  wire s_parity0, s_parity1;
  wire s_data_en;
  wire [3:0] s_stage, s_nextstage;

  flopr_en #(4) flopr_stage (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(s_nextstage),
    .o_y(s_stage)
  );
  assign s_nextstage = nextstage(s_stage, i_dat, s_parity1);

  flopr_en #(BIT_SIZE) flopr_data0 (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(s_data0),
    .o_y(s_data1)
  );
  assign s_data0 = (s_stage >=4'b0001 && s_stage <= 4'b1000) ? {s_data1[BIT_SIZE-2:0], i_dat} : s_data1;

  bflopr_en bflopr_parity (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(s_parity0),
    .o_y(s_parity1)
  );
  assign s_parity0 = (s_stage >= 4'b0001 && s_stage <= 4'b1000) ? s_parity1 + i_dat : 1'b1;
  
  assign s_data_en = (s_stage == 4'b1010) ? 1'b1 : 1'b0;
  flopr_en #(8) flopr_data1 (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(s_data_en),
    .i_a(s_data1),
    .o_y(s_data2)
  );

  assign o_data = s_data2;

  localparam START_BIT = 1'b0;
  localparam INIT_STATE = 4'b0000;
  function [3:0] nextstage;
    input [3:0] stage;
    input dat;
    input parity;
  begin
    // start bit
    if (stage == 4'b0000) begin
      nextstage = (dat== START_BIT) ? 4'b0001 : INIT_STATE;
    // data
    end else if (stage >= 4'b0001 && stage <= 4'b1000) begin
      nextstage = stage + 1'b1;
    // parity bit
    end else if (stage == 4'b1001) begin
      nextstage = (parity==dat) ? 4'b1010 : INIT_STATE;
    // stop bit
    end else if (stage == 4'b1010) begin
      nextstage = INIT_STATE;
    end else
      nextstage = INIT_STATE;
    end
  endfunction
endmodule

`endif

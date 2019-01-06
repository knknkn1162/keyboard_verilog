`ifndef _kb_sampling_en
`define _kb_sampling_en

`include "enable_gen.v"
`include "posedge_detector.v"

module kb_sampling_en (
  input wire clk, i_sclr, i_ps2_clk_n,
  output wire o_edge_en
);

  wire s_sampling_en;

  localparam SAMPLING_BIT_SIZE = 6; // approx. 0.8 MHz

  enable_gen #(SAMPLING_BIT_SIZE) enable_gen0(
    .clk(clk),
    .i_sclr(i_sclr),
    .o_en(s_sampling_en)
  );

  reg [5:0] r_en;
  always @(posedge clk) begin
    if (i_sclr) begin
      r_en <= 6'b000000;
    end else if (s_sampling_en) begin
      r_en <= {r_en[4:0], i_ps2_clk_n};
    end
  end

  assign o_edge_en = (r_en[5:0] == 6'b111000) & s_sampling_en;

endmodule

`endif

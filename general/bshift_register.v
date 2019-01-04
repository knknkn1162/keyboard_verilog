`ifndef _bshift_register
`define _bshift_register

module bshift_register #(
  parameter BITS = 32
) (
  input wire clk, i_sclr, i_en, i_dat,
  output wire [BITS-1:0] o_data
);

  reg [BITS-1:0] s_bits;
  always @(posedge clk) begin
    if (i_sclr) begin
      s_bits <= {BITS{1'b0}};
    end else if (i_en) begin
      s_bits <= {s_bits[BITS-2:0], i_dat};
    end
  end
  assign o_data = s_bits;
endmodule

`endif

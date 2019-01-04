`ifndef _shift_right_register
`define _shift_right_register

module shift_right_register #(
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
      s_bits <= {i_dat, s_bits[BITS-1:1]};
    end
  end
  assign o_data = s_bits;
endmodule

`endif

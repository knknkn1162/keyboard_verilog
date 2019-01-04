`ifndef _mux4
`define _mux4

module mux4 #(
  parameter WIDTH = 32
) (
  input wire [WIDTH-1:0] i_d00, i_d01, i_d10, i_d11,
  input wire [1:0] i_s,
  output reg [WIDTH-1:0] o_y
);

  always @* begin
    case (i_s)
      2'b00: o_y <= i_d00;
      2'b01: o_y <= i_d01;
      2'b10: o_y <= i_d10;
      2'b11: o_y <= i_d11;
      default: o_y <= {WIDTH{1'bX}};
    endcase
  end
endmodule


`endif


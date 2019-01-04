`ifndef _hex_display
`define _hex_display

`include "hex_decoder.v"

module hex_display (
  input wire [23:0] i_num,
  output wire [6:0] o_hex0,
  output wire [6:0] o_hex1,
  output wire [6:0] o_hex2,
  output wire [6:0] o_hex3,
  output wire [6:0] o_hex4,
  output wire [6:0] o_hex5
);

  genvar i;

  wire [41:0] s_hex;
  generate
    for(i = 0; i < 6; i=i+1) begin: gen_decoder
      hex_decoder dec0(
        .i_num(i_num[i*4+3:i*4]),
        .o_seg7(s_hex[i*7+6:i*7])
      );
    end
  endgenerate

  assign o_hex0 = s_hex[6:0];
  assign o_hex1 = s_hex[13:7];
  assign o_hex2 = s_hex[20:14];
  assign o_hex3 = s_hex[27:21];
  assign o_hex4 = s_hex[34:28];
  assign o_hex5 = s_hex[41:35];
endmodule

`endif

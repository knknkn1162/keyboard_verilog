`ifndef _hex_decoder
`define _hex_decoder

module hex_decoder (
  input wire [3:0] i_num,
  output reg [6:0] o_seg7
);

  always @* begin
    case (i_num)
      4'h0: o_seg7 <= 7'b100_0000;
      4'h1: o_seg7 <= 7'b111_1001;
      4'd2: o_seg7 <= 7'b010_0100;
      4'h3: o_seg7 <= 7'b011_0000;
      4'h4: o_seg7 <= 7'b001_1001;
      4'h5: o_seg7 <= 7'b001_0010;
      4'h6: o_seg7 <= 7'b000_0010;
      4'h7: o_seg7 <= 7'b101_1000;
      4'h8: o_seg7 <= 7'b000_0000;
      4'h9: o_seg7 <= 7'b001_0000;
      4'ha: o_seg7 <= 7'b000_1000;
      4'hb: o_seg7 <= 7'b000_0011;
      4'hc: o_seg7 <= 7'b100_0110;
      4'hd: o_seg7 <= 7'b010_0001;
      4'he: o_seg7 <= 7'b000_0110;
      4'hf: o_seg7 <= 7'b000_1110;
      default: o_seg7 <= 7'bXXX_XXXX;
    endcase
  end

endmodule

`endif

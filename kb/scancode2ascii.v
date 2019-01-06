`ifndef _scancode2ascii
`define _scancode2ascii

module scancode2ascii (
  input wire [7:0] i_scancode,
  input wire i_shift, i_capslock,
  output wire [7:0] o_ascii
);

  wire s_camel;
  assign s_camel = i_shift ^ i_capslock;
  assign o_ascii = ascii(i_scancode, s_camel, i_shift);

  function [7:0] ascii;
    input [7:0] scancode;
    input camel;
    input shift;
    begin
      case (scancode)
        // see http://www.ne.jp/asahi/shared/o-family/ElecRoom/AVRMCOM/PS2_RS232C/KeyCordList.pdf
        // // 1 ~ 0 or symbol
        8'h16: ascii = (shift) ? 8'h21 : 8'h31;
        8'h1E: ascii = (shift) ? 8'h22 : 8'h32;
        8'h26: ascii = (shift) ? 8'h23 : 8'h33;
        8'h25: ascii = (shift) ? 8'h24 : 8'h34;
        8'h2E: ascii = (shift) ? 8'h25 : 8'h35;
        8'h36: ascii = (shift) ? 8'h26 : 8'h36;
        8'h3D: ascii = (shift) ? 8'h27 : 8'h37;
        8'h3E: ascii = (shift) ? 8'h28 : 8'h38;
        8'h46: ascii = (shift) ? 8'h29 : 8'h39;
        8'h45: ascii = 8'h30;
        // a ~ z
        8'h1C: ascii = (camel) ? 8'h41 : 8'h61;
        8'h32: ascii = (camel) ? 8'h42 : 8'h62;
        8'h21: ascii = (camel) ? 8'h43 : 8'h63;
        8'h23: ascii = (camel) ? 8'h44 : 8'h64;
        8'h24: ascii = (camel) ? 8'h45 : 8'h65;
        8'h2B: ascii = (camel) ? 8'h46 : 8'h66;
        8'h34: ascii = (camel) ? 8'h47 : 8'h67;
        8'h33: ascii = (camel) ? 8'h48 : 8'h68;
        8'h43: ascii = (camel) ? 8'h49 : 8'h69;
        8'h3B: ascii = (camel) ? 8'h4A : 8'h6A;
        8'h42: ascii = (camel) ? 8'h4B : 8'h6B;
        8'h4B: ascii = (camel) ? 8'h4C : 8'h6C;
        8'h3A: ascii = (camel) ? 8'h4D : 8'h6D;
        8'h31: ascii = (camel) ? 8'h4E : 8'h6E;
        8'h44: ascii = (camel) ? 8'h4F : 8'h6F;
        8'h4D: ascii = (camel) ? 8'h50 : 8'h70;
        8'h15: ascii = (camel) ? 8'h51 : 8'h71;
        8'h2D: ascii = (camel) ? 8'h52 : 8'h72;
        8'h1B: ascii = (camel) ? 8'h53 : 8'h73;
        8'h2C: ascii = (camel) ? 8'h54 : 8'h74;
        8'h3C: ascii = (camel) ? 8'h55 : 8'h75;
        8'h2A: ascii = (camel) ? 8'h56 : 8'h76;
        8'h1D: ascii = (camel) ? 8'h57 : 8'h77;
        8'h22: ascii = (camel) ? 8'h58 : 8'h78;
        8'h35: ascii = (camel) ? 8'h59 : 8'h79;
        8'h1A: ascii = (camel) ? 8'h5A : 8'h7A;
        // symbol
        8'h4E: ascii = (shift) ? 8'h3D : 8'h2D;
        8'h55: ascii = (shift) ? 8'h7E : 8'h5E;
        8'h6A: ascii = (shift) ? 8'h7C : 8'h5C;
        8'h54: ascii = (shift) ? 8'h60 : 8'h40;
        8'h5B: ascii = (shift) ? 8'h7B : 8'h5B;
        8'h4C: ascii = (shift) ? 8'h2B : 8'h3B;
        8'h52: ascii = (shift) ? 8'h2A : 8'h3A;
        8'h5D: ascii = (shift) ? 8'h7D : 8'h5D;
        8'h41: ascii = (shift) ? 8'h3C : 8'h2C;
        8'h49: ascii = (shift) ? 8'h3E : 8'h2E;
        8'h4A: ascii = (shift) ? 8'h3F : 8'h2F;
        8'h51: ascii = 8'h5F; // _
        8'h66: ascii = 8'h08; // backspace
        8'h5A: ascii = 8'h0D; // enter
        8'h29: ascii = 8'h20; // space
        8'h76: ascii = 8'h1B; // etc
        // undefined
        default: ascii = 8'hFF;
      endcase
    end
  endfunction

endmodule

`endif

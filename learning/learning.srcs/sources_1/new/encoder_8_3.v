`timescale 1ns / 1ps

module encoder_8_3(
    input [7:0] in,
    output [2:0] out
);
assign out = in[0]?3'd0:
             in[1]?3'd1:
             in[2]?3'd2:
             in[3]?3'd3:
             in[4]?3'd4:
             in[5]?3'd5:
             in[6]?3'd6:
             3'd7;
endmodule
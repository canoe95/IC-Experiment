`timescale 1ns / 1ps
`include "defines.v"
module decoder_6_64(
    input[5:0]in,
    output[63:0]out
    );
    //��������ʽ
    genvar i;
    generate
        for(i=0;i<64;i=i+1)
        begin:bit
            assign out[i]=(in==i);
        end
    endgenerate
endmodule
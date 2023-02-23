`timescale 1ns / 1ps
`include "defines.v"
module decoder_5_32(
    input[4:0]in,
    output[31:0]out
    );
    genvar i;
    generate
        for(i=0;i<32;i=i+1)
        begin:bit
            assign out[i]=(in==i);
        end
    endgenerate
endmodule

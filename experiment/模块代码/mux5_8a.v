`timescale 1ns / 1ps

module mux5_8a(
    input [7:0] in0 , in1 , in2 , in3 , in4 ,
    input [2:0] sel,
    output [7:0] out
    );
    assign out = (sel == 3'd0)?in0:(sel == 3'd1)?in1:
                 (sel == 3'd2)?in2:(sel == 3'd3)?in3:
                 (sel == 3'd4)?in4:7'd0;
endmodule

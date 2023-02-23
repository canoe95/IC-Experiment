`timescale 1ns / 1ps

module decoder_3_8_tb(
    );
    reg [2:0] in0;
    wire [7:0] out0;
    decoder_3_8 decoder_3_80(.in(in0), .out(out0));
    integer i = 0;
    initial begin
       for(i=0; i <=7; i=i+1)begin
           # 10
           in0 = i;       
       end
       # 30
       $finish;
    end
endmodule

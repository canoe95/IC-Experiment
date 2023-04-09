`timescale 1ns / 1ps

module mux5_8a_tb(
    );
    reg [7:0] in0 , in1 , in2 ,in3 , in4 ;
    reg [2:0] sel;
    wire [7:0] out;
    mux5_8a m (in0 , in1 , in2 , in3 , in4 , sel , out);
    integer i = 0;
    initial begin
        in0 = 8'd2;
        in1 = 8'd4;
        in2 = 8'd8;
        in3 = 8'd16;
        in4 = 8'd32;
        for( i = 0;i<=7 ; i = i+1)begin
            #10;
            sel = i;
        end
        #20;
        $finish;
    end
endmodule

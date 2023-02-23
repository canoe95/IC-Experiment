`timescale 1ns / 1ps

module encoder_8_3_tb(
    );
    reg [7:0] in;
    wire [2:0] out;
    encoder_8_3 encoder(.in(in),.out(out));
    integer i = 0;
    initial begin
        in = 1;
        #10;
        for(i = 0; i <= 6; i = i+1)begin
            in = in << 1; // 左移一位，表示 0，1，2，3，4，5，6，7
            #10;
        end
        #20;
        $finish;
    end
endmodule

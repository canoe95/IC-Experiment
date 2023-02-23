`timescale 1ns / 1ps

module div32_tb(
    );
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] result;
    wire [31:0] remainder;
    
    div32 div320(a, b, result, remainder);
    
    integer i;
    initial begin
        b = 32'd7;
        for(i = 102; i < 152; i = i+1) begin
            #20
            a = i;
        end
        #1000 $finish;
    end
endmodule

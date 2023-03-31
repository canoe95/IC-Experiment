`timescale 1ns / 1ps

// D ´¥·¢Æ÷£¨·´ÏàÆ÷£©
module dff(
    input wire d,
    input wire clk,
    output reg q
    );
    always@(posedge clk)begin
        q <= d;
    end
endmodule

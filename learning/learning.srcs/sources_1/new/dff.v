`timescale 1ns / 1ps

// D ����������������
module dff(
    input wire d,
    input wire clk,
    output reg q
    );
    always@(posedge clk)begin
        q <= d;
    end
endmodule

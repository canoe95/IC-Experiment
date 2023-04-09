`timescale 1ns / 1ps

module dffSyn(
    input wire d,
    input wire clk,
    input wire reset,
    output reg q
    );
    always @(posedge clk)begin
        // reset�͵�ƽ��Ч���������
        if(!reset)begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
endmodule

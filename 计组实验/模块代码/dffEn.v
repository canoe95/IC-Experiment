`timescale 1ns / 1ps

module dffEn(
    input wire d,
    input wire en,
    input wire clk,
    output reg q
    );
    
    always @(posedge clk) begin
        if(en) begin
            q <= d;
        end
    end
endmodule

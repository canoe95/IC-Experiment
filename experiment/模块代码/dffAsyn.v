`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/29 20:52:58
// Design Name: 
// Module Name: dffAsyn
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dffAsyn(
    input wire d,
    input wire reset,
    input wire clk,
    output reg q
    );
    
    always @(posedge clk or negedge reset) begin
        if(!reset) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
endmodule

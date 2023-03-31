`timescale 1ns / 1ps
`include "defines.v"
module mem_wb(
        input wire clk,
        input wire rst,
        input wire [`regdatabus] mem_wdata,
        input wire [`regaddrbus] mem_wd,
        input wire mem_wreg,
        output reg[`regdatabus] wb_wdata,
        output reg[`regaddrbus] wb_wd,
        output reg wb_wreg 
         );
         always @ (posedge clk)begin
         if (rst)begin
            wb_wd=`zeroregaddr;
            wb_wdata=`zeroword;
            wb_wreg=`writedisable;
         end else begin
            wb_wd=mem_wd;
            wb_wdata=mem_wdata;
            wb_wreg=mem_wreg;
         end
         end
endmodule

`timescale 1ns / 1ps
`include "defines.v"

module ex_mem(
        input wire clk,
        input wire rst,
        input wire [`regdatabus] ex_wdata,
        input wire [`regaddrbus] ex_wd,
        input wire ex_wreg,
        output reg[`regdatabus]mem_wdata,
        output reg[`regaddrbus]mem_wd,
        output reg mem_wreg,
        /////////¥Ê¥¢÷∏¡Ó
        input wire [`aluop_onehotbus] ex_aluop, 
        input wire [`regbus] ex_mem_addr,
        input wire [`regbus] ex_reg2,
        output reg [`aluop_onehotbus] mem_aluop, 
        output reg [`regbus] mem_mem_addr,
        output reg [`regbus] mem_reg2      
        );
        always @(posedge clk)begin
        if(rst)begin
        mem_wd=`zeroregaddr;
        mem_wdata=`zeroword;
        mem_wreg=`writedisable;
        
         mem_aluop=`aluopzero;
         mem_mem_addr=`zeroword;
         mem_reg2=`zeroword;   
        end else begin
         mem_wd=ex_wd;
         mem_wdata=ex_wdata;
         mem_wreg=ex_wreg;
         
         mem_aluop=ex_aluop;
         mem_mem_addr=ex_mem_addr;
         mem_reg2= ex_reg2;
        end
        end
endmodule


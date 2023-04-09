`timescale 1ns / 1ps
`include "defines.v"

module inst_rom(
    input wire ce,
    input wire [`instaddrbus] addr,//指令地址
    output reg [`instbus] inst
    );
    reg [`instbus] inst_mem[0:127];
    // 将指令读入 inst_mem
    initial begin
           $readmemh("c:/file/vivado/inst_rom.data",inst_mem);  
    end
    
    always @(*)begin
        if(ce==0)begin
            inst<=`zeroword;//返回的指令为全0
        end else begin
            inst<=inst_mem[addr[31:2]];//老师写的麻烦，就改了
             //inst<=inst_mem[addr[6:0]];
            //instmem大小为128*4B只需要7位地址线，所以用addr的6到0位作为地址就可以了，addr的数每次+1`b1.
            //instmem的单位地址大小位4B，所以存取的内容为32位
        end
    end
endmodule
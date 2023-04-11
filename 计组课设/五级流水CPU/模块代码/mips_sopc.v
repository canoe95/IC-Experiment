`timescale 1ns / 1ps
`include"defines.v"
module mips_sopc(
    input wire clk,
    input wire rst//高电平复位
    );
    wire rom_ce = 1;//使能，高电平允许使用
    wire[`instaddrbus]inst_addr;//指令地址为32位
    wire[`instbus]inst;//返回指令
    cpu cpu0(rst,clk,inst,rom_ce,inst_addr);
    inst_rom inst_rom0(rom_ce,inst_addr,inst);
endmodule
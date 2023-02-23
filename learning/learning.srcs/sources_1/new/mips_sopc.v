`timescale 1ns / 1ps
`include "./defines.v"

module mips_sopc(
    input wire clk,
    input wire rst
    );
    wire rom_ce;
    wire[`InstAddrBus]inst_addr;
    wire[`InstBus]inst;
    singlecycle_cpu singlecycle_cpu0(rst, clk, inst, rom_ce, inst_addr);
    inst_rom inst_rom0(rom_ce, inst_addr, inst);
endmodule
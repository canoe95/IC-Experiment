`timescale 1ns / 1ps
`include"defines.v"
module mips_sopc(
    input wire clk,
    input wire rst//�ߵ�ƽ��λ
    );
    wire rom_ce = 1;//ʹ�ܣ��ߵ�ƽ����ʹ��
    wire[`instaddrbus]inst_addr;//ָ���ַΪ32λ
    wire[`instbus]inst;//����ָ��
    cpu cpu0(rst,clk,inst,rom_ce,inst_addr);
    inst_rom inst_rom0(rom_ce,inst_addr,inst);
endmodule
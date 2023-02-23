`timescale 1ns / 1ps
`include "defines.v"

// �� pc ģ��� inst_mem ͨ���ڲ�ʵ���������ӡ��γɴ�� inst_fetch ģ��
module inst_fetch(
    input wire clk,
    input wire rst,
    output wire [`InstBus] inst_o
    );
    // �ڲ��ź�ͨ��pc�������inst_rom������������
    wire [`InstAddrBus]pc;
    wire ce;
    pc pc0(.ce(ce), .clk(clk), .pc(pc), .rst(rst));
    inst_rom inst_rom0(.ce(ce), .addr(pc), .inst(inst_o));
endmodule

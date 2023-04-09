`timescale 1ns / 1ps
`include "defines.v"

// �൱�ڵ��ߣ�ֱ�Ӱ� pc ��������뵽 id �У��м��� if_id ����
module if_id(
    input wire clk,
    input wire rst,
    input wire [`instbus] if_inst,
    output reg[`instbus] id_inst,

    input  wire [`instaddrbus] pc_i,// ��ifid��ַ
    output reg  [`instaddrbus] pc_o// ��ifid��ַ
    );
    always@(posedge clk)begin
        if(rst)begin
            id_inst=`zeroword;
            pc_o=32'h00000000;
        end else begin
            id_inst=if_inst;//ֻ����ָ��
            pc_o=pc_i;
        end
    end
endmodule

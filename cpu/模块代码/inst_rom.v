`timescale 1ns / 1ps
`include "defines.v"

module inst_rom(
    input wire ce,
    input wire [`instaddrbus] addr,//ָ���ַ
    output reg [`instbus] inst
    );
    reg [`instbus] inst_mem[0:127];
    // ��ָ����� inst_mem
    initial begin
           $readmemh("c:/file/vivado/inst_rom.data",inst_mem);  
    end
    
    always @(*)begin
        if(ce==0)begin
            inst<=`zeroword;//���ص�ָ��Ϊȫ0
        end else begin
            inst<=inst_mem[addr[31:2]];//��ʦд���鷳���͸���
             //inst<=inst_mem[addr[6:0]];
            //instmem��СΪ128*4Bֻ��Ҫ7λ��ַ�ߣ�������addr��6��0λ��Ϊ��ַ�Ϳ����ˣ�addr����ÿ��+1`b1.
            //instmem�ĵ�λ��ַ��Сλ4B�����Դ�ȡ������Ϊ32λ
        end
    end
endmodule
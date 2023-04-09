`timescale 1ns / 1ps
`include "./defines.v"

module regfile(
    input wire rst,
    input wire clk,
    
    // һ��д
    input wire[`RegAddrBus] waddr,
    input wire[`RegDataBus] wdata,
    input wire we,
    
    // ������
    // �� 1
    input wire[`RegAddrBus] raddr1,
    input wire re1,
    output reg[`RegDataBus] rdata1,
    // �� 2
    input wire[`RegAddrBus] raddr2,
    input wire re2,
    output reg[`RegDataBus] rdata2
    );
    reg[`RegDataBus] regs[`RegNum];
    // д�˿�
    always@(posedge clk) begin
        if(rst ==`RstDisable) begin // ���������Чʱ����д�˿ڲ���Ч
            if((we == `WriteEnable) && (waddr != 0)) begin // ��д�˿ڿ�����д��ַ�Ϸ���д������
                regs[waddr] <= wdata;
            end
        end 
    end
    // ���˿� 1
    always@(*) begin
         if(rst == `RstEnable) begin // ���������Чʱ����д�˿ڲ���Ч
            rdata1 <= `ZeroWord;
         end else if((re1 == `ReadEnable) && (raddr1 == 0)) begin // ������ַΪ 0�����ؿ�����
            rdata1 <= 32'h0;
         end else if((re1 == `ReadEnable) && (raddr1 == waddr) && (we == 1)) begin // ����������д�Ķ˿ڣ�ֱ�ӷ���Ҫд�������
            rdata1 <= wdata;
         end else if(re1 == `ReadEnable) begin // �����������ݣ�ֱ�ӷ��ض���ַ�����ݼ���
            rdata1 <= regs[raddr1];
         end else begin
            rdata1 <= 32'h 0;
         end
    end
    // ���˿� 2
    always@(*) begin
         if(rst == `RstEnable) begin
            rdata2 <= `ZeroWord;
         end else if((re2 == `ReadEnable) && (raddr2 == 0)) begin
            rdata2 <= 32'h0;
         end else if((re2 == `ReadEnable) && (raddr2 == waddr) && (we == 1)) begin
            rdata2 <= wdata;
         end else if(re2 == `ReadEnable) begin
            rdata2 <= regs[raddr2];
         end else begin
            rdata2 <= 32'h 0;
         end
    end
endmodule

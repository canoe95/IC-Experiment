`timescale 1ns / 1ps
`include "defines.v"

module pc(
	input rst,
	input clk,
    output reg [`instaddrbus] pc,// ��ǰָ���ַ�������洢������ȡֵ
    output reg ce,
    
    output wire [`instaddrbus] pc_o,// ��if_id��ַ
    input wire branch_flag_i, // ��Ϊ1��˵��Ϊ��תָ��
    input wire[`regbus] branch_target_address_i // ��תָ���ַ
    );
    
    assign pc_o=(rst)? 32'h00000000:pc;
    always @(posedge clk)begin
        if(rst==`rstenable)begin
            ce<=`chipdisable;
            //rstΪ�ߣ�����Ϣ��
            //ceΪ�ͣ�pc��0����ȡ����ָ��Ϊȫ��
        end else begin 
            ce<=`chipenable;
        end
    end
    
    always @(posedge clk)begin
        if(ce==`chipdisable)begin 
            pc<=32'h00000000;
        end else if (branch_flag_i==`branch)begin
            pc<=branch_target_address_i; // �������תָ���ת����תָ��Ҫ����ĵ�ַ
        end else begin
            pc<=pc+4'h4; // ���� pc ָ��˳�����ӣ�˳��ִ��
        end
    end
endmodule

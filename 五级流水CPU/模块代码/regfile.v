`timescale 1ns / 1ps
`include "defines.v"

module regfile(
	input rst,
	input clk,
    input [`regaddrbus] waddr,
    input [`regbus] wdata,
    input we,
    input [`regaddrbus] raddr1, 
    input re1,
    output reg [`regbus] rdata1,
       
    input [`regaddrbus] raddr2,
    input re2,
    output reg [`regbus] rdata2,
    ///////////////////////////��ȡָ��
        
    input wire [`regbus] mem_addr,//Ҫ���ʵ����ݴ洢���ĵ�ַ
    input wire mem_we,//�Ƿ���д������1��ʾд����
    input wire [`regbus] mem_data_o,//Ҫд�����ݴ洢��������
    output reg [`regbus] mem_data_i,//��instrom����mem�ĵ�����
    ///////////////////////////����ǰ�ƶ˿�
    input wire [`regdatabus] wdata1,
    input wire [`regaddrbus] wd1,
    input wire wreg1,
    input wire [`regdatabus] wdata2,
    input wire [`regaddrbus] wd2,
    input wire wreg2
    );

    reg[`regbus] regs[`regnum-1:0];
    // д����
    always @(posedge clk)begin
        if(rst==`rstdisable)begin
            //����д��0��ַ����������;
            if((we==`writeenable)&&(waddr !=0))begin
                regs[waddr]<=wdata;
            end
        end
    end
    //���˿�1 ������
    always @ (*)begin
        if(rst==`rstenable)begin
            rdata1<=`zeroword;
            //д��0�����
        end else if((re1==`readenable)&&(raddr1==`regnumlog2'h0))begin
            rdata1<=`zeroword;
        ///////////////// //////////////����ǰ��
        end else if((raddr1==waddr)&&(we==`writeenable)&&(re1==`readenable))begin
            rdata1<=wdata;
        end else if((raddr1==wd1)&&(wreg1==`writeenable)&&(re1==`readenable))begin
            rdata1<=wdata1;
        end else if((raddr1==wd2)&&(wreg2==`writeenable)&&(re1==`readenable))begin
            rdata1<=wdata2;
        ////////////////////////////////////////////////
        end else if(re1==`readenable)begin
            rdata1<=regs[raddr1];
        end else begin
            rdata1<=`zeroword;
        end
    end
    //���˿�2 ������
    always @ (*)begin
        if(rst==`rstenable)begin
            rdata2<=`zeroword;
        end else if((re2==`readenable)&&(raddr2==`regnumlog2'h0))begin
            rdata2<=`zeroword;
        ///////////////// //////////////����ǰ��
        end else if((raddr2==waddr)&&(we==`writeenable)&&(re2==`readenable))begin
            rdata2<=wdata;
        end else if((raddr2==wd1)&&(wreg1==`writeenable)&&(re2==`readenable))begin
            rdata2<=wdata1;
        end else if((raddr2==wd2)&&(wreg2==`writeenable)&&(re2==`readenable))begin
            rdata2<=wdata2;
        ////////////////////////////////////////////////
        end else if(re2==`readenable)begin
            rdata2<=regs[raddr2];
        end else begin
            rdata2<=`zeroword;
        end
    end
    
    ///////////////////////////////////�洢������ӵĴ�ȡ
    //�� swҪ��
    always @(posedge clk)begin
        if(rst==`rstdisable)begin
            //����д��0��ַ����������;
            if((mem_we==`writeenable)&&(mem_addr !=0))begin
                regs[mem_addr]<=mem_data_o;
            end
        end
    end
    //ȡ lw��
    always @ (*)begin
        if(rst==`rstenable)begin
            mem_data_i<=`zeroword;
        end else if(mem_we==`writedisable)begin//��д���Ƕ�
            mem_data_i<=regs[mem_addr];
        end else begin//���Ų�֪����ʲô��
            mem_data_i<=`zeroword;
        end
    end
endmodule
`timescale 1ns / 1ps
`include "defines.v"
module mem(
        input wire rst,
        input wire [`regdatabus] wdata_i,
        input wire [`regaddrbus] wd_i,
        input wire wreg_i,
        output reg[`regdatabus] wdata_o,
        output reg[`regaddrbus] wd_o,
        output reg wreg_o,
        ///////////////////////////////
        input wire [`aluop_onehotbus] aluop_i,//ָ�������
        input wire [`regbus] mem_addr_i,//��ַ��lw���м�ȡ�����浽wd_o��sw��reg2_i����mem_addr_i.
        input wire [`regbus] reg2_i,//�ô�׶δ洢ָ��Ҫ�洢�ĵ�ַ//sw��rt��ֵȡ����
        input wire [`regbus] mem_data_i,//��instrom��ȡ�ĵ�����
        
        output reg [`regbus] mem_addr_o,//Ҫ���ʵ����ݴ洢���ĵ�ַ
        output reg mem_we_o,//�Ƿ���д������1��ʾд����
        //output reg [3:0] mem_sel_o,//�ֽ�ѡ���źš����Ǹ�ɶ�Ĳ�֪��
        output reg [`regbus] mem_data_o,//Ҫд�����ݴ洢��������
        //output reg mem_ce_o //instromʹ���ź�
        ////////////����ǰ��
        output wire[`regdatabus] wb_wdata,
        output wire[`regaddrbus] wb_wd,
        output wire wb_wreg  
        );
        ////����ǰ����
        assign wb_wdata=wdata_o;
        assign wb_wd=wd_o;
        assign wb_wreg=wreg_o;
        
        
        always@(*)begin
        if (rst)begin
            wd_o=`zeroregaddr;
            wdata_o=`zeroword;
            wreg_o=`writedisable;
            
            mem_addr_o=`zeroword;//Ҫ���ʵ����ݴ洢���ĵ�ַ
            mem_we_o=`writedisable;//�Ƿ���д������1��ʾд����
            //mem_sel_o=4'b0000;//�ֽ�ѡ���ź�
            mem_data_o=`zeroword;//Ҫд�����ݴ洢��������
           // mem_ce_o=`chipdisable; //���ݴ洢��ʹ���ź�    
        end else begin
            wd_o=wd_i;
            wdata_o=wdata_i;
            wreg_o=wreg_i;
            
            mem_addr_o=`zeroword;//Ҫ���ʵ����ݴ洢���ĵ�ַ     
            mem_we_o=`writedisable;//�Ƿ���д������1��ʾд����
            //mem_sel_o=4'b1111;//�ֽ�ѡ���ź�
            mem_data_o=`zeroword;//Ҫд�����ݴ洢��������
           // mem_ce_o=`chipdisable; //���ݴ洢��ʹ���ź� 
            case(aluop_i)
                `aluoplw: begin
                    mem_addr_o=mem_addr_i;//��romҪ��ַ�������ԣ���Ϊwdata_o,���� wd_o
                    mem_we_o=`writedisable; //֮���������mem_wb�����̾ͺ��ˡ�����ֱ�Ӵ浽
                    wdata_o=mem_data_i;//���ݴ�rom������
                    //mem_sel_o=4'b1111;
                    //mem_ce_o=`chipenable;
                end
                `aluopsw: begin
                    mem_addr_o=mem_addr_i;//Ҫ��mem_data_oд��mem_addr_i
                    mem_we_o=`writeenable;
                    mem_data_o=reg2_i;//���������rt��ֵҪ����rom
                   // mem_sel_o=4'b1111;
                   // mem_ce_o=`chipenable;
                end
                default:begin
                
                end
              endcase
          end
        end
endmodule

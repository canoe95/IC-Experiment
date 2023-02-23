`timescale 1ns / 1ps
`include "defines.v"

module alu(
    input wire[31:0]alu_src1,
    input wire[31:0]alu_src2,
    input wire[`aluop_onehotbus]alu_control,
    input wire[4:0]wd_i,
    input wire wreg_i,
    output reg[31:0]alu_result,
    output wire[4:0]wd_o,
    output wire wreg_o,
    //ת��ָ��
    input wire [`regbus] link_address_i,
    input wire  is_in_delayslot_i,
    //�洢ָ��
    input wire [`regbus] inst_i,//��ǰ����ִ�н׶ε�ָ��
    output wire [`aluop_onehotbus] aluop_o,//ָ������������
    output wire [`regbus] mem_addr_o,//���ش洢ָ���Ӧ�Ĵ洢����ַ
    output wire [`regbus] reg2_o ,//�洢ָ��Ҫ�洢������
    ///////////////////////////����ǰ��
    output wire[`regdatabus] wb_wdata,
    output wire[`regaddrbus] wb_wd,
    output wire wb_wreg 
    );
    assign wd_o = wd_i;
    assign wreg_o = wreg_i;
    
    //�ô�Ҫ��
    assign aluop_o=alu_control;
    assign mem_addr_o=alu_src1+{{16{inst_i[15]}},inst_i[15:0]};//lwָ��Ĵ洢��ַ=base���ݼ���չ��32λ
    
    //��ȡһ���ֱ��浽rt                                       //swָ��ķ��ʵ�ַ=base���ݼ���չ��32λ
    assign reg2_o=alu_src2;//swָ���������rt��ֵ��Ҫ���� mem_addr_o�С�
    //////////////////       lw��  reg2_o������
    wire[`regdatabus]alu_src2_mux;
    wire[`regdatabus]result_sum;
    wire[`regdatabus]result_slt;
    
    
    
    //��Ҫ����ȡ��+1��sub subu slt��Ҫ�� ������2 ȡ����һ
    assign alu_src2_mux = ((alu_control == `aluopsub) || (alu_control == `aluopsubu) || (alu_control == `aluopslt))?
                            (~alu_src2 + 1) : alu_src2;
    
    //Ϊ��֮������࣬������ǰ����������ܿ����ò�����
    assign result_sum = alu_src1 + alu_src2_mux;
    //�Ƚ�����
    assign result_slt = (alu_src1[31] && !alu_src2[31]) ||
                        (!alu_src1[31] && !alu_src2[31] && result_sum[31]) ||
                        (alu_src1[31] && alu_src2[31] && result_sum[31]);
   // ����ָ������������
    always @(*)begin
        case(alu_control)
            `aluopadd,`aluopaddu,`aluopsub,`aluopsubu,`aluopaddiu:begin
                alu_result = result_sum;
            end
            `aluopslt:begin
                alu_result = result_slt;
            end
            `aluopsltu:begin
                alu_result = (alu_src1 < alu_src2);
            end
            `aluopand:begin
                alu_result = alu_src1 & alu_src2;
            end
            `aluopor:
                alu_result = alu_src1 | alu_src2;
            `aluopxor:
                alu_result = alu_src1^alu_src2;
            `aluopnor:
                alu_result = ~(alu_src1^alu_src2);
            `aluopsll:
                alu_result = alu_src2 << alu_src1[4:0];
            `aluopsrl:
                alu_result = alu_src2 >> alu_src1[4:0];
            `aluopsra:
                alu_result = ({32{alu_src2[31]}} << (6'd32 - {1'b0,alu_src1[4:0]})) | 
                (alu_src2 >> alu_src1[4:0]);
            `aluoplui:
                alu_result = alu_src2;
            `aluopjal:
                alu_result<=link_address_i;
            default:
                alu_result = `zeroword;
        endcase
    end
    /////////����ǰ����
    assign wb_wdata=alu_result;
    assign wb_wd=wd_o;
    assign wb_wreg=wreg_o;
endmodule


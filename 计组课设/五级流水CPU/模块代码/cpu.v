`include "defines.v"
`timescale 1ns/1ps
module cpu(
    //pc������id��������
    //id5������һ�����
    input wire rst,
    input wire clk,
    input wire[`instbus] rom_data_i,//rom���ص�ָ��
    output wire rom_ce_o,//��rom��ʹ��0����ron����ȫ��ָ��
    output wire [`instaddrbus] rom_addr_o//��rom��ָ���ַ
);
//////////////////////////////////////////////�����������ߵļ���
//pc
//output reg [`instaddrbus] pc_o,//��ifid��ַ
wire [`instaddrbus]pcifidpc;//
//    input wire branch_flag_i,
wire idpcbranch;//
//    input wire[`regbus] branch_target_address_i
wire [`regbus]idpcbranchaddr;//
//ifid
//input  wire [`instaddrbus] pc_i,//��ifid��ַ
//        output reg  [`instaddrbus] pc_o//��ifid��ַ
wire [`instaddrbus] ifididpc;//
//id
//input wire is_in_delayslot_i,//��ǰ��������׶ε�ָ���Ƿ�λ���ӳٲ�
wire idexiddelayslot;//
//    output wire next_inst_in_delayslot_o,//��һ����������׶εĵ�ָ���Ƿ�λ���ӳٲ�
wire ididexnextdelayslot;//
//    output wire branch_flag_o,   //����pc�Ƿ���ת��

//    output wire [`regbus]branch_target_address_o,//����pcת�Ƶ�ָ����ָ��������ĵ�ַ
//    output wire [`regbus]link_addr_o,//ת��ָ��Ҫ����ķ��ص�ַ
wire [`regbus]ididexlinkaddr;//
//    output wire is_in_delayslot_o,//����alu��ǰ����׶ε�ָ���Ƿ�λ���ӳٲ�
wire ididexisindelayslot;  //
//    input wire [`instaddrbus]pc_i,//pc����ָ���ַ
//    output wire [`regbus] inst_o //��ָ�����
wire [`regbus] ididexinst;//
//idex
//input wire[`regbus]id_link_address,
//        input wire id_is_in_delayslot,
//        input wire next_inst_in_delayslot_i,
//        output reg[`regbus] ex_link_address,
wire [`regbus] idexexlinkaddress;//
//        output reg  ex_is_in_delayslot,
wire  idexexdelayslot;//
//        output reg is_in_delayslot_o,   
//     ////////////////////////////////////////////
//        input wire [`regbus] id_inst,//id ����ָ��     
//        output reg [`regbus] ex_inst
wire [`regbus]idexexinst;//

//alu
//    input wire [`regbus] link_address_i,
//    input wire  is_in_delayslot_i,
//    //�洢ָ��
//    input wire [`regbus] inst_i,//��ǰ����ִ�н׶ε�ָ��
//    output wire [`aluop_onehotbus] aluop_o,//ָ������������
wire [`aluop_onehotbus] exexmemaluop;//
//    output wire [`regbus] mem_addr_o,//���ش洢ָ���Ӧ�Ĵ洢����ַ
wire [`regbus] exexmemaddr;//
//    output wire [`regbus] reg2_o ,//�洢ָ��Ҫ�洢������
wire [`regbus] exexmemreg2;//
//    ///////////////////////////����ǰ��
//        output wire[`regdatabus] wb_wdata,
wire[`regdatabus] exregdata;//
//        output wire[`regaddrbus] wb_wd,
wire[`regaddrbus] exregwaddr;//
//        output wire wb_wreg 
 wire exregwe;//
//exmem
///////////�洢ָ��
//        input wire [`aluop_onehotbus] ex_aluop, 
//        input wire [`regbus] ex_mem_addr,
//        input wire [`regbus] ex_reg2,
//        output reg [`aluop_onehotbus] mem_aluop, 
wire [`aluop_onehotbus] exmemmemaluop;//         
//        output reg [`regbus] mem_mem_addr,
wire [`regbus] exmemmemaddr;//
//        output reg [`regbus] mem_reg2 
wire [`regbus] exmemmemreg2;//
//mem
/////////////////////////////////
//        input wire [`aluop_onehotbus] aluop_i,//ָ�������
//        input wire [`regbus] mem_addr_i,//��ַ��lw���м�ȡ�����浽wd_o��sw��reg2_i����mem_addr_i.
//        input wire [`regbus] reg2_i,//�ô�׶δ洢ָ��Ҫ�洢�ĵ�ַ//sw��rt��ֵȡ����
//        input wire [`regbus] mem_data_i,//��instrom��ȡ�ĵ�����
wire [`regbus] regmemdata;          
//        output reg [`regbus] mem_addr_o,//Ҫ���ʵ����ݴ洢���ĵ�ַ
wire [`regbus] memregaddrs;
//        output reg mem_we_o,//�Ƿ���д������1��ʾд����
wire memregwes;      
//        output reg [`regbus] mem_data_o,//Ҫд�����ݴ洢��������
wire [`regdatabus] memregdatas;
//        ////////////����ǰ��
//        output wire[`regdatabus] wb_wdata,
wire[`regdatabus] memregdata;//
//        output wire[`regaddrbus] wb_wd,
wire[`regaddrbus] memregwaddr;//
//        output wire wb_wreg 
wire memregwe;//
//memwb
//regfile

//////////////////////////////////////////////////////////    
    pc pc0(rst,clk,rom_addr_o,ce,pcifidpc,idpcbranch,idpcbranchaddr);
    wire [`instbus] id_inst_i;
    if_id if_id0(clk,rst,rom_data_i,id_inst_i,pcifidpc,ifididpc);
    wire [`aluop_onehotbus] id_aluop_o;
    wire [`regdatabus] id_reg1_o;
    wire [`regdatabus] id_reg2_o;
    wire [`regaddrbus] id_wd_o;
    wire id_wreg_o;
    wire [`regdatabus] reg1_data;
    wire [`regdatabus] reg2_data;
    wire reg1_read;
    wire reg2_read;
    wire [`regaddrbus]reg1_addr;
    wire [`regaddrbus]reg2_addr;
    id id0(rst,id_inst_i,reg1_data,reg2_data,
    id_aluop_o,id_reg1_o,id_reg2_o,id_wd_o,id_wreg_o,reg1_addr,reg2_addr,
    reg1_read,reg2_read
    ,idexiddelayslot ,ididexnextdelayslot ,idpcbranch ,idpcbranchaddr ,ididexlinkaddr ,ididexisindelayslot ,ifididpc , ididexinst );
    wire [`aluop_onehotbus] ex_aluop_i;
    wire [`regdatabus] ex_reg1_i;
    wire [`regdatabus] ex_reg2_i;
    wire [`regaddrbus] ex_wd_i;
    wire ex_wreg_i;
    id_ex id_ex0(rst,clk,id_aluop_o,id_reg1_o,id_reg2_o,id_wd_o,id_wreg_o,
    ex_aluop_i,ex_reg1_i,ex_reg2_i,ex_wd_i,ex_wreg_i,
    ididexlinkaddr , ididexisindelayslot,ididexnextdelayslot ,idexexlinkaddress ,idexexdelayslot , idexiddelayslot,ididexinst , idexexinst);
    wire [`regdatabus] ex_wdata_o;
    wire [`regaddrbus] ex_wd_o;
    wire ex_wreg_o;
    alu alu0(ex_reg1_i,ex_reg2_i,ex_aluop_i,ex_wd_i,ex_wreg_i,
    ex_wdata_o,ex_wd_o,ex_wreg_o,
    idexexlinkaddress,idexexdelayslot ,idexexinst ,exexmemaluop ,exexmemaddr , exexmemreg2,exregdata ,exregwaddr , exregwe);
    wire [`regdatabus] mem_wdata_i;
    wire [`regaddrbus] mem_wd_i;
    wire mem_wreg_i;
    ex_mem ex_mem0(clk,rst,ex_wdata_o,ex_wd_o,ex_wreg_o,
    mem_wdata_i,mem_wd_i,mem_wreg_i
    ,exexmemaluop,exexmemaddr,exexmemreg2,exmemmemaluop , exmemmemaddr,exmemmemreg2 );
    wire [`regdatabus] mem_wdata_o;
    wire [`regaddrbus] mem_wd_o;
    wire mem_wreg_o;
    mem mem0(rst,mem_wdata_i,mem_wd_i,mem_wreg_i,
    mem_wdata_o,mem_wd_o,mem_wreg_o
    ,exmemmemaluop,exmemmemaddr , exmemmemreg2,regmemdata, memregaddrs ,memregwes ,memregdatas ,memregdata ,memregwaddr , memregwe);
    wire [`regdatabus] wb_wdata_i;
    wire [`regaddrbus] wb_wd_i;
    wire wb_wreg_i;
    mem_wb mem_wb0(clk,rst,mem_wdata_o,mem_wd_o,mem_wreg_o,
    wb_wdata_i,wb_wd_i,wb_wreg_i);
    
    regfile regfile0(rst,clk,wb_wd_i,wb_wdata_i,wb_wreg_i,
    reg1_addr,reg1_read,reg1_data,reg2_addr,reg2_read,reg2_data
    , memregaddrs,memregwes ,memregdatas ,regmemdata ,exregdata ,exregwaddr , exregwe,memregdata ,memregwaddr ,memregwe );
endmodule


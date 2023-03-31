`include "defines.v"
`timescale 1ns/1ps
module cpu(
    //pc有两个id来的输入
    //id5个输入一个输出
    input wire rst,
    input wire clk,
    input wire[`instbus] rom_data_i,//rom返回的指令
    output wire rom_ce_o,//给rom的使能0代表ron返回全零指令
    output wire [`instaddrbus] rom_addr_o//给rom的指令地址
);
//////////////////////////////////////////////二次增加连线的集合
//pc
//output reg [`instaddrbus] pc_o,//给ifid地址
wire [`instaddrbus]pcifidpc;//
//    input wire branch_flag_i,
wire idpcbranch;//
//    input wire[`regbus] branch_target_address_i
wire [`regbus]idpcbranchaddr;//
//ifid
//input  wire [`instaddrbus] pc_i,//给ifid地址
//        output reg  [`instaddrbus] pc_o//给ifid地址
wire [`instaddrbus] ifididpc;//
//id
//input wire is_in_delayslot_i,//当前处于译码阶段的指令是否位于延迟操
wire idexiddelayslot;//
//    output wire next_inst_in_delayslot_o,//下一条进入译码阶段的的指令是否位于延迟槽
wire ididexnextdelayslot;//
//    output wire branch_flag_o,   //告诉pc是否有转移

//    output wire [`regbus]branch_target_address_o,//告诉pc转移的指令在指令存贮器的地址
//    output wire [`regbus]link_addr_o,//转移指令要保存的返回地址
wire [`regbus]ididexlinkaddr;//
//    output wire is_in_delayslot_o,//告诉alu当前译码阶段的指令是否位于延迟槽
wire ididexisindelayslot;  //
//    input wire [`instaddrbus]pc_i,//pc来的指令地址
//    output wire [`regbus] inst_o //将指令输出
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
//        input wire [`regbus] id_inst,//id 给的指令     
//        output reg [`regbus] ex_inst
wire [`regbus]idexexinst;//

//alu
//    input wire [`regbus] link_address_i,
//    input wire  is_in_delayslot_i,
//    //存储指令
//    input wire [`regbus] inst_i,//当前处于执行阶段的指令
//    output wire [`aluop_onehotbus] aluop_o,//指令运算子类型
wire [`aluop_onehotbus] exexmemaluop;//
//    output wire [`regbus] mem_addr_o,//加载存储指令对应的存储器地址
wire [`regbus] exexmemaddr;//
//    output wire [`regbus] reg2_o ,//存储指令要存储的数据
wire [`regbus] exexmemreg2;//
//    ///////////////////////////数据前推
//        output wire[`regdatabus] wb_wdata,
wire[`regdatabus] exregdata;//
//        output wire[`regaddrbus] wb_wd,
wire[`regaddrbus] exregwaddr;//
//        output wire wb_wreg 
 wire exregwe;//
//exmem
///////////存储指令
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
//        input wire [`aluop_onehotbus] aluop_i,//指令独热码
//        input wire [`regbus] mem_addr_i,//地址，lw从中间取并保存到wd_o，sw将reg2_i存入mem_addr_i.
//        input wire [`regbus] reg2_i,//访存阶段存储指令要存储的地址//sw将rt的值取出。
//        input wire [`regbus] mem_data_i,//从instrom读取的的数据
wire [`regbus] regmemdata;          
//        output reg [`regbus] mem_addr_o,//要访问的数据存储器的地址
wire [`regbus] memregaddrs;
//        output reg mem_we_o,//是否是写操作，1表示写操作
wire memregwes;      
//        output reg [`regbus] mem_data_o,//要写入数据存储器的数据
wire [`regdatabus] memregdatas;
//        ////////////数据前推
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


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
    //转移指令
    input wire [`regbus] link_address_i,
    input wire  is_in_delayslot_i,
    //存储指令
    input wire [`regbus] inst_i,//当前处于执行阶段的指令
    output wire [`aluop_onehotbus] aluop_o,//指令运算子类型
    output wire [`regbus] mem_addr_o,//加载存储指令对应的存储器地址
    output wire [`regbus] reg2_o ,//存储指令要存储的数据
    ///////////////////////////数据前推
    output wire[`regdatabus] wb_wdata,
    output wire[`regaddrbus] wb_wd,
    output wire wb_wreg 
    );
    assign wd_o = wd_i;
    assign wreg_o = wreg_i;
    
    //访存要用
    assign aluop_o=alu_control;
    assign mem_addr_o=alu_src1+{{16{inst_i[15]}},inst_i[15:0]};//lw指令的存储地址=base内容加扩展的32位
    
    //读取一个字保存到rt                                       //sw指令的访问地址=base内容加扩展的32位
    assign reg2_o=alu_src2;//sw指令这读的是rt的值，要存入 mem_addr_o中。
    //////////////////       lw中  reg2_o无意义
    wire[`regdatabus]alu_src2_mux;
    wire[`regdatabus]result_sum;
    wire[`regdatabus]result_slt;
    
    
    
    //需要进行取反+1吗？sub subu slt需要将 操作数2 取反加一
    assign alu_src2_mux = ((alu_control == `aluopsub) || (alu_control == `aluopsubu) || (alu_control == `aluopslt))?
                            (~alu_src2 + 1) : alu_src2;
    
    //为了之后代码简洁，可以提前算出来（尽管可能用不到）
    assign result_sum = alu_src1 + alu_src2_mux;
    //比较运算
    assign result_slt = (alu_src1[31] && !alu_src2[31]) ||
                        (!alu_src1[31] && !alu_src2[31] && result_sum[31]) ||
                        (alu_src1[31] && alu_src2[31] && result_sum[31]);
   // 根据指令进行运算操作
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
    /////////数据前推用
    assign wb_wdata=alu_result;
    assign wb_wd=wd_o;
    assign wb_wreg=wreg_o;
endmodule


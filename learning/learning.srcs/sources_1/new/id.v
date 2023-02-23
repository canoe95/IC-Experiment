`timescale 1ns / 1ps
`include"./defines.v"

module id(
    input wire rst,
    input wire[`InstBus] inst_i,        // 指令  
    input wire[`RegDataBus]reg1_data_i, // 输入操作码1
    input wire[`RegDataBus]reg2_data_i, // 输入操作码2
    output wire[`Aluop_OnehotBus]aluop_o, // 指令类别，用热独码存
    output wire[`RegDataBus]reg1_o, // 就是输入的 reg1_data_i
    output wire[`RegDataBus]reg2_o, // 输入的 reg2_data_i
    output wire[`RegAddrBus]wd_o,   // 目的写寄存器地址
    output wire wreg_o,             // 写权限
    output wire[`RegAddrBus]reg1_addr_o,    // 读寄存器地址1
    output wire[`RegAddrBus]reg2_addr_o,    // 读寄存器地址2
    output wire reg1_read_o,        // 读权限1
    output wire reg2_read_o         // 读权限2
    );
    // 先用四个解码器解析 32 位指令，获取操作数、指令以及目的地址
    wire[5:0] op;
    wire[4:0] op1;
    wire[4:0] sa;
    wire[5:0] func;
    wire[63:0] op_d;
    wire[31:0] op1_d;
    wire[31:0] sa_d;
    wire[63:0] func_d;
    assign op = inst_i[31:26]; // 运算数 1
    assign op1 = inst_i[25:21]; // 运算数 2
    assign sa = inst_i[10:6];
    assign func = inst_i[5:0]; // 运算类型
    decoder_6_64 dec0(.in(op) , .out(op_d));
    decoder_5_32 dec1(.in(op1) , .out(op1_d));
    decoder_6_64 dec2(.in(sa) , .out(sa_d));
    decoder_5_32 dec3(.in(func) , .out(func_d));
    // 热独码分辨 14 种不同指令
    wire inst_add;
    wire inst_addu;
    wire inst_sub;
    wire inst_subu;
    wire inst_slt;
    wire inst_sltu;
    wire inst_and;
    wire inst_or;
    wire inst_xor;
    wire inst_nor;
    wire inst_sll;
    wire inst_srl;
    wire inst_sra;
    wire inst_lui;
    assign inst_add = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncAdd];
    assign inst_addu = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncAddu];
    assign inst_sub = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncSub];
    assign inst_subu = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncSubu];
    assign inst_slt = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncSlt];
    assign inst_sltu = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncSltu];
    assign inst_and = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncAnd];
    assign inst_or = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncOr];
    assign inst_xor = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncXor];
    assign inst_nor = op_d[`OpZero]&&sa_d[`SaZero]&&func_d[`FuncNor];
    assign inst_sll = op_d[`OpZero]&&op1_d[`Op1Zero]&&func_d[`FuncSll];
    assign inst_srl = op_d[`OpZero]&&op1_d[`Op1Zero]&&func_d[`FuncSrl];
    assign inst_sra = op_d[`OpZero]&&op1_d[`Op1Zero]&&func_d[`FuncSra];
    assign inst_lui = op_d[`OpZero]&&op1_d[`Op1Zero];
    assign aluop_o = (rst == `RstEnable) ? 14'b0 :
        {
            inst_add,
            inst_addu,
            inst_sub,
            inst_subu,
            inst_slt,
            inst_sltu,
            inst_and,
            inst_or,
            inst_xor,
            inst_nor,
            inst_sll,
            inst_srl,
            inst_sra,
            inst_lui
         };
    assign reg1_addr_o = (rst == `RstEnable) ? `ZeroRegAddr : inst_i[25:21];
    assign reg2_addr_o = (rst == `RstEnable) ? `ZeroRegAddr : inst_i[20:16];
    assign reg1_read_o = (rst == `RstEnable) ? `ReadDisable : !(inst_sll || inst_srl || inst_sra || inst_lui);
    assign reg2_read_o = (rst == `RstEnable) ? `ReadDisable : !(inst_lui);
    wire[`RegDataBus]imm;
    assign imm = rst ? `ZeroWord : 
        (inst_lui ? {inst_i[15:0],16'b0} : {27'b0,inst_i[10:6]});
    assign reg1_o = rst ? `ZeroWord :
        (reg1_read_o ? reg1_data_i : imm);
    assign reg2_o = rst ? `ZeroWord : 
        (reg2_read_o ? reg2_data_i : imm);
    assign wd_o = rst ? `ZeroRegAddr : 
        (inst_lui ? inst_i[20:16] : inst_i[15:11]);
    assign wreg_o = rst ? `WriteDisable : `WriteEnable;
endmodule
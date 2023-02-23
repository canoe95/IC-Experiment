`timescale 1ns / 1ps
`include"defines.v"

module id(
    input wire rst,
    input wire[`instbus] inst_i,//进指令
    input wire[`regdatabus]reg1_data_i,//进regfile来的数据
    input wire[`regdatabus]reg2_data_i,
    output wire[`aluop_onehotbus]aluop_o,//21位独热码，表明是哪个指令
    
    output wire[`regdatabus]reg1_o,//操作数1.2
    output wire[`regdatabus]reg2_o,
    output wire[`regaddrbus]wd_o,//要吧结果写入的地址
    output wire wreg_o,//要不要写入regfile
    output wire[`regaddrbus]reg1_addr_o,//要调用的regfile的地址
    output wire[`regaddrbus]reg2_addr_o,
    output wire reg1_read_o,//允许写
    output wire reg2_read_o,
    // 跳转指令接口
    input wire is_in_delayslot_i,//当前处于译码阶段的指令是否位于延迟操
    output wire next_inst_in_delayslot_o,//下一条进入译码阶段的的指令是否位于延迟槽
    output wire branch_flag_o,   //告诉pc是否有转移
    output wire [`regbus]branch_target_address_o,//告诉pc转移的指令在指令存贮器的地址
    output wire [`regbus]link_addr_o,//转移指令要保存的返回地址
    output wire is_in_delayslot_o,//告诉alu当前译码阶段的指令是否位于延迟槽
    // 存储指令接口
    input wire [`instaddrbus]pc_i,//pc来的指令地址
    output wire [`regbus] inst_o //将指令输出
    
     );
     assign inst_o=inst_i;
    //有3种格式的指令
    //共需要4个段的指令段的判定来确定代码是那个指令
    //进译码器
    wire[5:0] op;//头6为
    wire[4:0] op1;//之后的5位
    wire[4:0] sa;//中5位
    wire[5:0] func;//最后6位
    //出译码器
    wire[63:0] op_d;
    wire[31:0] op1_d;
    wire[31:0] sa_d;
    wire[63:0] func_d;
    
    assign op = inst_i[31:26]; // 6位
    assign op1 = inst_i[25:21]; // 5位
    assign sa = inst_i[10:6]; // 5
    assign func = inst_i[5:0]; // 6
    
    decoder_6_64 dec0(.in(op) , .out(op_d));
    decoder_5_32 dec1(.in(op1) , .out(op1_d));
    decoder_5_32 dec2(.in(sa) , .out(sa_d));
    decoder_6_64 dec3(.in(func) , .out(func_d));
   //定义14个线来组成14位独热码来为之后的部件表示这是什么指令
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
    wire inst_addiu;
    wire inst_lw;
    wire inst_sw;
    wire inst_beq;
    wire inst_bne;
    wire inst_jr;
    wire  inst_jal;
    //当译码器的输出op_d的第opzero位输出为1
    // 而且sa_d[`sazero]和func_d[`funcadd]的输出为1
    //则inst_add为1，其他的inst_x则为0，
    //要实现的指令少时可以不用编码器，直接对对inst_i的各位进行判断
    assign inst_add = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcadd];
    assign inst_addu = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcaddu];
    assign inst_sub = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcsub];
    assign inst_subu = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcsubu];
    assign inst_slt = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcslt];
    assign inst_sltu = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcsltu];
    assign inst_and = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcand];
    assign inst_or = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcor];
    assign inst_xor = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcxor];
    assign inst_nor = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcnor];
    
    assign inst_sll = op_d[`opzero]&&op1_d[`oplzero]&&func_d[`funcsll];
    assign inst_srl = op_d[`opzero]&&op1_d[`oplzero]&&func_d[`funcsrl];
    assign inst_sra = op_d[`opzero]&&op1_d[`oplzero]&&func_d[`funcsra];
    assign inst_lui = op_d[`oplui]&&op1_d[`oplzero];
    
    assign inst_addiu = op_d[`opaddiu];
    assign inst_lw = op_d[`oplw];
    assign inst_sw = op_d[`opsw];
    assign inst_beq = op_d[`opbeq];
    assign inst_bne = op_d[`opbne];
    assign inst_jr = op_d[`opzero]&&sa_d[`sazero]&&func_d[`funcjr];
    assign inst_jal = op_d[`opjal];
    //wire [13:0] aluop_o;
    //14位中只有一位为1，表示是那个指令这就是独热码
    assign aluop_o = (rst == `rstenable) ? 21'b0 :
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
            inst_lui,
            inst_addiu,
            inst_lw,
            inst_sw,
            inst_beq,
            inst_bne,
            inst_jr,
            inst_jal
         };
    
    // 从指令中读出读地址
    assign reg1_addr_o = (rst == `rstenable) ? `zeroregaddr : inst_i[25:21];
    assign reg2_addr_o = (rst == `rstenable) ? `zeroregaddr : inst_i[20:16];
    // 除 lui sll srl sra jal 外，均需要取第一个数，读使能赋值为 1
    assign reg1_read_o = (rst == `rstenable) ? `readdisable : !(inst_lui||inst_sll || inst_srl || inst_sra||inst_jal);
    // 除 lui addiu jr jal lw 指令外，均需要读第二个操作数，读使能赋为 1
    assign reg2_read_o = (rst == `rstenable) ? `readdisable : !(inst_lui||inst_addiu||inst_jr||inst_jal||inst_lw);
    
    // 立即数
    reg [`regdatabus]imm;
    // 根据指令类型从指令中取立即数
    always @(*)begin
        if(inst_lui==1'b1)begin
            imm <= {inst_i[15:0],16'b0};
        end else if(inst_addiu==1'b1)begin
            imm <= {{16{inst_i[15]}},inst_i[15:0]};
        end else begin//偏移指令要用的偏移位数
            imm<= {27'b0,inst_i[10:6]};
        end
    end
        
    wire[`regbus]pcplus8;
    wire[`regbus]pcplus4;
    wire[`regbus]imm_s112_signedext;
    assign pcplus8=pc_i+5'h8;
    assign pcplus4=pc_i+5'h4;
    assign imm_s112_signedext={{14{inst_i[15]}},inst_i[15:0],2'b00};//跳转指令用的
    //输向ex单元的操作数是刚从regfile读到的data还是立即数？根据使能信号reg1_read_o reg2_read_o判断
    //是lui指令时两个都不赋能，两个操作数都是立即数，
    //当是sll，srl，sra，的指令时操作数2赋能，是reg数据，操作数1是立即数
    
    assign reg1_o = rst ? `zeroword :
        (reg1_read_o ? reg1_data_i : imm);
    assign reg2_o = rst ? `zeroword : 
        (reg2_read_o ? reg2_data_i : imm);
        
        
   // 判断写使能，是否需要回写
    assign wd_o = rst ? `zeroregaddr : 
        ((inst_lui||inst_addiu||inst_lw) ? inst_i[20:16] : 
        (inst_jal) ?5'b11111: 
        inst_i[15:11]);      
    // 是否需要ex单元将结果写入regfile，14条指令都需要将结果写入regfile
    assign wreg_o = rst ? `writedisable :
        ((inst_jr||inst_beq||inst_bne||inst_sw)?`writedisable:`writeenable);//sw通过mem直接写入rom，不通过mem_wb写入rom，所以writedisable

    // 只有 jal 指令需要用到 link_addr_o 接口
    assign link_addr_o = rst ? `zeroword :
                        ((inst_jal)?pcplus8:`zeroword);
                        
    // 跳转地址，只有当 jr jal，或 beq 指令且两个操作数相等。或 bne 指令且两个操作数不等
    // 需要回写跳转地址
    assign branch_target_address_o = rst ? `zeroword :
                (inst_jr)?reg1_o:
                (inst_jal)?{pcplus4[31:28],inst_i[25:0],2'b00}:
                (inst_beq&&(reg1_o==reg2_o))?{pcplus4+imm_s112_signedext}:
                (inst_bne&&(reg1_o!=reg2_o))?{pcplus4+imm_s112_signedext}:
                `zeroword;
    // 跳转信号，是否需要跳转                             
    assign branch_flag_o = rst ? `notbranch :
                        ((inst_jr||inst_jal||(inst_beq&&(reg1_o==reg2_o))||(inst_bne&&(reg1_o!=reg2_o)))
                        ?`branch:`notbranch);
    assign next_inst_in_delayslot_o = rst ? `notindelayslot :
                        ((inst_jr||inst_jal||(inst_beq&&(reg1_o==reg2_o))||(inst_bne&&(reg1_o!=reg2_o)))
                        ?`indelayslot:`notindelayslot);
    assign is_in_delayslot_o = rst ? 1'b0 :is_in_delayslot_i;
endmodule


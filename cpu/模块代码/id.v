`timescale 1ns / 1ps
`include"defines.v"

module id(
    input wire rst,
    input wire[`instbus] inst_i,//��ָ��
    input wire[`regdatabus]reg1_data_i,//��regfile��������
    input wire[`regdatabus]reg2_data_i,
    output wire[`aluop_onehotbus]aluop_o,//21λ�����룬�������ĸ�ָ��
    
    output wire[`regdatabus]reg1_o,//������1.2
    output wire[`regdatabus]reg2_o,
    output wire[`regaddrbus]wd_o,//Ҫ�ɽ��д��ĵ�ַ
    output wire wreg_o,//Ҫ��Ҫд��regfile
    output wire[`regaddrbus]reg1_addr_o,//Ҫ���õ�regfile�ĵ�ַ
    output wire[`regaddrbus]reg2_addr_o,
    output wire reg1_read_o,//����д
    output wire reg2_read_o,
    // ��תָ��ӿ�
    input wire is_in_delayslot_i,//��ǰ��������׶ε�ָ���Ƿ�λ���ӳٲ�
    output wire next_inst_in_delayslot_o,//��һ����������׶εĵ�ָ���Ƿ�λ���ӳٲ�
    output wire branch_flag_o,   //����pc�Ƿ���ת��
    output wire [`regbus]branch_target_address_o,//����pcת�Ƶ�ָ����ָ��������ĵ�ַ
    output wire [`regbus]link_addr_o,//ת��ָ��Ҫ����ķ��ص�ַ
    output wire is_in_delayslot_o,//����alu��ǰ����׶ε�ָ���Ƿ�λ���ӳٲ�
    // �洢ָ��ӿ�
    input wire [`instaddrbus]pc_i,//pc����ָ���ַ
    output wire [`regbus] inst_o //��ָ�����
    
     );
     assign inst_o=inst_i;
    //��3�ָ�ʽ��ָ��
    //����Ҫ4���ε�ָ��ε��ж���ȷ���������Ǹ�ָ��
    //��������
    wire[5:0] op;//ͷ6Ϊ
    wire[4:0] op1;//֮���5λ
    wire[4:0] sa;//��5λ
    wire[5:0] func;//���6λ
    //��������
    wire[63:0] op_d;
    wire[31:0] op1_d;
    wire[31:0] sa_d;
    wire[63:0] func_d;
    
    assign op = inst_i[31:26]; // 6λ
    assign op1 = inst_i[25:21]; // 5λ
    assign sa = inst_i[10:6]; // 5
    assign func = inst_i[5:0]; // 6
    
    decoder_6_64 dec0(.in(op) , .out(op_d));
    decoder_5_32 dec1(.in(op1) , .out(op1_d));
    decoder_5_32 dec2(.in(sa) , .out(sa_d));
    decoder_6_64 dec3(.in(func) , .out(func_d));
   //����14���������14λ��������Ϊ֮��Ĳ�����ʾ����ʲôָ��
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
    //�������������op_d�ĵ�opzeroλ���Ϊ1
    // ����sa_d[`sazero]��func_d[`funcadd]�����Ϊ1
    //��inst_addΪ1��������inst_x��Ϊ0��
    //Ҫʵ�ֵ�ָ����ʱ���Բ��ñ�������ֱ�ӶԶ�inst_i�ĸ�λ�����ж�
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
    //14λ��ֻ��һλΪ1����ʾ���Ǹ�ָ������Ƕ�����
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
    
    // ��ָ���ж�������ַ
    assign reg1_addr_o = (rst == `rstenable) ? `zeroregaddr : inst_i[25:21];
    assign reg2_addr_o = (rst == `rstenable) ? `zeroregaddr : inst_i[20:16];
    // �� lui sll srl sra jal �⣬����Ҫȡ��һ��������ʹ�ܸ�ֵΪ 1
    assign reg1_read_o = (rst == `rstenable) ? `readdisable : !(inst_lui||inst_sll || inst_srl || inst_sra||inst_jal);
    // �� lui addiu jr jal lw ָ���⣬����Ҫ���ڶ�������������ʹ�ܸ�Ϊ 1
    assign reg2_read_o = (rst == `rstenable) ? `readdisable : !(inst_lui||inst_addiu||inst_jr||inst_jal||inst_lw);
    
    // ������
    reg [`regdatabus]imm;
    // ����ָ�����ʹ�ָ����ȡ������
    always @(*)begin
        if(inst_lui==1'b1)begin
            imm <= {inst_i[15:0],16'b0};
        end else if(inst_addiu==1'b1)begin
            imm <= {{16{inst_i[15]}},inst_i[15:0]};
        end else begin//ƫ��ָ��Ҫ�õ�ƫ��λ��
            imm<= {27'b0,inst_i[10:6]};
        end
    end
        
    wire[`regbus]pcplus8;
    wire[`regbus]pcplus4;
    wire[`regbus]imm_s112_signedext;
    assign pcplus8=pc_i+5'h8;
    assign pcplus4=pc_i+5'h4;
    assign imm_s112_signedext={{14{inst_i[15]}},inst_i[15:0],2'b00};//��תָ���õ�
    //����ex��Ԫ�Ĳ������Ǹմ�regfile������data����������������ʹ���ź�reg1_read_o reg2_read_o�ж�
    //��luiָ��ʱ�����������ܣ�����������������������
    //����sll��srl��sra����ָ��ʱ������2���ܣ���reg���ݣ�������1��������
    
    assign reg1_o = rst ? `zeroword :
        (reg1_read_o ? reg1_data_i : imm);
    assign reg2_o = rst ? `zeroword : 
        (reg2_read_o ? reg2_data_i : imm);
        
        
   // �ж�дʹ�ܣ��Ƿ���Ҫ��д
    assign wd_o = rst ? `zeroregaddr : 
        ((inst_lui||inst_addiu||inst_lw) ? inst_i[20:16] : 
        (inst_jal) ?5'b11111: 
        inst_i[15:11]);      
    // �Ƿ���Ҫex��Ԫ�����д��regfile��14��ָ���Ҫ�����д��regfile
    assign wreg_o = rst ? `writedisable :
        ((inst_jr||inst_beq||inst_bne||inst_sw)?`writedisable:`writeenable);//swͨ��memֱ��д��rom����ͨ��mem_wbд��rom������writedisable

    // ֻ�� jal ָ����Ҫ�õ� link_addr_o �ӿ�
    assign link_addr_o = rst ? `zeroword :
                        ((inst_jal)?pcplus8:`zeroword);
                        
    // ��ת��ַ��ֻ�е� jr jal���� beq ָ����������������ȡ��� bne ָ������������������
    // ��Ҫ��д��ת��ַ
    assign branch_target_address_o = rst ? `zeroword :
                (inst_jr)?reg1_o:
                (inst_jal)?{pcplus4[31:28],inst_i[25:0],2'b00}:
                (inst_beq&&(reg1_o==reg2_o))?{pcplus4+imm_s112_signedext}:
                (inst_bne&&(reg1_o!=reg2_o))?{pcplus4+imm_s112_signedext}:
                `zeroword;
    // ��ת�źţ��Ƿ���Ҫ��ת                             
    assign branch_flag_o = rst ? `notbranch :
                        ((inst_jr||inst_jal||(inst_beq&&(reg1_o==reg2_o))||(inst_bne&&(reg1_o!=reg2_o)))
                        ?`branch:`notbranch);
    assign next_inst_in_delayslot_o = rst ? `notindelayslot :
                        ((inst_jr||inst_jal||(inst_beq&&(reg1_o==reg2_o))||(inst_bne&&(reg1_o!=reg2_o)))
                        ?`indelayslot:`notindelayslot);
    assign is_in_delayslot_o = rst ? 1'b0 :is_in_delayslot_i;
endmodule


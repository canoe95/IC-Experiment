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
        input wire [`aluop_onehotbus] aluop_i,//指令独热码
        input wire [`regbus] mem_addr_i,//地址，lw从中间取并保存到wd_o，sw将reg2_i存入mem_addr_i.
        input wire [`regbus] reg2_i,//访存阶段存储指令要存储的地址//sw将rt的值取出。
        input wire [`regbus] mem_data_i,//从instrom读取的的数据
        
        output reg [`regbus] mem_addr_o,//要访问的数据存储器的地址
        output reg mem_we_o,//是否是写操作，1表示写操作
        //output reg [3:0] mem_sel_o,//字节选择信号、、是干啥的不知道
        output reg [`regbus] mem_data_o,//要写入数据存储器的数据
        //output reg mem_ce_o //instrom使能信号
        ////////////数据前推
        output wire[`regdatabus] wb_wdata,
        output wire[`regaddrbus] wb_wd,
        output wire wb_wreg  
        );
        ////数据前推用
        assign wb_wdata=wdata_o;
        assign wb_wd=wd_o;
        assign wb_wreg=wreg_o;
        
        
        always@(*)begin
        if (rst)begin
            wd_o=`zeroregaddr;
            wdata_o=`zeroword;
            wreg_o=`writedisable;
            
            mem_addr_o=`zeroword;//要访问的数据存储器的地址
            mem_we_o=`writedisable;//是否是写操作，1表示写操作
            //mem_sel_o=4'b0000;//字节选择信号
            mem_data_o=`zeroword;//要写入数据存储器的数据
           // mem_ce_o=`chipdisable; //数据存储器使能信号    
        end else begin
            wd_o=wd_i;
            wdata_o=wdata_i;
            wreg_o=wreg_i;
            
            mem_addr_o=`zeroword;//要访问的数据存储器的地址     
            mem_we_o=`writedisable;//是否是写操作，1表示写操作
            //mem_sel_o=4'b1111;//字节选择信号
            mem_data_o=`zeroword;//要写入数据存储器的数据
           // mem_ce_o=`chipdisable; //数据存储器使能信号 
            case(aluop_i)
                `aluoplw: begin
                    mem_addr_o=mem_addr_i;//向rom要地址的内容以，作为wdata_o,存入 wd_o
                    mem_we_o=`writedisable; //之后存数据走mem_wb的流程就好了。不用直接存到
                    wdata_o=mem_data_i;//数据从rom回来了
                    //mem_sel_o=4'b1111;
                    //mem_ce_o=`chipenable;
                end
                `aluopsw: begin
                    mem_addr_o=mem_addr_i;//要将mem_data_o写入mem_addr_i
                    mem_we_o=`writeenable;
                    mem_data_o=reg2_i;//这个是来自rt的值要存入rom
                   // mem_sel_o=4'b1111;
                   // mem_ce_o=`chipenable;
                end
                default:begin
                
                end
              endcase
          end
        end
endmodule

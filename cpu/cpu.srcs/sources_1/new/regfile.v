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
    ///////////////////////////存取指令
        
    input wire [`regbus] mem_addr,//要访问的数据存储器的地址
    input wire mem_we,//是否是写操作，1表示写操作
    input wire [`regbus] mem_data_o,//要写入数据存储器的数据
    output reg [`regbus] mem_data_i,//从instrom发往mem的的数据
    ///////////////////////////数据前推端口
    input wire [`regdatabus] wdata1,
    input wire [`regaddrbus] wd1,
    input wire wreg1,
    input wire [`regdatabus] wdata2,
    input wire [`regaddrbus] wd2,
    input wire wreg2
    );

    reg[`regbus] regs[`regnum-1:0];
    // 写操作
    always @(posedge clk)begin
        if(rst==`rstdisable)begin
            //不能写入0地址，有特殊用途
            if((we==`writeenable)&&(waddr !=0))begin
                regs[waddr]<=wdata;
            end
        end
    end
    //读端口1 读操作
    always @ (*)begin
        if(rst==`rstenable)begin
            rdata1<=`zeroword;
            //写入0的情况
        end else if((re1==`readenable)&&(raddr1==`regnumlog2'h0))begin
            rdata1<=`zeroword;
        ///////////////// //////////////数据前推
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
    //读端口2 读操作
    always @ (*)begin
        if(rst==`rstenable)begin
            rdata2<=`zeroword;
        end else if((re2==`readenable)&&(raddr2==`regnumlog2'h0))begin
            rdata2<=`zeroword;
        ///////////////// //////////////数据前推
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
    
    ///////////////////////////////////存储命令添加的存取
    //存 sw要存
    always @(posedge clk)begin
        if(rst==`rstdisable)begin
            //不能写入0地址，有特殊用途
            if((mem_we==`writeenable)&&(mem_addr !=0))begin
                regs[mem_addr]<=mem_data_o;
            end
        end
    end
    //取 lw用
    always @ (*)begin
        if(rst==`rstenable)begin
            mem_data_i<=`zeroword;
        end else if(mem_we==`writedisable)begin//不写就是读
            mem_data_i<=regs[mem_addr];
        end else begin//留着不知道有什么用
            mem_data_i<=`zeroword;
        end
    end
endmodule
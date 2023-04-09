`timescale 1ns / 1ps
`include "./defines.v"

module regfile(
    input wire rst,
    input wire clk,
    
    // 一个写
    input wire[`RegAddrBus] waddr,
    input wire[`RegDataBus] wdata,
    input wire we,
    
    // 两个读
    // 读 1
    input wire[`RegAddrBus] raddr1,
    input wire re1,
    output reg[`RegDataBus] rdata1,
    // 读 2
    input wire[`RegAddrBus] raddr2,
    input wire re2,
    output reg[`RegDataBus] rdata2
    );
    reg[`RegDataBus] regs[`RegNum];
    // 写端口
    always@(posedge clk) begin
        if(rst ==`RstDisable) begin // 当置零端无效时，读写端口才生效
            if((we == `WriteEnable) && (waddr != 0)) begin // 当写端口开启且写地址合法，写入数据
                regs[waddr] <= wdata;
            end
        end 
    end
    // 读端口 1
    always@(*) begin
         if(rst == `RstEnable) begin // 当置零端无效时，读写端口才生效
            rdata1 <= `ZeroWord;
         end else if((re1 == `ReadEnable) && (raddr1 == 0)) begin // 当读地址为 0，返回空数据
            rdata1 <= 32'h0;
         end else if((re1 == `ReadEnable) && (raddr1 == waddr) && (we == 1)) begin // 当读到正在写的端口，直接返回要写入的数据
            rdata1 <= wdata;
         end else if(re1 == `ReadEnable) begin // 当正常读数据，直接返回读地址的数据即可
            rdata1 <= regs[raddr1];
         end else begin
            rdata1 <= 32'h 0;
         end
    end
    // 读端口 2
    always@(*) begin
         if(rst == `RstEnable) begin
            rdata2 <= `ZeroWord;
         end else if((re2 == `ReadEnable) && (raddr2 == 0)) begin
            rdata2 <= 32'h0;
         end else if((re2 == `ReadEnable) && (raddr2 == waddr) && (we == 1)) begin
            rdata2 <= wdata;
         end else if(re2 == `ReadEnable) begin
            rdata2 <= regs[raddr2];
         end else begin
            rdata2 <= 32'h 0;
         end
    end
endmodule

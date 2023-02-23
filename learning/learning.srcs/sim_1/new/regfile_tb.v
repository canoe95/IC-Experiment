`timescale 1ns / 1ps

module regfile_tb(
    );
    reg rst;
    reg clk;
    
    // 一个写
    reg[`RegAddrBus] waddr;
    reg[`RegDataBus] wdata;
    reg we;
    
    // 两个读
    // 读 1
    reg[`RegAddrBus] raddr1;
    reg re1;
    wire[`RegDataBus] rdata1;
    // 读 2
    reg[`RegAddrBus] raddr2;
    reg re2;
    wire[`RegDataBus] rdata2;
    
    integer i;
    regfile regfile0(.rst(rst), .clk(clk), .waddr(waddr), .wdata(wdata), .we(we), .raddr1(raddr1), .re1(re1), .rdata1(rdata1), .raddr2(raddr2), .re2(re2), .rdata2(rdata2));
    
    initial begin
        clk = 1;
        forever begin
            #10 clk = ~clk;
        end
    end
    
    initial begin
        rst = 0;
        #10 rst = 1;
        #30 rst = 0;
        // 将数据依次写入 regs
        #30
        we = 1;
        wdata = 32'h1234;
        for(i = 0; i <= 31; i=i+1) begin
            waddr = i;
            wdata = wdata+32'h1111;
            #30;
        end
        // 关闭写
        we = 0;
        // 开启读
        re1 = 1;
        re2 = 1;
        for(i = 0; i <= 31; i = i+1) begin
            raddr1 = i; // 从前往后读
            raddr2 = 31-i; // 从后往前读
            #30;
        end
        // 开启写
        we = 1;
        wdata = 32'h5678;
        for(i = 0; i <= 31; i=i+1) begin
            waddr = i;
            raddr1 = i;
            raddr2 = i;
            #30
            wdata = wdata+32'h0101;
        end
        re1 = 0;
        re2 = 0;
        we = 0;
        #10000 $finish;
    end
endmodule

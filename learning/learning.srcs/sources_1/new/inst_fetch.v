`timescale 1ns / 1ps
`include "defines.v"

// 将 pc 模块和 inst_mem 通过内部实例化相连接。形成大的 inst_fetch 模块
module inst_fetch(
    input wire clk,
    input wire rst,
    output wire [`InstBus] inst_o
    );
    // 内部信号通过pc的输出，inst_rom的输入相连接
    wire [`InstAddrBus]pc;
    wire ce;
    pc pc0(.ce(ce), .clk(clk), .pc(pc), .rst(rst));
    inst_rom inst_rom0(.ce(ce), .addr(pc), .inst(inst_o));
endmodule

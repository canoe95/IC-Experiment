`timescale 1ns / 1ps
`include "defines.v"

// 相当于电线，直接把 pc 的输出输入到 id 中，中间由 if_id 连接
module if_id(
    input wire clk,
    input wire rst,
    input wire [`instbus] if_inst,
    output reg[`instbus] id_inst,

    input  wire [`instaddrbus] pc_i,// 给ifid地址
    output reg  [`instaddrbus] pc_o// 给ifid地址
    );
    always@(posedge clk)begin
        if(rst)begin
            id_inst=`zeroword;
            pc_o=32'h00000000;
        end else begin
            id_inst=if_inst;//只传递指令
            pc_o=pc_i;
        end
    end
endmodule

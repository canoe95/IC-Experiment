`timescale 1ns / 1ps
`include "defines.v"

module pc(
	input rst,
	input clk,
    output reg [`instaddrbus] pc,// 当前指令地址，传给存储器进行取值
    output reg ce,
    
    output wire [`instaddrbus] pc_o,// 给if_id地址
    input wire branch_flag_i, // 当为1，说明为跳转指令
    input wire[`regbus] branch_target_address_i // 跳转指令地址
    );
    
    assign pc_o=(rst)? 32'h00000000:pc;
    always @(posedge clk)begin
        if(rst==`rstenable)begin
            ce<=`chipdisable;
            //rst为高，表休息。
            //ce为低，pc置0，表取出的指令为全零
        end else begin 
            ce<=`chipenable;
        end
    end
    
    always @(posedge clk)begin
        if(ce==`chipdisable)begin 
            pc<=32'h00000000;
        end else if (branch_flag_i==`branch)begin
            pc<=branch_target_address_i; // 如果是跳转指令，跳转到跳转指令要到达的地址
        end else begin
            pc<=pc+4'h4; // 否则 pc 指针顺序增加，顺序执行
        end
    end
endmodule

// 时间精度 timescale
`timescale 1ns / 1ps

module decoder_3_8(
    input [2:0] in,
    output [7:0] out
    );
    // 定义输入输出关系
    assign out[0] = (in==3'd0);
    assign out[1] = (in==3'd1);
    assign out[2] = (in==3'd2);
    assign out[3] = (in==3'd3);
    assign out[4] = (in==3'd4);
    assign out[5] = (in==3'd5);
    assign out[6] = (in==3'd6);
    assign out[7] = (in==3'd7);
endmodule

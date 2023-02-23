`timescale 1ns / 1ps

module pc(
    input wire clk, // 时钟信号
    input wire rst, // 复位信号
    output reg [31:0] pc, // 要读的指令地址
    output reg ce // 使能信号
    );
    
    always@ (posedge clk) begin
        if(rst == 1)begin
            ce <= 0;
        end else begin
            ce <= 1;
        end
    end
    
    // 只有当复位信号无效时，使能信号有效，才给地址赋值，否则为 0
    always@(posedge clk)begin
        if(ce == 0)begin
            pc <= 32'b0;
        end else begin 
            pc <= pc + 4;
        end
    end
endmodule

`timescale 1ns / 1ps

module pc(
    input wire clk, // ʱ���ź�
    input wire rst, // ��λ�ź�
    output reg [31:0] pc, // Ҫ����ָ���ַ
    output reg ce // ʹ���ź�
    );
    
    always@ (posedge clk) begin
        if(rst == 1)begin
            ce <= 0;
        end else begin
            ce <= 1;
        end
    end
    
    // ֻ�е���λ�ź���Чʱ��ʹ���ź���Ч���Ÿ���ַ��ֵ������Ϊ 0
    always@(posedge clk)begin
        if(ce == 0)begin
            pc <= 32'b0;
        end else begin 
            pc <= pc + 4;
        end
    end
endmodule

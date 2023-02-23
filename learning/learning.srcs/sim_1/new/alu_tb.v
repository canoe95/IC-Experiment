`timescale 1ns / 1ps

module alu_tb(
    );
    reg [31:0]alu_src1;
    reg [31:0]alu_src2;
    reg [13:0]alu_control;
    reg [4:0]wd_i;
    reg wreg_i;
    wire [31:0]alu_result;
    wire [4:0]wd_o;
    wire wreg_o;
    alu alu0(alu_src1,alu_src2,alu_control,wd_i,wreg_i,alu_result,wd_o,wreg_o);
    integer i;
    integer j;
    initial begin
        alu_control = 14'b00_0000_0000_0001;
        alu_src1 = 32'h0101_0101;
        alu_src2 = 32'h1010_1010;
        wreg_i = 1;
        wd_i = 5'd10;
        for(i = 0 ; i < 14 ; i = i + 1)begin
            $monitor("alu_control = %b,alu_src1 = %h,alu_src2 = %h,alu_result = %h",
            alu_control,alu_src1,alu_src2,alu_result);
            #20;
            alu_control = alu_control << 1;
        end
        $finish;
    end
endmodule
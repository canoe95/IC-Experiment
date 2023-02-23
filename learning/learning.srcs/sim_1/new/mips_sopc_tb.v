`timescale 1ns / 1ps

module mips_sopc_tb(
    );
    reg clk;
    reg rst;
    mips_sopc mips_sopc0(clk,rst);
    initial begin
        rst = 1;
        #100;
        rst = 0;
        #1000 $finish;
    end
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end
    
endmodule
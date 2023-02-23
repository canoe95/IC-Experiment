`timescale 1ns / 1ps

module pc_tb(
    );
    wire [31:0] pc;
    wire ce;
    reg clk;
    reg rst;
    pc pc0(.ce(ce), .clk(clk), .pc(pc), .rst(rst));
    
    initial begin
        clk = 1;
        forever begin
            #10 clk = ~clk;
        end
    end
    
    initial begin
        rst = 0;
        #20 rst = 1;
        #100 rst = 0;
        #200 $finish;
    end
endmodule

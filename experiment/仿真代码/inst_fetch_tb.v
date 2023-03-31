`timescale 1ns / 1ps

module inst_fetch_tb(
    );
    reg rst;
    reg clk;
    wire [`InstBus] inst_o;
    inst_fetch inst_fetch0(.rst(rst),.clk(clk),.inst_o(inst_o));
    
    initial begin
        clk = 1;
        forever  #10 clk = ~clk;
    end
    
    initial begin
        rst = 0;
        #10 rst = 1;
        #100 rst = 0;
        #500 $finish;
    end
endmodule

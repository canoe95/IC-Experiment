`timescale 1ns / 1ps

module dffEn_tb(
    );
    wire q;
    reg d;
    reg clk;
    reg en;
    dffEn dff4(.q(q), .d(d), .clk(clk), .en(en));
    
    initial begin
        clk = 0;
        forever begin
            #10 clk = ~clk;
        end
    end
    
    initial begin
        d = 1;
        forever begin
            #15 d = ~d;
        end
    end
    
    initial begin
        en = 0;
        forever begin
            #25 en = ~en;
        end
    end
    
    initial begin
        #200 $finish;
    end
endmodule

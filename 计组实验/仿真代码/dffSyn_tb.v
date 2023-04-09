`timescale 1ns / 1ps

module dffSyn_tb(
    );
    reg d;
    reg clk;
    reg reset;
    wire q;
    dffSyn dff2(.d(d), .clk(clk), .reset(reset), .q(q));
    
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
        reset = 1;
        #5 reset = 0;
        #25 reset = 1;
    end
    
    initial begin
        #200 $finish;
    end
endmodule

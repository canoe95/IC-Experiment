`timescale 1ns / 1ps

module dff_tb(
    );
    reg d;
    reg clk;
    wire q;
    dff dff1(.d(d), .clk(clk), .q(q));
    initial begin
        clk = 0;
        forever begin
            #10 clk = ~clk;
        end
    end
    initial begin
        d = 0;
        forever begin
            #15 d = ~d;
        end
    end
    initial begin
        #200 $finish;
    end
endmodule

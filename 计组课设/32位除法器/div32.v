`timescale 1ns / 1ps

module div32(
    input [31:0] a,
    input [31:0] b,
    output [31:0] result,
    output [31:0] remainder
    ); 
    reg[63:0] temp_a;
    reg[63:0] temp_b;
        
    integer i;
    always @ (*) begin
        temp_a = {32'd0, a};
        temp_b = {b, 32'd0};
        for(i = 0; i < 32; i = i+1) begin
            temp_a = temp_a << 1;
            if(temp_a >= temp_b) begin
                temp_a = temp_a - temp_b + 1;
            end
        end
    end
    assign result = temp_a[31:0];
    assign remainder = temp_a[63:32];
endmodule
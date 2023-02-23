`timescale 1ns / 1ps

module id_tb(
    );
    reg rst;
    reg[`InstBus]inst_i;
    reg[`RegDataBus]reg1_data_i;
    reg[`RegDataBus]reg2_data_i;
    wire[`Aluop_OnehotBus]aluop_o;
    wire[`RegDataBus]reg1_o;
    wire[`RegDataBus]reg2_o;
    wire[`RegAddrBus]wd_o;
    wire wreg_o;
    wire[`RegAddrBus]reg1_addr_o;
    wire[`RegAddrBus]reg2_addr_o;
    wire reg1_read_o;
    wire reg2_read_o;
    id id0(rst,inst_i,reg1_data_i,reg2_data_i,aluop_o,reg1_o,reg2_o,wd_o,wreg_o,reg1_addr_o,reg2_addr_o,reg1_read_o,reg2_read_o);
    reg[`InstBus]inst_mem[0:127];
    initial begin
        $readmemh("C:/File/vivado/inst_rom.data" , inst_mem);
    end
    integer i;
    initial begin
        rst = `RstEnable;
        #50;
        rst = `RstDisable;
        reg1_data_i = 32'h12345678;
        reg2_data_i = 32'h87654321;
        for(i = 0 ; i <= 20 ; i = i+1)begin
            inst_i = inst_mem[i];
            #20;
        end
        #50 $finish;
    end
endmodule
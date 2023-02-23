`timescale 1ns / 1ps
`include "./defines.v"

module singlecycle_cpu(
    input wire rst,
    input wire clk,
    input wire[`InstBus] inst_i,
    output wire rom_ce_o,
    output wire[`InstAddrBus]rom_addr_o
    );
    pc pc0(.rst(rst), .clk(clk), .pc(rom_addr_o), .ce(rom_ce_o));
    
    wire[`RegDataBus]reg1_data;
    wire[`RegDataBus]reg2_data;
    wire[`Aluop_OnehotBus]id_aluop_o;
    wire[`RegDataBus]id_reg1_o;
    wire[`RegDataBus]id_reg2_o;
    wire[`RegAddrBus]id_wd_o;
    wire id_wreg_o;
    wire[`RegAddrBus]reg1_addr;
    wire[`RegAddrBus]reg2_addr;
    wire reg1_read;
    wire reg2_read;
    id id0(rst,inst_i,reg1_data,reg2_data,id_aluop_o,id_reg1_o,id_reg2_o,
            id_wd_o,id_wreg_o,reg1_addr,reg2_addr,reg1_read,reg2_read);
    
    wire[`RegAddrBus]ex_wd;
    wire[`RegDataBus]ex_wdata_o;
    wire ex_wreg;
    regfile regfile0(rst, clk, ex_wd, ex_wdata_o, ex_wreg, reg1_addr, reg1_read, reg1_data,
                     reg2_addr, reg2_read, reg2_data);
    alu alu0(id_reg1_o, id_reg2_o, id_aluop_o, id_wd_o, id_wreg_o, ex_wdata_o, ex_wd, ex_wreg);
    
endmodule
`timescale 1ns / 1ps
`include "defines.v"
module id_ex(
        input wire rst,
        input wire clk,
        input wire [`aluop_onehotbus] id_aluop,
        input wire [`regdatabus] id_reg1,
        input wire [`regdatabus] id_reg2,
        input wire [`regaddrbus] id_wd,
        input wire id_wreg,
        output reg [`aluop_onehotbus] ex_aluop,
        output reg [`regdatabus] ex_reg1,
        output reg [`regdatabus] ex_reg2,
        output reg [`regaddrbus] ex_wd,
        output reg ex_wreg,
        //////////////////////////////////////////////
        input wire[`regbus]id_link_address,
        input wire id_is_in_delayslot,
        input wire next_inst_in_delayslot_i,
        output reg[`regbus] ex_link_address,
        output reg  ex_is_in_delayslot,
        output reg is_in_delayslot_o,
        ////////////////////////////////////////////
        input wire [`regbus] id_inst,//id ¸øµÄÖ¸Áî     
        output reg [`regbus] ex_inst
        );
        always@(posedge clk)begin
            if(rst)begin
            ex_aluop=`aluopzero;
            ex_reg1=`zeroword;
            ex_reg2=`zeroword;
            ex_wd=`zeroregaddr;
            ex_wreg=`writedisable;
          
            ex_link_address=`zeroword;
            ex_is_in_delayslot=`notindelayslot;
            is_in_delayslot_o=`notindelayslot;  
            
            ex_inst=`zeroword;
            
            end else begin
            
            ex_aluop=id_aluop;
            ex_reg1=id_reg1;
            ex_reg2=id_reg2;
            ex_wd=id_wd;
            ex_wreg=id_wreg;
            
            ex_link_address=id_link_address;
            ex_is_in_delayslot=id_is_in_delayslot;
            is_in_delayslot_o=next_inst_in_delayslot_i; 
            
            ex_inst=id_inst;
             
            end
        end 
endmodule


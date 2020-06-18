`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/07 14:44:19
// Design Name: 
// Module Name: Mips
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mycpu_top(
    input clk,resetn,int,
    input [31:0]inst_sram_rdata ,data_sram_rdata,
    output inst_sram_en , data_sram_en,
    output [3:0]inst_sram_wen , data_sram_wen,
    output [31:0] inst_sram_addr ,inst_sram_wdata , data_sram_addr ,data_sram_wdata,
    output [31:0] debug_wb_pc ,debug_wb_rf_wdata,
    output [3: 0]debug_wb_rf_wen,
    output [4:0] debug_wb_rf_wnum
    );
    wire rst = ~resetn;

    datapath datapath1(clk , rst , int ,
    inst_sram_rdata ,
    inst_sram_en , inst_sram_wen ,
    inst_sram_addr , inst_sram_wdata ,
    debug_wb_pc , debug_wb_rf_wen ,
    debug_wb_rf_wnum , debug_wb_rf_wdata);
endmodule

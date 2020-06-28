`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 19:36:00
// Design Name: 
// Module Name: datapath
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

//1入2出
module datapath(
    input clk,reset,int,
    input [31:0]inst_sram_rdata,
    output  inst_sram_en,
    output [3:0]inst_sram_wen,
    output [31:0] inst_sram_addr ,inst_sram_wdata,
    output data_sram_en,
    output [3:0]data_sram_wen,
    output [31:0]data_sram_addr,data_sram_wdata,
    input  [31:0] data_sram_rdata,
    output [31:0] debug_wb_pc,
    output [3:0] debug_wb_rf_wen,
    output [4:0] debug_wb_rf_wnum,
    output [31:0]debug_wb_rf_wdata
    );
    wire [31:0]pc_if,pc_4,pc_4_if;
    wire PcWrite,pc_src,pc_flush,if_id_write;//1清零
    wire [31:0]pc_id,pc_4_id,instruction_id,pc_4_id2;
    wire [31:0]pc_4_exe;
    wire [31:0]wd;
    wire [31:0]pc_exe,pc_mem;
    wire [1:0]MemWrite,MemWrite_exe,MemWrite_exe2,MemWrite_mem,MemWrite_mem2,MemWrite_wb;
    wire [2:0]MemRead,MemRead_exe,MemRead_exe2,MemRead_mem,MemRead_mem2,MemRead_wb;
    wire RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    RegWrite;
    wire [1:0]jump;
    wire RegDst_exe,
    Branch_exe,
    MemtoReg_exe,
    Alusrc1_exe,
    Alusrc2_exe,
    RegWrite_exe,
    Branch_exe2,
    MemtoReg_exe2,
    RegWrite_exe2,
    Branch_mem,
    MemtoReg_mem,
    RegWrite_mem,
    MemtoReg_mem2,
    RegWrite_mem2,
    MemtoReg_wb,
    RegWrite_wb,
    RegWrite_wb2,
    mtc0,mfc0,mtc0_exe,mfc0_exe,mtc0_exe2,mfc0_exe2,mfc0_mem,mfc0_wb;
    wire [4:0]Aluctr,Aluctr_exe;
    wire [4:0]rs,rt,rd,rt_exe,rd_exe,rd_exe2,rd_mem,rd_mem2,rd_wb,rd_wb2;
    wire [31:0]immi1,immi2,immi1_exe,immi2_exe;
    wire [31:0]busA,busB,busA_exe,busB_exe,busB_exe2,busB_mem,busB_mem2,busB_wb;
    wire [31:0]Aluout,Aluout_mem,Aluout_mem2,Aluout_wb;
    wire zero,zero_mem;
    wire br;
    wire [31:0]instruction;
    wire [31:0]Rdata,Rdata_wb;
    wire [31:0] address,error_address;
    wire overflow,keep;
    wire if_flush,id_flush,exe_flush;
    wire [31:0]mem_data;
    wire id_lw,if_lw,id_lw_exe;
    wire [31:0]rdata_mem,rdata_mem2,address_exe;
    wire [31:0]badAddr,count,status,cause,epc,except_data,except_data_mem,except_data_wb;
    wire [31:0]badAddr_out,count_out,status_out,cause_out,epc_out;
    wire [31:0]alu_forward;
    assign inst_sram_wen=4'b0;
    assign data_sram_en=1;
    assign pc_4=pc_4_if;
    assign inst_sram_wdata=32'b0;
    If if1(clk,reset,address,error_address,pc_4,PcWrite,pc_src,pc_flush,if_lw,keep|overflow,pc_4_if,pc_if);
    assign  inst_sram_addr=(reset)?0:pc_if & 32'h1fffffff;
    assign inst_sram_en=(reset)?0:1;
    if_id if_id1(clk,reset,if_flush,if_lw,if_id_write,pc_if,pc_4_if,pc_id,pc_4_id);
    assign instruction=(reset)?0:inst_sram_rdata;
    assign instruction_id=(id_lw_exe)?instruction_id:instruction;
    id id1(clk,reset,ctrl,id_lw,id_lw_exe,pc_id,pc_4_id,instruction_id,
    alu_forward,Aluout_mem,rdata_mem,wd,
    rd_exe2,rd_mem2,rd_wb2,
    RegWrite_exe,
    RegWrite_mem,
    RegWrite_wb,
    MemRead_mem,
    RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    RegWrite,
    jump,
    keep,
    MemWrite,
    MemRead,
    Aluctr,
    rs,rt,rd,immi1,immi2,busA,busB,pc_4_id2,mtc0,mfc0
    );
    hazardDetect  hazardDetect1(clk,reset,rs,rt,rt_exe,
    MemRead_exe,Branch,jump,
    instruction_id,immi2,pc_id,busA,busB,
    PcWrite,if_id_write,pc_flush,pc_src,ctrl,id_lw,if_lw,
    address
    );
    id_exe id_exe1(clk,reset,ctrl,id_flush,id_lw,
    RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    MemWrite,
    MemRead,
    RegWrite,
    Aluctr,
    rt,rd,immi1,immi2,busA,busB,pc_4_id2,pc_id,
    mtc0,mfc0,
    RegDst_exe,
    Branch_exe,
    MemtoReg_exe,
    Alusrc1_exe,
    Alusrc2_exe,
    id_lw_exe,
    MemWrite_exe,
    MemRead_exe,
    RegWrite_exe,
    Aluctr_exe,
    rt_exe,rd_exe,pc_4_exe,pc_exe,busA_exe,busB_exe,immi1_exe,immi2_exe,mtc0_exe,mfc0_exe
    );
    exe exe1(clk,reset,exe_flush,RegDst_exe,
    Branch_exe,
    MemtoReg_exe,
    Alusrc1_exe,
    Alusrc2_exe,
    MemWrite_exe,
    MemRead_exe,
    RegWrite_exe,
    Aluctr_exe,
    rt_exe,rd_exe,pc_4_exe,busA_exe,busB_exe,immi1_exe,immi2_exe,mtc0_exe,mfc0_exe,
    Branch_exe2,
    MemtoReg_exe2,
    MemWrite_exe2,
    MemRead_exe2,
    RegWrite_exe2,
    Aluout,busB_exe2,zero,overflow,rd_exe2,mtc0_exe2,mfc0_exe2);
    judge judge1(MemWrite_exe2,
    Aluout,busB_exe2,
    rd_exe,mtc0_exe2,mfc0_exe2,
    badAddr_out,count_out,status_out,cause_out,epc_out,
    data_sram_wen,data_sram_wdata,data_sram_addr,badAddr,count,status,cause,epc,except_data,alu_forward
    );
    exe_mem exe_mem1(clk,reset,exe_flush,
    Branch_exe2,
    MemtoReg_exe2,
    MemWrite_exe2,
    MemRead_exe2,
    RegWrite_exe2,
    Aluout,busB_exe2,pc_exe,zero,rd_exe2,mfc0_exe2,except_data,
    Branch_mem,
    MemtoReg_mem,
    MemWrite_mem,
    MemRead_mem,
    RegWrite_mem,
    Aluout_mem,busB_mem,pc_mem,zero_mem,rd_mem,mfc0_mem,except_data_mem
    );
    mem mem1(clk,reset,
    Branch_mem,
    MemtoReg_mem,
    RegWrite_mem,
    MemRead_mem,
    Aluout_mem,data_sram_rdata,zero_mem,rd_mem,
    br,
    MemtoReg_mem2,
    RegWrite_mem2,
    Aluout_mem2,rdata_mem,rd_mem2
    );
    mem_wb mem_wb1(clk,reset,
    MemtoReg_mem2,
    RegWrite_mem2,
    Aluout_mem2,pc_mem,rdata_mem,rd_mem2,mfc0_mem,except_data_mem,
    MemtoReg_wb,
    RegWrite_wb,
    Aluout_wb,debug_wb_pc,rdata_mem2,rd_wb,mfc0_wb,except_data_wb
    );
    wb wb1(clk,reset,
    MemtoReg_wb,
    RegWrite_wb,
    Aluout_wb,rdata_mem2,rd_wb,mfc0_wb,except_data_wb,
    RegWrite_wb2,
    wd,rd_wb2
    );
    assign debug_wb_rf_wen={4{RegWrite_wb2}};
    assign debug_wb_rf_wnum=rd_wb2;
    assign debug_wb_rf_wdata=wd;
    CP0 cp01(clk,reset,overflow,keep,mtc0_exe2,
    pc_id,pc_exe,
    badAddr,count,status,epc,cause,
    badAddr_out,count_out,status_out,cause_out,error_address,epc_out,
    if_flush,id_flush,exe_flush);
endmodule
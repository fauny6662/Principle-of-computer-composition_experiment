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
    output [31:0] debug_wb_pc,
    output [3:0] debug_wb_rf_wen,
    output [4:0] debug_wb_rf_wnum,debug_wb_rf_wdata
    );
    wire [31:0]npc,pc_if,pc_4,pc_4_if,instruction_if;
    wire PcWrite,pc_src,pc_flush,if_idWrite;//1清零
    wire [31:0]pc_id,pc_4_id,instruction_id,pc_4_id2;
    wire [31:0]pc_4_exe,pc_br,pc_br_mem;
    wire [31:0]wd;
    wire RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    MemWrite,
    MemRead,
    RegWrite,
    jump,
    RegDst_exe,
    Branch_exe,
    MemtoReg_exe,
    Alusrc1_exe,
    Alusrc2_exe,
    MemWrite_exe,
    MemRead_exe,
    RegWrite_exe,
    Branch_exe2,
    MemtoReg_exe2,
    MemWrite_exe2,
    MemRead_exe2,
    RegWrite_exe2,
    Branch_mem,
    MemtoReg_mem,
    MemWrite_mem,
    MemRead_mem,
    RegWrite_mem,
    MemtoReg_mem2,
    RegWrite_mem2,
    MemtoReg_wb,
    RegWrite_wb,
    RegWrite_wb2;
    wire [4:0]Aluctr,Aluctr_exe;
    wire [4:0]rs,rt,rd,rt_exe,rd_exe,rd_exe2,rd_mem,rd_mem2,rd_wb,rd_wb2;
    wire [31:0]immi1,immi2,immi1_exe,immi2_exe;
    wire [31:0]busA,busB,busA_exe,busB_exe,busB_exe2,busB_mem;
    wire [31:0]Aluout,Aluout_mem,Aluout_mem2,Aluout_wb;
    wire zero,zero_mem;
    wire br;
    
    wire [31:0]Rdata,Rdata_wb;
    wire [31:0] address;
    // wire [1:0]hd_rs,hd_rt;
    assign inst_sram_wen=4'b0;
    
    assign pc_4=pc_4_if;
    If if1(clk,reset,address,pc_4,PcWrite,pc_src,pc_flush,pc_4_if,pc_if,instruction_if);
    if_id if_id1(clk,reset,if_idWrite,pc_if,pc_4_if,instruction_if,pc_id,instruction_id,pc_4_id);
    // forward_id forward_id1(rs,rt,rd_exe,rd_mem,
    // RegWrite_exe,
    // RegWrite_mem,
    // MemRead_mem,
    // hd_rs,hd_rt);
    id id1(clk,reset,pc_id,pc_4_id,instruction_id,
    Aluout,Aluout_mem,Rdata,wd,
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
    MemWrite,
    MemRead,
    RegWrite,
    jump,
    Aluctr,
    rs,rt,rd,immi1,immi2,busA,busB,pc_4_id2);
    hazardDetect  hazardDetect1(clk,reset,rs,rt,rt_exe,
    MemRead_exe,Branch,jump,
    instruction_id,immi2,pc_id,busA,busB,
    PcWrite,if_idWrite,pc_flush,pc_src,
    address
    );
    id_exe id_exe1(clk,reset,RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    MemWrite,
    MemRead,
    RegWrite,
    Aluctr,
    rt,rd,immi1,immi2,busA,busB,pc_4_id2,
    RegDst_exe,
    Branch_exe,
    MemtoReg_exe,
    Alusrc1_exe,
    Alusrc2_exe,
    MemWrite_exe,
    MemRead_exe,
    RegWrite_exe,
    Aluctr_exe,
    rt_exe,rd_exe,pc_4_exe,busA_exe,busB_exe,immi1_exe,immi2_exe
    );
    exe exe1(clk,reset,RegDst_exe,
    Branch_exe,
    MemtoReg_exe,
    Alusrc1_exe,
    Alusrc2_exe,
    MemWrite_exe,
    MemRead_exe,
    RegWrite_exe,
    Aluctr_exe,
    rt_exe,rd_exe,pc_4_exe,busA_exe,busB_exe,immi1_exe,immi2_exe,
    Branch_exe2,
    MemtoReg_exe2,
    MemWrite_exe2,
    MemRead_exe2,
    RegWrite_exe2,
    Aluout,busB_exe2,zero,rd_exe2);
    exe_mem exe_mem1(clk,reset,
    Branch_exe2,
    MemtoReg_exe2,
    MemWrite_exe2,
    MemRead_exe2,
    RegWrite_exe2,
    pc_br,Aluout,busB_exe2,zero,rd_exe2,
    Branch_mem,
    MemtoReg_mem,
    MemWrite_mem,
    MemRead_mem,
    RegWrite_mem,
    pc_br_mem,Aluout_mem,busB_mem,zero_mem,rd_mem
    );
    mem mem1(clk,reset,
    Branch_mem,
    MemtoReg_mem,
    MemWrite_mem,
    MemRead_mem,
    RegWrite_mem,
    Aluout_mem,busB_mem,zero_mem,rd_mem,
    br,
    MemtoReg_mem2,
    RegWrite_mem2,
    Rdata,Aluout_mem2,rd_mem2
    );
    mem_wb mem_wb1(clk,reset,
    MemtoReg_mem2,
    RegWrite_mem2,
    Rdata,Aluout_mem2,rd_mem2,
    MemtoReg_wb,
    RegWrite_wb,
    Rdata_wb,Aluout_wb,rd_wb
    );
    wb wb1(clk,reset,
    MemtoReg_wb,
    RegWrite_wb,
    Rdata_wb,Aluout_wb,rd_wb,
    RegWrite_wb2,
    wd,rd_wb2
    );
    // initial
    //     begin
    //         br=0;
    //     end
endmodule

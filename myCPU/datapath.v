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
    wire PcWrite,pc_src,pc_flush,if_idWrite;//1清零
    wire [31:0]pc_id,pc_4_id,instruction_id,pc_4_id2;
    wire [31:0]pc_4_exe;
    wire [31:0]wd;
    wire [31:0]pc_exe,pc_mem;
    wire [1:0]MemWrite,MemWrite_exe,MemWrite_exe2,MemWrite_mem,MemRead,MemRead_exe,MemRead_exe2,MemRead_mem;
    wire RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    RegWrite,
    jump,
    RegDst_exe,
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
    RegWrite_wb2;
    wire [4:0]Aluctr,Aluctr_exe;
    wire [4:0]rs,rt,rd,rt_exe,rd_exe,rd_exe2,rd_mem,rd_mem2,rd_wb,rd_wb2;
    wire [31:0]immi1,immi2,immi1_exe,immi2_exe;
    wire [31:0]busA,busB,busA_exe,busB_exe,busB_exe2,busB_mem;
    wire [31:0]Aluout,Aluout_mem,Aluout_mem2,Aluout_wb;
    wire zero,zero_mem;
    wire br;
    wire [31:0]instruction;
    wire [31:0]Rdata,Rdata_wb;
    wire [31:0] address,error_address;
    wire jal_en;
    wire [31:0]jal_wdata;
    wire overflow,keep;
    wire if_flush,id_flush,exe_flush;
    // wire [1:0]hd_rs,hd_rt;
    assign inst_sram_wen=4'b0;
    assign data_sram_en=1;
    assign pc_4=pc_4_if;
    assign inst_sram_wdata=32'b0;
    // assign inst_sram_addr[2:0]=3'b0;
    If if1(clk,reset,address,error_address,pc_4,PcWrite,pc_src,pc_flush,keep&overflow,pc_4_if,pc_if);
    assign  inst_sram_addr=(reset)?0:pc_if;
    assign inst_sram_en=(reset)?0:1;
    if_id if_id1(clk,reset,if_flush,if_idWrite,pc_if,pc_4_if,pc_id,pc_4_id);
    // forward_id forward_id1(rs,rt,rd_exe,rd_mem,
    // RegWrite_exe,
    // RegWrite_mem,
    // MemRead_mem,
    // hd_rs,hd_rt);
    assign instruction_id=(reset)?0:inst_sram_rdata;
    // assign instruction_id=(reset)?0:instruction;
    id id1(clk,reset,ctrl,jal_en,pc_id,pc_4_id,instruction_id,jal_wdata,
    Aluout,Aluout_mem,mem_data,wd,
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
    rs,rt,rd,immi1,immi2,busA,busB,pc_4_id2);
    // assign Branch=(ctrl)?0:1;
    // assign jump=(ctrl)?0:1;
    hazardDetect  hazardDetect1(clk,reset,rs,rt,rt_exe,
    MemRead_exe,Branch,jump,
    instruction_id,immi2,pc_id,busA,busB,
    PcWrite,if_idWrite,pc_flush,pc_src,ctrl,jal_en,
    address,jal_wdata
    );
    id_exe id_exe1(clk,reset,ctrl,id_flush,
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
    RegDst_exe,
    Branch_exe,
    MemtoReg_exe,
    Alusrc1_exe,
    Alusrc2_exe,
    MemWrite_exe,
    MemRead_exe,
    RegWrite_exe,
    Aluctr_exe,
    rt_exe,rd_exe,pc_4_exe,pc_exe,busA_exe,busB_exe,immi1_exe,immi2_exe
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
    rt_exe,rd_exe,pc_4_exe,busA_exe,busB_exe,immi1_exe,immi2_exe,
    Branch_exe2,
    MemtoReg_exe2,
    MemWrite_exe2,
    MemRead_exe2,
    RegWrite_exe2,
    Aluout,busB_exe2,zero,overflow,rd_exe2);
    exe_mem exe_mem1(clk,reset,exe_flush,
    Branch_exe2,
    MemtoReg_exe2,
    MemWrite_exe2,
    MemRead_exe2,
    RegWrite_exe2,
    Aluout,busB_exe2,pc_exe,address,zero,rd_exe2,
    Branch_mem,
    MemtoReg_mem,
    MemWrite_mem,
    MemRead_mem,
    RegWrite_mem,
    Aluout_mem,busB_mem,pc_mem,zero_mem,rd_mem
    );
    assign data_sram_addr=Aluout_mem;
    //rst_DM rst1(Aluout_mem,busB_mem,data_sram_rdata,MemRead_mem,MemWrite_mem,data_sram_wen,data_sram_wdata,mem_data);
    //assign data_sram_wdata=busB_mem;
    //assign data_sram_wen={4{MemWrite_mem}};
    mem mem1(clk,reset,
    Branch_mem,
    MemtoReg_mem,
    MemWrite_mem,
    MemRead_mem,
    RegWrite_mem,
    Aluout_mem,busB_mem,data_sram_rdata,zero_mem,rd_mem,
    data_sram_wen,data_sram_wdata,mem_data,
    br,
    MemtoReg_mem2,
    RegWrite_mem2,
    Aluout_mem2,rd_mem2
    );
    mem_wb mem_wb1(clk,reset,
    MemtoReg_mem2,
    RegWrite_mem2,
    Aluout_mem2,pc_mem,rd_mem2,
    MemtoReg_wb,
    RegWrite_wb,
    Aluout_wb,debug_wb_pc,rd_wb
    );
    wb wb1(clk,reset,
    MemtoReg_wb,
    RegWrite_wb,
    data_sram_rdata,Aluout_wb,rd_wb,
    RegWrite_wb2,
    wd,rd_wb2
    );
    assign debug_wb_rf_wen={4{RegWrite_wb2}};
    assign debug_wb_rf_wnum=rd_wb2;
    assign debug_wb_rf_wdata=wd;
    CP0 cp01(clk,reset,overflow,keep,pc_id,pc_exe,status,error_address,if_flush,id_exe,exe_flush);
    // initial
    //     begin
    //         br=0;
    //     end
endmodule

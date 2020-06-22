`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 21:23:02
// Design Name: 
// Module Name: id
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


module id(
    input clk,reset,ctrl,jal_en,
    input [31:0]pc,pc_4,instruction,jal_wdata,
    input [31:0]Aluout_exe,Aluout_mem,Rdata_mem,data_wb,
    input [4:0]rd_exe,rd_mem,rd_wb,
    input  
    RegWrite_exe,
    RegWrite_mem,
    RegWrite_wb,
    input [1:0] MemRead_mem,
    output  RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    RegWrite,
    Jump,
    keep,
    output [1:0]MemWrite,MemRead,
    output [4:0]Aluctr,
    output [4:0]rs,rt,rd,
    output [31:0]immi_1, immi_2,
    output reg [31:0]out1,out2,
    output [31:0]pc_4_out
    );
    wire [1:0]hd_rs,hd_rt;
    wire [31:0]busA,busB;
    control control1(ctrl,
    instruction[31:26],
    instruction[5:0],
    instruction,
    RegDst,
    Branch,
    MemtoReg,
    Alusrc1,
    Alusrc2,
    RegWrite,
    Jump,
    Extop,
    keep,
    MemWrite,
    MemRead,
    Aluctr);
    // wire [4:0]wa;
    // wire [4:0]rs;
    assign rs=instruction[25:21];
    assign rt=instruction[20:16];
    assign rd=instruction[15:11];
    // assign wa=(RegDst==0)?rt:rd;
    assign pc_4_out=pc_4;
    forward_id forward_id1(rs,rt,rd_exe,rd_mem,
    RegWrite_exe,
    RegWrite_mem,
    MemRead_mem,
    hd_rs,hd_rt);
    // hazardDetect  hazardDetect1(clk,reset,rs,rt,rt_exe,
    // MemRead_exe&RegWrite_exe,Branch,jump,
    // instruction[25:0],immi,pc,busA,busB,
    // );
    regfile regfile1(clk,RegWrite_wb,jal_en,rs,rt,rd_wb,data_wb,jal_wdata,busA,busB);
    assign immi_1 = {{27{1'b0}},instruction[10:6]};
    signext signext1(instruction[15:0],Extop,immi_2);
    always @(*)
        begin
            if(hd_rs==2'b01)
                out1=Aluout_exe;
            else if(hd_rs==2'b10)
                out1=Aluout_mem;
            else if(hd_rs==2'b11)
                out1=Rdata_mem;
            else if(hd_rs==2'b00)
                out1=busA;
            if(hd_rt==2'b00)
                out2=busB;
            else if(hd_rt==2'b01)
                out2=Aluout_exe;
            else if(hd_rt==2'b10)
                out2=Aluout_mem;
            else if(hd_rt==2'b11)
                out2=Rdata_mem;
        end
    
endmodule

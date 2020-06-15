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
    input clk,reset,
    input [31:0]pc,pc_4,instruction,
    input [31:0]Aluout_exe,Aluout_mem,Rdata_mem,data_wb,
    input [4:0]rd_exe,rd_mem,rd_wb,
    input  
    RegWrite_exe,
    RegWrite_mem,
    RegWrite_wb,
    MemRead_mem,
    output RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    MemRead,
    RegWrite,
    Jump,
    output [2:0]Aluctr,
    output [4:0]rs,rt,rd,
    output [31:0]immi,
    output reg [31:0]out1,out2,
    output [31:0]pc_4_out
    );
    wire [1:0]hd_rs,hd_rt;
    wire [31:0]busA,busB;
    control control1(instruction,
    RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    MemRead,
    RegWrite,
    Jump,
    Extop,
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
    regfile regfile1(clk,RegWrite_wb,rs,rt,rd_wb,data_wb,busA,busB);
    signext signext1(instruction[15:0],Extop,immi);
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

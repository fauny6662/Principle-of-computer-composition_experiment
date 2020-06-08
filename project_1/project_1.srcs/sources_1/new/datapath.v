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


module datapath(
    input clk,
    reset,
    RegDst,
    AluSrc,
    MemtoReg,
    RegWrite,
    MemWrite,
    Branch,
    Jump,
    ExtOp,
    input [2:0]ALUctr,
    output wire [31:0]instruction
    ); 
    wire [4:0]rs,rt,rd;
    wire [15:0]im;
    wire [25:0]jpc;
    // reg [31:0]pc;
    wire [31:0]address;
    wire [31:0]busA,busB,busC,result;
    wire [31:0]immi;
    wire zero;
    wire [4:0]wa;
    wire [31:0]wd;
    wire [31:0]Rdata;
    wire [31:0]npc;
    pc pc1(1,clk,reset,npc,address);
    im_4k im1(address[11:0],instruction);
    assign rs=instruction[25:21];
    assign rt=instruction[20:16];
    assign rd=instruction[15:11];
    assign wa=(RegDst==0)?rt:rd;
    assign im=instruction[15:0];
    regfile regfile1(clk,RegWrite,rs,rt,wa,wd,busA,busB);
    signext signext1(im,ExtOp,immi);
    mux2 mu1(immi,busB,AluSrc,busC);
    alu alu1(ALUctr,busA,busC,zero,result);
    dm_4k dm1(result [11:0],busB,MemWrite,clk,Rdata);
    mux2 mu2(Rdata,result,MemtoReg,wd);
    assign jpc=instruction[25:0];
    npc npc1(im,Branch,zero,Jump,address,jpc,npc);
    // always @(!reset)
    //     pc=npc;
    // assign pc=address;
    // always @(!reset)
        // pc=npc;
endmodule

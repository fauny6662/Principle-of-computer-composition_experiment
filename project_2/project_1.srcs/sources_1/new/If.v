`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 19:55:26
// Design Name: 
// Module Name: If
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


module If(
    input clk,reset,
    input [31:0]address,//跳转地址
    input [31:0]pc_in,
    input PcWrite,pc_src,pc_flush,
    output reg [31:0] pc_4,
    output [31:0]pc_out,instrustion
    //未冒险
    );
    wire [31:0] npc;
    assign npc=(pc_src==1)?address:pc_in;
    
    pc pc1(PcWrite,clk,reset,npc,pc_out);
    im_4k im1(pc_out[11:0],instrustion);
    always@(*)
        begin
            if(pc_flush==1)
                pc_4=pc_out;
            else
                pc_4=pc_out+4;
            if(pc_src==1)
                pc_4=npc+4;
        end
endmodule

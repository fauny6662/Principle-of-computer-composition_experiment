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
    input [31:0]address,error_address,//跳转地址
    input [31:0]pc_in,
    input PcWrite,pc_src,pc_flush,if_lw,error,
    output reg [31:0] pc_4,
    output [31:0]pc_out
    );
    wire [31:0] npc,t;
    assign t=(pc_src==1)?address:pc_in;
    assign npc=(error==1)?error_address:t;
    pc pc1(PcWrite,clk,reset,npc,pc_out);
    always@(*)
        begin
            if(pc_flush==1||if_lw==1)
                pc_4=pc_out;
            else
                pc_4=pc_out+4;
            if(pc_src==1)
                pc_4=npc+4;

        end
endmodule

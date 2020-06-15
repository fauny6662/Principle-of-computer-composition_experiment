`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 15:11:31
// Design Name: 
// Module Name: npc
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


module npc #(parameter width=32)
    (
    input [31:0]immi,
    input br,zero,
    input [31:0]pc_4, //
    output wire [31:0]npc);
    wire [31:0] pc_br;
    wire [31:0] immi_l;
    assign immi_l={immi[width-3:0],2'b00};
    assign pc_br=pc_4+immi_l;
    assign npc=(br&zero==1)?pc_br:pc_4;
    // always @(br or !br or jp or !jp)
    //     begin
    //         if(jp==1)
    //             npc=pc_jump;
    //         else if(br &zero==1)
    //             npc=pc_br;
    //         else
    //             npc=pc_plus_4;
    //     end
endmodule

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


module npc(
    input [15:0]immi,
    input br,zero,jp,
    input [31:0]pc,
    input [25:0]jpc,
    output wire [31:0]npc);
    wire [31:0] pc_plus_4,pc_br,pc_jump,t;
    assign pc_plus_4 =pc+4;
    assign  pc_jump={pc[31:28],jpc,2'b00};
    assign pc_br=pc_plus_4+{{14{immi[15]}},immi,2'b00};
    assign t=(jp==1)?pc_jump:pc_plus_4;
    assign npc=(br&zero==1)?pc_br:t;
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

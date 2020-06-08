`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 15:48:28
// Design Name: 
// Module Name: sim_npc
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


module sim_npc;
    reg [15:0]immi;
    reg br,zero,jp;
    reg [31:0]pc;
    reg [25:0]jpc;
    wire [31:0]npc;
    npc npc1(immi,br,zero,jp,pc,jpc,npc);
    initial
        begin
            br=1;
            jpc=2;
            pc=32'h0x0000_3004;
        end
endmodule

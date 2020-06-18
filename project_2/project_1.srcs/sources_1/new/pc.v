`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 13:52:10
// Design Name: 
// Module Name: pc
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


module pc #(parameter width = 32)
    (input ena,clk,rst,
    input [width-1:0] npc,
    // input [31:0] address,
    output reg [width-1:0] pc_out);
    always @(posedge clk)
    if(rst)
        begin
            pc_out<=32'h0x0000_3000;
            
        end
    else if(ena)
        begin
            pc_out<=npc;
        end
    // initial 
    //     pc_out=32'b0;
endmodule

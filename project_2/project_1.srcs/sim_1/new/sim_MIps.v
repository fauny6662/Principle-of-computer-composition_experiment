`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/07 14:58:43
// Design Name: 
// Module Name: sim_MIps
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


module sim_MIps;
    reg  clk,reset;
    Mips Mips1(clk,reset);
    initial 
        begin:Cloking
            clk=0;
            
            forever #10 clk=~clk;
        end
    initial
        begin
            reset=1;
            #15 reset=0;
        end
endmodule

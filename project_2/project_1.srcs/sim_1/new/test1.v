`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 15:21:41
// Design Name: 
// Module Name: test1
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

module test1;
    reg s;
    wire [31:0]y;
    reg [31:0]a,b;
    mux2 mux(a,b,s,y);
    initial 
        begin
            s=1;
            a=32'h0x0000_3000;
            b=32'h0x0000_3022;
        end
endmodule
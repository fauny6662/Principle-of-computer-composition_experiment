`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 14:16:17
// Design Name: 
// Module Name: test
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


module test;
    reg reset,clk,ena;
    reg [32-1:0] data;
    wire [32-1:0] out;
    pc pc1(.ena(ena),.clk(clk),.rst(reset),.data(data),.out(out));
    initial
        begin:Clocking
            clk=0;
            forever #10 clk =!clk;
        end
    initial
        begin
            reset=1'b0;
            ena=1'b1;
            clk=1'b0;
            data=32'h0x0000_3000;
        end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/28 08:14:21
// Design Name: 
// Module Name: BadVAddr
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


module BadVAddr(
    input clk,reset,
    input write,
    input [31:0]address,
    output reg [31:0]address_out
    );
    always@(posedge clk)
        begin
            if(reset==1)
                begin
                    address_out<=address;
                end 
            else if(write==1)
                begin
                    address_out<=address;
                end
        end
endmodule

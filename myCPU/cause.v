`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/15 14:01:05
// Design Name: 
// Module Name: cause
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


module cause(
    input clk,reset,
    input [31:0]reason,
    output reg [31:0]reason_out
    );
    always @(posedge clk)
        begin
            if(reset==0)
                begin
                    reason_out<=reason;
                end 
        end
endmodule

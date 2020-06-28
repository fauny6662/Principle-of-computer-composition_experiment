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


module Count(
    input clk,reset,
    input write,
    input conut_in,
    output reg [31:0]count
    );
    always@(posedge clk)
        begin
            if(reset==1)
                begin
                    count<=0;
                end
            else if(write==1)
                begin
                    count<=conut_in;
                end
            else
                begin   
                    count<=count+1;    
                end 
        end
    initial
        begin
            count=0;
        end
endmodule

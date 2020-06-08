`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 19:07:09
// Design Name: 
// Module Name: alu
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


module alu(
    input [2:0] op,
    input [31:0] a,b,
    output reg zero,
    output reg [31:0] result
    );
    reg t;
    always @(*)
        begin
            
            case (op)
                3'b000:result=a+b; //+u
                3'b100:result=$signed(a)+$signed(b);  
                3'b001:result=a-b;  //-u
                3'b101:result=$signed(a)-$signed(b);  
                3'b010:result=a|b;
                3'b011:result=a&b;
                3'b111:result=($signed(a)<$signed(b))?1:0;  
                default: result=0;
            endcase
            assign zero =(result==0)? 1:0;
        end
    initial 
        begin
            zero=0;
        end
endmodule

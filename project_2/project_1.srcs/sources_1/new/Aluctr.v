`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/06 20:56:28
// Design Name: 
// Module Name: Aluctr
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


module Aluctr(
    input r_type,
    input [5:0]func,
    input [1:0]Aluop,
    output reg [2:0]Aluctr
    );
    always @(*)
        begin
            if(r_type==0)
                begin
                    if(Aluop==2'b11)
                        Aluctr=3'b110;
                    else
                    Aluctr={1'b0,Aluop};
                end
            else 
                begin
                    case (func)
                        6'b100000:
                            Aluctr=3'b100;  //+
                        6'b100010:
                            Aluctr=3'b101;  //-
                        6'b100100:
                            Aluctr=3'b011;  //&
                        6'b100101:
                            Aluctr=3'b010;  //|
                        6'b100001:
                            Aluctr=3'b000;  //+u
                        6'b100011:
                            Aluctr=3'b001;  //-u
                        6'b101010:
                            Aluctr=3'b111;  //slt
                        default: 
                            Aluctr=0;
                    endcase
                end
        end
endmodule
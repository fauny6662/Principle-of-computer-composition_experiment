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
    input [4:0] op,
    input [31:0] a,b,
    output reg zero,overflow,
    output reg [31:0] result
    );
    reg [4:0] t;//t为指令中sa，或$rs值的低五位的值
    always @(*)
        begin
            t=a[4:0];
            case (op)
                5'b10001:result=a+b; //无符号加
                5'b10000:result=$signed(a)+$signed(b);//带符号加  
                5'b10011:result=a-b;  //无符号减
                5'b10010:result=$signed(a)-$signed(b);//带符号减
                5'b10101:result=a|b;
                5'b10100:result=a&b;
                5'b11011:result=(a<b)?1:0;//无符号比较
                5'b11010:result=($signed(a)<$signed(b))?1:0;//带符号比较  
                5'b11000:result={b[15:0],{16{1'b0}}};//lui
                5'b10111:result=~(a|b);//或非
                5'b10110:result=a^b;//异或
                5'b00000:result=b<<t;//逻辑左移
                5'b00100:result=b<<t;
                5'b00010:result=b>>t;//逻辑右移
                5'b00110:result=b>>t;
                5'b00011:result=({32{b[31]}}<<(6'd32-{1'b0,t}))|(b>>t);//算术右移
                5'b00111:result=({32{b[31]}}<<(6'd32-{1'b0,t}))|(b>>t);
                5'b01000:result=a;//只用来jal的alu计算
                default: result=0;
            endcase
            assign zero =(result==0)? 1:0;
            overflow=0;
            /*if(op==5'b10000|op==5'b10010)
                begin
                    if(result[31]==1)
                        overflow=1; 
                end*/
            if(op==5'b10000&&a[31]==b[31]&&a[31]!=result[31])
                overflow=1;
        end
    initial 
        begin
            zero=0;
        end
endmodule

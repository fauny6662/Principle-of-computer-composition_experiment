`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 19:47:33
// Design Name: 
// Module Name: if_id
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


module if_id(
    input clk,reset,if_flush,if_id_write,if_lw,
    input [31:0]pc,pc_4,
    // instruction_in,
    // input we,
    output reg [31:0]pc_out,pc_4_out
    //, instruction_out
    );
    reg [31:0]a,b;
    always @(posedge clk)
        begin
            if(reset==1)
                begin
                    pc_out<=32'b0;
                    pc_4_out<=32'b0;
                    // instruction_out<=32'b0;
                    // instr_out<=32'b0;
                end
            else if(if_lw==1)
                begin
                    ;
                end
            else 
                begin
                     if(if_id_write==1)
                        begin
                            pc_out<=pc;
                            pc_4_out<=pc_4;
                            // instruction_out<=instruction_in;
                        end
                    else
                        begin
                            pc_out<=a+8;
                            pc_4_out<=b+8;
                        end    
                
                    if(if_flush==1)
                        begin
                            pc_out<=32'b0;
                            pc_4_out<=32'b0;
                        end
                end
             a=pc_out;
             b=pc_4_out;
         end
endmodule

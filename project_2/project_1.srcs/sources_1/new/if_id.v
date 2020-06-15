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
    input clk,reset,if_id_write,
    input [31:0]pc,pc_4,
    instruction,
    // input we,
    output reg [31:0]pc_out,
    instr_out,
    pc_4_out
    );
    always @(posedge clk)
        begin
            if(reset==1)
                begin
                    pc_out<=32'b0;
                    pc_4_out<=32'b0;
                    // instr_out<=32'b0;
                end
            else 
                begin
                     if(if_id_write==1)
                        begin
                            pc_out<=pc;
                            pc_4_out<=pc_4;
                            instr_out<=instruction;
                        end
                    else
                        begin
                            pc_out<=32'b0;
                            pc_4_out<=32'b0;
                            instr_out<=32'b0;
                        end    
                end
        end
endmodule

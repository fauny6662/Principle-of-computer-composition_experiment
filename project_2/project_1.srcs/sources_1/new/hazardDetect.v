`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 21:56:50
// Design Name: 
// Module Name: hazardDetect
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


module hazardDetect(
    input clk,reset,
    input [4:0]rs_id,rt_id,rt_exe,
    input lw_pre,
    input branch,
    input jump,
    input [31:0]instruction_id,
    input [31:0]bpc,pc,
    input [31:0]a,b,
    output reg PcWrite,
    if_idWrite,
    pc_flush,
    pc_src,
    output reg [31:0]address_out
    );
        
    always @(negedge clk)
        begin
            if(lw_pre==1) //前一条lw
                begin
                    if(rt_exe==rs_id||rt_exe==rt_id)
                        begin
                            pc_flush=1;
                            if_idWrite=0;
                            PcWrite=0;
                        end
                end
            else if(branch==1)//beq bne bgez blez四种指令
                begin
                    if((instruction_id[31:26]==6'b000100&&a==b)||(instruction_id[31:26]==6'b000101&&a!=b)||(instruction_id[31:26]==6'b000001&&rt_id==5'b00001&&a>=0)||(instruction_id[31:26]==6'b000110&&a<=0))
                        begin
                            pc_flush=1;
                            if_idWrite=0;
                            PcWrite=1;
                            pc_src=1;
                            address_out=pc+{bpc[29:0],2'b00}+4;
                        end
                end
            else if(jump==1)//j jr两种指令
                begin
                    if(instruction_id[31:26]==6'b000010)
                        begin
                            pc_flush=1;
                            if_idWrite=0;
                            PcWrite=1;
                            pc_src=1;
                            address_out={pc[31:28],instruction_id[25:0],2'b00};
                        end
                    if(instruction_id[31:26]==6'b000000)
                        begin
                            pc_flush=1;
                            if_idWrite=0;
                            PcWrite=1;
                            pc_src=1;
                            address_out=a;
                        end
                end
            else
                begin
                    pc_flush=0;
                    if_idWrite=1;
                    PcWrite=1;
                    pc_src=0;
                    address_out=32'b0;
                end
        end
endmodule

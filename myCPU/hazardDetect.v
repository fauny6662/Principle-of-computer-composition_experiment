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
    input [1:0]lw_pre,
    input branch,
    input [1:0]jump,
    input [31:0]instruction_id,
    input [31:0]bpc,pc,
    input [31:0]a,b,
    output reg PcWrite,
    if_idWrite,
    pc_flush,
    pc_src,
    ctrl,
    id_lw,
    if_lw,
    output reg [31:0]address_out
    );
    reg [31:0] A, B;
    wire [31:0]c;
    reg f;
    assign c=a-b;
    always @(negedge clk)
        begin
            f=0;
            pc_flush=0;
            if_idWrite=1;
            PcWrite=1;
            pc_src=0;
            ctrl=0;
            id_lw=0;
            if_lw=0;
            address_out=32'b0;
                    #0.5;
                    if(lw_pre!=2'b00) //前一条lw/lh/lb
                        begin
                            if(rt_exe==rs_id||rt_exe==rt_id)
                                begin
                                    pc_flush=1;
                                    if_idWrite=0;
                                    PcWrite=0;
                                    id_lw=1;
                                    if_lw=1;
                                    ctrl=0;
                                    f=1;
                                end
                        end
                    #0.5;
                    if(branch==1&&f==0)//beq bne bgez bgtz blez bltz六种指令
                        begin
                            if((instruction_id[31:26]==6'b000100&&c==32'b0)||(instruction_id[31:26]==6'b000101&&c!=32'b0)||(instruction_id[31:26]==6'b000001&&rt_id==5'b00001&&$signed(a)>=0)||(instruction_id[31:26]==6'b000111&&$signed(a)>0)||(instruction_id[31:26]==6'b000110&&$signed(a)<=0)||(instruction_id[31:26]==6'b000001&&rt_id==5'b00000&&$signed(a)<0))
                                begin
                                    pc_flush=0;
                                    if_idWrite=0;
                                    PcWrite=1;
                                    pc_src=1;
                                    id_lw=0;
                                    if_lw=0;
                                    ctrl=1;
                                    address_out=pc+{bpc[29:0],2'b00}+4;
                                    
                                end
                        end
                    else if(jump!=2'b00&&f==0)//j jr jal三种指令
                        begin
                            if(jump==2'b01)
                                begin
                                    pc_flush=0;
                                    if_idWrite=1;
                                    PcWrite=1;
                                    pc_src=1;
                                    ctrl=1;
                                    id_lw=0;
                                    if_lw=0;
                                    address_out={pc[31:28],instruction_id[25:0],2'b00};
                                end
                            else if(jump==2'b10)  //jr
                                begin
                                    pc_flush=0;
                                    if_idWrite=1;
                                    PcWrite=1;
                                    pc_src=1;
                                    ctrl=1;
                                    id_lw=0;
                                    if_lw=0;
                                    address_out=a;
                                end
                            else if(jump==2'b11)//jal
                                begin
                                    pc_flush=0;
                                    if_idWrite=0;
                                    PcWrite=1;
                                    pc_src=1;
                                    ctrl=0;
                                    id_lw=0;
                                    if_lw=0;
                                    address_out={pc[31:28],instruction_id[25:0],2'b00};
                                end
                        end
        end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 22:40:31
// Design Name: 
// Module Name: forward_id
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


module forward_id(
    input [4:0]rs_id,
    rt_id,
    // rs_exe,
    // rt_exe,
    rd_exe,
    rd_mem,
    input RegWrite_exe,
    RegWrite_mem,
    MemRead_mem,
    output reg [1:0]hd_rs,hd_rt
    );
    always @(*)
        begin
            hd_rs=0;
            hd_rt=0;
            if(RegWrite_exe==1)//前一条写
                begin
                    if(rd_exe==rt_id||rd_exe==rs_id)//前一条发生
                        begin
                            if(rs_id==rd_exe)
                                hd_rs=2'b01;
                            if(rt_id==rd_exe)
                                hd_rt=2'b01;
                        end
                end
            if(RegWrite_mem==1)//前前一条写 
                begin
                    if(rd_mem==rt_id||rd_mem==rs_id) //前前一条发生
                        begin
                            if(rd_mem==rs_id)
                                hd_rs=2'b10;
                            if(rd_mem==rt_id)
                                hd_rt=2'b10;
                        end                    
                end
            if(MemRead_mem&&RegWrite_mem==1)//前前一条lw
                begin
                    if(rd_mem==rs_id)
                        hd_rs=2'b11;
                    if(rd_mem==rt_id)
                        hd_rt=2'b11;
                end
        end
endmodule

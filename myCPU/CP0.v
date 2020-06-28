`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/21 15:28:15
// Design Name: 
// Module Name: CP0
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


module CP0(
    input clk,reset,
    input overflow,
    input keepinstr,
    input mtc0,
    input [31:0]id_pc,
    input [31:0]exe_pc,
    input [31:0]address_in,
    input [31:0]count_in,
    input [31:0]status_in,
    input [31:0]pc_in,
    input [31:0]cause_in,
    output [31:0]bad_address,
    output [31:0]count_out,
    output [31:0]status_out,
    output [31:0]cause_out,
    output reg[31:0]pc_out,
    output [31:0]pc_back,
    output reg if_flush,
    id_flush,
    exe_flush
    );
    reg write_bad,write_cau,write_cou,write_epc,write_sta;
    reg clk_count;
    reg [31:0]reason;
    reg [31:0]status,pc,cause;
    BadVAddr BadVAddr1(clk,reset,write_bad,address_in,bad_address);
    Status Status1(clk,reset,write_sta,status,status_out);
    Count Count1(clk_count,reset,write_cou,count_in,count_out);
    epc epc1(clk,reset,write_epc,pc,pc_back);
    cause cause1(clk,reset,write_cau,cause,cause_out);
    initial 
        begin
            clk_count=0;
        end
    always @(posedge clk)
        begin
            clk_count=~clk_count;
        end
    always @(*)
        begin
            pc_out=0;
            id_flush=0;
            exe_flush=0;
            if_flush=0;
            write_bad=0;
            write_cau=0;
            write_cou=0;
            write_epc=0;
            write_sta=0;
            if(overflow|keepinstr==1)
                begin
                    pc_out=32'h0xBFC00380;
                    id_flush=1;
                    exe_flush=1;
                    if_flush=1;
                    reason[31:0]=32'b0;
                    if(overflow==1)
                        begin
                            status=0;
                            status[22]=1;
                            status[1]=1;         
                            reason[6:2]=5'h0x0c;
                            pc=exe_pc;
                            cause=reason;
                            // write_bad=1;
                            write_cau=1;
                            // write_cou=1;
                            write_epc=1;
                            write_sta=1;
                        end
                    else if(keepinstr==1)
                        begin
                            status=0;
                            status[22]=1;
                            status[1]=1; 
                            reason[6:2]=5'h0x0a;
                            pc=id_pc;
                            cause=reason;
                            // write_bad=1;
                            write_cau=1;
                            // write_cou=1;
                            write_epc=1;
                            write_sta=1;
                        end
                end
             else if(mtc0==1)
                begin
                    status=status_in;
                    pc=pc_in;
                    cause=cause_in;
                    write_bad=1;
                    write_cau=1;
                    write_cou=1;
                    write_epc=1;
                    write_sta=1;
                end   
        end
endmodule

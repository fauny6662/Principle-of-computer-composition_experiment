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
    input [31:0]id_pc,
    input [31:0]exe_pc,
    input [31:0]address,
    input [31:0]count_in,
    input [31:0]status_in,
    input [31:0]cause_in,
    input [31:0]pc_in,
    output [31:0]bad_address,
    output [31:0]count_out,
    output [31:0]status_out,
    output [31:0]cause_out,
    output [31:0]pc_back,
    
    output reg if_flush,
    id_flush,
    exe_flush
    );
    wire write_bad,write_cau,write_cou,write_epc,write_sta;
    reg clk_count;
    // reg  [31:0]pc_in;
    BadVAddr BadVAddr1(clk,reset,write_bad,address,bad_address);
    Status Status1(clk,reset,write_sta,status_in,status_out);
    Count Count1(clk_count,reset,write_cou,count_in,count_out);
    epc epc1(clk,reset,write_epc,pc_in,pc_back);
    cause cause1(clk,reset,write_cau,cause_in,cause_out);
    always @(posedge clk)
        begin
            clk_count=~clk_count;
        end
    initial
        begin
            clk_count=0;
        end
    // always @(*)
    //     begin
    //         reason[31:0]=32'b0;
    //         id_flush=0;
    //         exe_flush=0;
    //         if_flush=0;
    //         if(overflow==1)
    //             begin
    //                 status=1;
    //                 pc_out=32'h0xBFC00380;
    //                 reason[6:2]=5'h0x0c;
    //                 id_flush=1;
    //                 exe_flush=1;
    //                 if_flush=1;
    //                 pc_in=exe_pc;
    //             end
    //         else if(keepinstr==1)
    //             begin
    //                 status=1;
    //                 pc_out=32'h0xBFC00380;
    //                 reason[6:2]=5'h0x0a;
    //                 id_flush=1;
    //                 exe_flush=1;
    //                 if_flush=1;
    //                 pc_in=id_pc;
    //             end
    //     end
endmodule

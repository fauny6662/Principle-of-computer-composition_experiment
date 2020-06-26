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
    output reg status,
    output reg [31:0]pc_out,
    output [31:0]pc_back,
    output reg if_flush,
    id_flush,
    exe_flush
    );
    reg  [31:0]reason;
    wire [31:0]reason_out;
    reg  [31:0]pc_in;
    epc epc1(clk,reset,pc_in,pc_back);
    cause cause1(clk,reset,reason,reason_out);
    always @(*)
        begin
            reason[31:0]=32'b0;
            id_flush=0;
            exe_flush=0;
            if_flush=0;
            if(overflow==1)
                begin
                    status=1;
                    pc_out=32'h0xBFC00380;
                    reason[6:2]=5'h0x0c;
                    id_flush=1;
                    exe_flush=1;
                    if_flush=1;
                    pc_in=exe_pc;
                end
            else if(keepinstr==1)
                begin
                    status=1;
                    pc_out=32'h0xBFC00380;
                    reason[6:2]=5'h0x0a;
                    id_flush=1;
                    exe_flush=1;
                    if_flush=1;
                    pc_in=id_pc;
                end
        end
endmodule

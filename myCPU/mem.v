`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 22:46:30
// Design Name: 
// Module Name: mem
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


module mem(
    input clk,reset,
    input Branch,
    MemtoReg,RegWrite,
    input [1:0]memR,
    input [31:0]Aluout,data_sram_rdata,
    input zero,
    input [4:0]rd,
    output br,
    output MemtoReg_out,
    output RegWrite_out,
    output [31:0]Aluout_out,
    output reg [31:0]rdata_mem,
    output [4:0]rd_out
    );
    assign MemtoReg_out=MemtoReg;
    assign RegWrite_out=RegWrite;
    assign Aluout_out=Aluout;
    assign br=Branch&zero;
    assign rd_out=rd;
    always @(*)
        begin
            case (memR)//读内存
            2'b01: //lb
                begin
                    case (Aluout[1:0])
                        2'b00: rdata_mem = {{24{data_sram_rdata[7]}}, data_sram_rdata[7:0]};
                        2'b01: rdata_mem = {{24{data_sram_rdata[15]}}, data_sram_rdata[15:8]};
                        2'b10: rdata_mem = {{24{data_sram_rdata[23]}}, data_sram_rdata[23:16]};
                        2'b11: rdata_mem = {{24{data_sram_rdata[31]}}, data_sram_rdata[31:24]};
                    endcase
                end
            2'b10: //lh
                begin
                    case (Aluout[1:0])
                        2'b00: rdata_mem = {{16{data_sram_rdata[15]}}, data_sram_rdata[15:0]};
                        2'b01: rdata_mem = {{16{data_sram_rdata[23]}}, data_sram_rdata[23:8]};
                        2'b10: rdata_mem = {{16{data_sram_rdata[31]}}, data_sram_rdata[31:16]};
                    endcase
                end
            2'b11: //lw
                begin
                    rdata_mem = data_sram_rdata;
                end
            default:rdata_mem=0;
            endcase
        end 
endmodule

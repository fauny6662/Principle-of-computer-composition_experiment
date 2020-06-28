`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 15:37:20
// Design Name: 
// Module Name: judge
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


module judge(
    input [1:0]memW,
    input [31:0]Aluout,busB,
    input [4:0]rd,
    input mtc0,mfc0,
    input [31:0]badAddr_out,count_out,status_out,cause_out,epc_out,//从寄存器中读出的值
    output reg [3:0] data_sram_wen,
    output reg [31:0] data_sram_wdata,
    output  [31:0] data_sram_addr,
    output reg [31:0] badAddr,count,status,cause,epc,except_data,
    output reg[31:0]alu_forward
    );
    assign data_sram_addr=Aluout& 32'h1fffffff;
    reg a,b;
    always @(*)
        begin
            a=0;
            b=0;
            data_sram_wen=0;
            case (memW)//写入内存
                2'b01: //sb
                    begin
                        case (Aluout[1:0])
                            2'b00:
                            begin
                                data_sram_wdata = busB;
                                data_sram_wen = 4'b0001;
                            end 
                            2'b01:
                            begin
                                data_sram_wdata = busB << 8;
                                data_sram_wen = 4'b0010;
                            end
                            2'b10:
                            begin
                                data_sram_wdata = busB << 16;
                                data_sram_wen = 4'b0100;
                            end
                            2'b11:
                            begin
                                data_sram_wdata = busB << 24;
                                data_sram_wen = 4'b1000;
                            end
                        endcase
                    end
                2'b10://sh
                    begin
                        case (Aluout[1:0])
                            2'b00:
                            begin
                                data_sram_wdata = busB;
                                data_sram_wen = 4'b0011;
                            end 
                            2'b01:
                            begin
                                data_sram_wdata = busB << 8;
                                data_sram_wen = 4'b0110;
                            end
                            2'b10:
                            begin
                                data_sram_wdata = busB << 16;
                                data_sram_wen = 4'b1100;
                            end
                        endcase
                    end
                2'b11://sw
                    begin
                        data_sram_wdata = busB;
                        data_sram_wen = 4'b1111;
                    end
                2'b00:
                    begin
                        data_sram_wdata = 32'b0;
                        data_sram_wen = 4'b0000;
                    end
            endcase
            if(mtc0==1)
                begin
                    case (rd)
                        5'd8: badAddr=busB;
                        5'd9: count=busB;
                        5'd12: status=busB;
                        5'd13: cause=busB;
                        5'd14: epc=busB;
                    endcase
                    a=1;
                end
            else if(mfc0==1)
                begin
                    case (rd)
                        5'd8: except_data=badAddr_out;
                        5'd9: except_data=count_out;
                        5'd12: except_data=status_out;
                        5'd13: except_data=cause_out;
                        5'd14: except_data=epc_out; 
                        
                    endcase
                    alu_forward=except_data;
                end
            else 
                begin
                    alu_forward=Aluout;
                end
        end
endmodule

module rst_DM(
    input [31:0] aluResult, busB_mem, data_sram_rdata,
    input [1:0] memR, memW,
    output reg [3:0] data_sram_wen,
    output reg [31:0] data_sram_wdata, rdata//内存中实际读出的数据
);
    //没考虑地址错例外
    always @(*)
    begin
        case (memW)//写入内存
            2'b01: //sb
            begin
                case (aluResult[1:0])
                    2'b00:
                    begin
                        data_sram_wdata = busB_mem;
                        data_sram_wen = 4'b0001;
                    end 
                    2'b01:
                    begin
                        data_sram_wdata = busB_mem << 8;
                        data_sram_wen = 4'b0010;
                    end
                    2'b10:
                    begin
                        data_sram_wdata = busB_mem << 16;
                        data_sram_wen = 4'b0100;
                    end
                    2'b11:
                    begin
                        data_sram_wdata = busB_mem << 24;
                        data_sram_wen = 4'b1000;
                    end
                endcase
            end
            2'b10://sh
            begin
                case (aluResult[1:0])
                    2'b00:
                    begin
                        data_sram_wdata = busB_mem;
                        data_sram_wen = 4'b0011;
                    end 
                    2'b01:
                    begin
                        data_sram_wdata = busB_mem << 8;
                        data_sram_wen = 4'b0110;
                    end
                    2'b10:
                    begin
                        data_sram_wdata = busB_mem << 16;
                        data_sram_wen = 4'b1100;
                    end
                endcase
            end
            2'b11://sw
            begin
                data_sram_wdata = busB_mem;
                data_sram_wen = 4'b1111;
            end
            2'b00:
            begin
                data_sram_wdata = 32'b0;
                data_sram_wen = 4'b0000;
            end
        endcase

        case (memR)//读内存
            2'b01: //lb
            begin
                case (aluResult[1:0])
                    2'b00: rdata = {{24{data_sram_rdata[7]}}, data_sram_rdata[7:0]};
                    2'b01: rdata = {{24{data_sram_rdata[15]}}, data_sram_rdata[15:8]};
                    2'b10: rdata = {{24{data_sram_rdata[23]}}, data_sram_rdata[23:16]};
                    2'b11: rdata = {{24{data_sram_rdata[31]}}, data_sram_rdata[31:24]};
                endcase
            end
            2'b10: //lh
            begin
                case (aluResult[1:0])
                    2'b00: rdata = {{16{data_sram_rdata[15]}}, data_sram_rdata[15:0]};
                    2'b01: rdata = {{16{data_sram_rdata[23]}}, data_sram_rdata[23:8]};
                    2'b10: rdata = {{16{data_sram_rdata[31]}}, data_sram_rdata[31:16]};
                endcase
            end
            2'b11: //lw
            begin
                rdata = data_sram_rdata;
            end
        endcase
    end
endmodule 
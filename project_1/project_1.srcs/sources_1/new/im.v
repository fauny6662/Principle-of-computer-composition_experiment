module im_4k(addr , dout);
    input [11: 0]addr;
    output [31: 0]dout;

    reg [31: 0] im[1023: 0];

    initial
        $readmemh("C:\\Users\\Fauny\\Desktop\\im.txt" , im);
        
    assign dout = im[addr[11: 2]];

endmodule

module PMem (
    input E,
    input [7:0] Addr,
    output [11:0] I,
    input LE,
    input [7:0] LA,
    input [11:0] LI
);
    reg [11:0] Prog_Mem[255:0] ;

    always @(posedge clk) begin
        if (LE == 1) begin
            Prog_Mem[LA] <= LI;
        end
    end

    assign I = (E == 1) ? Prog_Mem[Addr];

endmodule
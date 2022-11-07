module DMem (
    input clk,
    input E,
    input WE,
    input [3:0] Addr,
    input [7:0] DI,
    output [7:0] DO)
);

reg [7:0] data_mem [255:0];

always @(posedge clk) begin
    if (E == 1 && WE == 1)data_mem[Addr] <= DI;
end

assign DO = (E==1) ? data_mem[Addr];    

endmodule
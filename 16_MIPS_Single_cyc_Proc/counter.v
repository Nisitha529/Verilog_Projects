module counter (
    input enable,
    input clk,
    input rst_n,
    output reg[3:0] count
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) counter <= 4'b0000;
    else if (enable) begin
        counter <= counter + 4'b0001;
    end
end
    
endmodule
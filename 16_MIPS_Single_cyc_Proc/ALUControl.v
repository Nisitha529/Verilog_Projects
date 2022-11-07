module ALUControl (
    input [1:0] ALUOp,
    input [3:0] OPFunction,
    output reg[2:0] ALU_Control
);
    wire [5:0] ALUControlIn;

    assign ALUControlIn = {ALUOp,OPFunction};
    always @(ALUControlIn) begin
        casex (ALUControlIn)
            6'b11xxxx: ALU_Control = 3'b000;
            6'b10xxxx: ALU_Control = 3'b100;
            6'b000000: ALU_Control = 3'b001;
            6'b000001: ALU_Control = 3'b010;
            6'b000010: ALU_Control = 3'b011;
            6'b000100: ALU_Control = 3'b100;
            default: ALU_Control = 3'b000;
        endcase
    end
    

endmodule
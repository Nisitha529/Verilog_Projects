module MicroController (
    input clk,rst;
);
    parameter LOAD = 2'b00, FETCH = 2'b01 , DECODE = 2'b10 , EXECUTE = 2'b11 ;    
    reg [1:0] current_state , next_state ;
    reg [11:0] program_mem [9:0] ;
    reg load_done ;
    reg [7:0] load_addr ;
    wire [11:0] load_instr ;
    reg [7:0] PC , DR , Acc ;
    reg [11:0] IR ;
    reg [3:0] SR ;
    wire PC_E , Acc_E , SR_E , DR_E , IR_E ;
    reg PC_clr , Acc_clr , SR_clr , DR_clr , IR_clr;
    wire [7:0] PC_updated , DR_updated ;
    wire [11:0] IR_Updated ;
    wire [3:0] SR_Updated ;
    wire PMem_E , PMem_LE , DMem_E , DMem_WE , ALU_E , MUX1_Sel , MUX2_Sel ;
    wire [3:0] ALU_Mode ;
    wire [7:0] Adder_out ;
    wire [7:0] ALU_Out , ALU_Oper2 ;

    initial begin
        $readmemb("program_mem.dat",program_mem,0,9);
    end

    alu ALU_unit(
        .Operand1(Acc),
        .Operand2(ALU_Oper2),
        .E(ALU_E),
        .Mode(ALU_Mode),
        .CFlags(SR),
        .Out(ALU_Out),
        .Flags(SR_Updated)
        );

    MUX1 MUX2_unit (
        .In1(DR),
        .In2(IR[7:0]),
        .Sel(Mux2_Sel),
        .Out(ALU_Oper2)
    );

    DMem DMem_unit (
        .clk(clk),
        .E(DMem_E),
        .WE(DMem_WE),
        .Addr(IR[3:0]),
        .DI(ALU_Out),
        .DO(DR_updated),
    );

    PMem PMem_unit (
        .clk(clk),
        .E(PMem_E),
        .Addr(PC),
        .I(IR_Updated),
        .LE(PMem_LE),
        .LA(load_addr),
        .LI(load_instr)
    );

    adder PC_Adder_Unit(
        .In(PC);
        .Out(PC_updated);
    );

    Control_Logic Control_Logic_Unit(
        .stage(current_state),
        .IR(IR),
        .PC_E(PC_E),
        .Acc_E(Acc_E),
        .SR_E(SR_E),
        .IR_E(IR_E),
        .DR_E(DR_E),
        .PMem_E(PMem_E),
        .DMem_E(DMem_E),
        .DMem_WE(DMem_WE),
        .ALU_E(ALU_E),
        .MUX1_Sel(MUX1_Sel),
        .MUX2_Sel(MUX2_Sel),
        .PMem_LE(PMem_LE),
        .ALU_Mode(ALU_Mode)
    );

    always @(posedge clk) begin
        if (rst == 1) begin
            load_addr <= 0 ;
            load_done <= 1'b0 ;
        end
        else if (PMem_LE == 1) begin
            load_addr <= load_addr + 8'd1;
            if (load_addr == 8'd9) begin
                load_addr <= 8'd0;
                load_done <= 1'b1;
            end
            else begin
                load_done <= 1'b0;
            end
        end
    end

    assign load_instr = program_mem[load_addr];

    always @(posedge clk) begin
        if (rst == 1 )begin
            current_state <= LOAD ;
        end
        else begin
            current_state <= next_state ;
        end
    end

    always @(*) begin
        PC_clr = 0 ;
        Acc_Clr = 0;
        SR_Clr = 0 ;
        DR_Clr = 0 ;
        DR_Clr = 0 ;
        IR_Clr = 0 ;
        case (current_state)
            LOAD : begin
                if (load_done == 1) begin
                    next_state = FETCH ;
                    PC_Clr = 1 ;
                    Acc_Clr = 1 ;
                    SR_Clr = 1 ;
                    DR_Clr = 1 ;
                    IR_Clr = 1 ;
                end
                else next_state = LOAD ;
            end

            FETCH : begin
                next_state = DECODE ;
            end

            DECODE : begin
                next_state = EXECUTE ;
            end

            EXECUTE : begin
                next_state = FETCH ;
            end

        endcase
    end

    always @(posedge clk) begin
        if (rst == 1) begin
            PC <= 8'd0;
            Acc <= 8'd0;
            SR <= 4'd0;
        end
        
        else begin
            if (PC_E == 1'd1) PC <= PC_updated ;
            else if (PC_clr == 1) PC <= 8'd0;
            if (Acc_E == 1'd1 ) Acc <= ALU_Out;
            else if (Acc_clr == 1) Acc <= 8'd0;
            if (SR_E == 1'd1 ) SR <= SR_Updated ;
            else if (SR_clr == 1 ) SR <= 4'd0;
        end
    end

    always @(posedge clk) begin
        if (DR_E == 1'd1) begin
            DR <= DR_updated ;
        end
        else if (DR_clr == 1 ) begin
            DR <= 8'd0;
        end
        if (IR_E == 1'd1) begin
            IR <= IR_Updated ;
        end
        else if (IR_Clr == ) begin
            IR <= 12'd0;
        end
    end

endmodule
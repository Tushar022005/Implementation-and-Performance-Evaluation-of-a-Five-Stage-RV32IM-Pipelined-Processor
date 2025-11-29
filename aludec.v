// ALU Decoder
module aludec (
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,
    input  wire [1:0] ALUOp,
    output reg  [4:0] alu_ctrl
);

    always @(*) begin
        case (ALUOp)
            2'b00: alu_ctrl = 5'b00000; 
            2'b01: alu_ctrl = 5'b00001; 
            2'b10: begin                
                case ({funct7, funct3})
                    10'b0000000_000: alu_ctrl = 5'b00000; // ADD
                    10'b0100000_000: alu_ctrl = 5'b00001; // SUB
                    10'b0000000_111: alu_ctrl = 5'b00010; // AND
                    10'b0000000_110: alu_ctrl = 5'b00011; // OR
                    10'b0000000_100: alu_ctrl = 5'b00100; // XOR
                    10'b0000000_001: alu_ctrl = 5'b00101; // SLL
                    10'b0000000_101: alu_ctrl = 5'b00110; // SRL
                    10'b0000000_010: alu_ctrl = 5'b00111; // SLT
                    10'b0000001_000: alu_ctrl = 5'b01000; // MUL
                    10'b0000001_100: alu_ctrl = 5'b01001; // DIV
                    10'b0000001_110: alu_ctrl = 5'b01010; // REM
                    default: alu_ctrl = 5'b00000;
                endcase
            end
            default: alu_ctrl = 5'b00000;
        endcase
    end

endmodule

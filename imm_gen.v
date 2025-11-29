// Immediate Generator

module imm_gen (
    input  wire [31:0] instr,       // 32-bit instruction
    output reg  [31:0] imm_ext      // sign-extended immediate output
);

    wire [6:0] opcode = instr[6:0];

    always @(*) begin
        case (opcode)
            // I-type 
            7'b0000011,   
            7'b0010011,   
            7'b1100111:   
                imm_ext = {{20{instr[31]}}, instr[31:20]};

            // S-type 
            7'b0100011:
                imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            // B-type
            7'b1100011:
                imm_ext = {{19{instr[31]}}, instr[31], instr[7],
                            instr[30:25], instr[11:8], 1'b0};

            // U-type 
            7'b0110111,   
            7'b0010111:   
                imm_ext = {instr[31:12], 12'b0};

            // J-type
            7'b1101111:
                imm_ext = {{11{instr[31]}}, instr[31],
                            instr[19:12], instr[20], instr[30:21], 1'b0};

            default:
                imm_ext = 32'b0;
        endcase
    end

endmodule

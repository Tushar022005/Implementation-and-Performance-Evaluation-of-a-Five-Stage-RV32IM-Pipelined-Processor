module control_unit(
    input  wire [6:0] opcode,
    output reg        RegWrite,
    output reg        MemWrite,
    output reg        MemtoReg,
    output reg        Branch,
    output reg        Jump,
    output reg        ALUSrc,
    output reg [1:0]  ALUOp
);

always @(*) begin
    // defaults (NOP)
    RegWrite = 0;
    MemWrite = 0;
    MemtoReg = 0;
    Branch   = 0;
    Jump     = 0;
    ALUSrc   = 0;
    ALUOp    = 2'b00;

    case(opcode)

        7'b0110011: begin // R-type (add/sub/and/or/xor/mul/div)
            RegWrite = 1;
            ALUSrc   = 0;
            ALUOp    = 2'b10;
        end

        7'b0010011: begin // I-type ALU (addi/andi/xori/ori/slli/srli)
            RegWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00; // we force ALU to ADD by default 
        end

        7'b0000011: begin // LOAD 
            RegWrite = 1;
            MemtoReg = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00; // add for address
        end

        7'b0100011: begin // STORE
            MemWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00; // add for address
        end

        7'b1100011: begin // BRANCH 
            Branch  = 1;
            ALUOp   = 2'b01; // subtract compare
        end

        7'b1101111: begin // JAL
            RegWrite = 1;
            Jump     = 1;
        end

        default: begin
            // do nothing (NOP)
        end

    endcase
end

endmodule

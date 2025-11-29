// Produces control signals from opcode.

module control_unit (
    input  wire [6:0] opcode,
    output wire       RegWrite,
    output wire       MemWrite,
    output wire       MemtoReg,
    output wire       Branch,
    output wire       Jump,
    output wire       ALUSrc,
    output wire [1:0] ALUOp
);

    // instantiate maindec
    maindec u_maindec (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .Branch(Branch),
        .Jump(Jump),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );

endmodule

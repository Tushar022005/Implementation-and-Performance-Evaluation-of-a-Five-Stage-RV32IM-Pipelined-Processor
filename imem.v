
// Instruction Memory 

`timescale 1ns / 1ps

module imem (
    input  wire [31:0] addr,   // Program Counter address (from IF stage)
    output wire [31:0] instr   // instruction output
);

    // 256 x 32-bit instruction memory (1 KB)
    reg [31:0] memory [0:255];

    
    initial begin
      
        memory[0] = 32'h00400093; // addi x1, x0, 4
        memory[1] = 32'h00600113; // addi x2, x0, 6
        memory[2] = 32'h002081B3; // add x3, x1, x2
        memory[3] = 32'h02218233; // mul x4, x3, x2
        memory[4] = 32'h403202B3; // sub x5, x4, x3
        memory[5] = 32'h00228313; // addi x6, x5, 2
        memory[6] = 32'h021303b3; // mul x7, x6, x1
        memory[7] = 32'h00138413; // addi x8, x7, 1
        memory[8] = 32'h00000073; // ebreak

        for (integer k = 10; k < 100; k = k + 1) begin
            memory[k] = 32'h00000013; // NOP (addi x0, x0, 0)
        end

        



    end

    // PC increments by 4
    assign instr = memory[addr[9:2]];

endmodule

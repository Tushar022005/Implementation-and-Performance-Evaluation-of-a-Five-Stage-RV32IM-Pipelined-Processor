module branch_unit (
    input  wire [2:0] funct3,
    input  wire [31:0] rs1,
    input  wire [31:0] rs2,
    output reg        branch_taken
);

    always @(*) begin
        case (funct3)
            3'b000: branch_taken = (rs1 == rs2);                      // BEQ
            3'b001: branch_taken = (rs1 != rs2);                      // BNE
            3'b100: branch_taken = ($signed(rs1) < $signed(rs2));     // BLT
            3'b101: branch_taken = ($signed(rs1) >= $signed(rs2));    // BGE
            // unsigned branches (optional)
            3'b110: branch_taken = (rs1 < rs2);                       // BLTU
            3'b111: branch_taken = (rs1 >= rs2);                      // BGEU
            default: branch_taken = 1'b0;
        endcase
    end

endmodule

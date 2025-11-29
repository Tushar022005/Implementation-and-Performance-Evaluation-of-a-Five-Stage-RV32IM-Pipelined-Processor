// Outputs 2-bit control for operand A and B
module forwarding_unit (
    input  wire [4:0] ID_EX_rs1,     
    input  wire [4:0] ID_EX_rs2,    
    input  wire [4:0] EX_MEM_rd,     
    input  wire [4:0] MEM_WB_rd,     
    input  wire       EX_MEM_RegWrite, 
    input  wire       MEM_WB_RegWrite, 
    output reg  [1:0] forwardA,      
    output reg  [1:0] forwardB
);

    always @(*) begin
        // default: no forwarding
        forwardA = 2'b00;
        forwardB = 2'b00;

        // Forward A (rs1)
        if (EX_MEM_RegWrite && (EX_MEM_rd != 5'b0) && (EX_MEM_rd == ID_EX_rs1)) begin
            forwardA = 2'b10; // from EX/MEM (forward ALU result)
        end else if (MEM_WB_RegWrite && (MEM_WB_rd != 5'b0) && (MEM_WB_rd == ID_EX_rs1)) begin
            forwardA = 2'b01; // from MEM/WB (writeback data)
        end

        // Forward B (rs2)
        if (EX_MEM_RegWrite && (EX_MEM_rd != 5'b0) && (EX_MEM_rd == ID_EX_rs2)) begin
            forwardB = 2'b10;
        end else if (MEM_WB_RegWrite && (MEM_WB_rd != 5'b0) && (MEM_WB_rd == ID_EX_rs2)) begin
            forwardB = 2'b01;
        end
    end

endmodule

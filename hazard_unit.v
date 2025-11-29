module hazard_unit (
    input  wire [4:0] IF_ID_rs1,      
    input  wire [4:0] IF_ID_rs2,
    input  wire [4:0] ID_EX_rd,       
    input  wire       ID_EX_MemtoReg, 
    input  wire       EX_MEM_Branch,  
    input  wire       EX_MEM_zero,    
    output reg        PCWrite,
    output reg        IF_ID_Write,
    output reg        control_stall,  
    output reg        flush_if_id,    
    output reg        flush_id_ex     
);

    always @(*) begin
        // defaults
        PCWrite      = 1'b1;
        IF_ID_Write  = 1'b1;
        control_stall = 1'b0;
        flush_if_id  = 1'b0;
        flush_id_ex  = 1'b0;

        // 1) Load-use hazard: if ID/EX holds a load and destination matches IF/ID sources
        if (ID_EX_MemtoReg && ((ID_EX_rd == IF_ID_rs1) || (ID_EX_rd == IF_ID_rs2))) begin
            // Stall pipeline:
            PCWrite      = 1'b0; 
            IF_ID_Write  = 1'b0; 
            control_stall = 1'b1; 
        end

        // 2) Branch taken flush: if branch in EX/MEM and condition true
        if (EX_MEM_Branch && EX_MEM_zero) begin
            // flush the following stages (instructions fetched after branch)
            flush_if_id = 1'b1;
            flush_id_ex = 1'b1;
            
  
        end
    end

endmodule

// Selects ALU or Memory output for register writeback
module result_mux (
    input  wire [31:0] alu_result,
    input  wire [31:0] mem_data,
    input  wire        MemtoReg,
    output wire [31:0] write_data
);

    assign write_data = (MemtoReg) ? mem_data : alu_result;

endmodule

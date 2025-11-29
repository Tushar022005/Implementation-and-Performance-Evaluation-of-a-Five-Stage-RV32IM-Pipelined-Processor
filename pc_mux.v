// Next PC selector for RV32IM pipeline
module pc_mux (
    input  wire [31:0] pc_plus4,
    input  wire [31:0] pc_branch,
    input  wire [31:0] pc_jump,
    input  wire        BranchTaken,
    input  wire        Jump,
    output wire [31:0] next_pc
);

    assign next_pc = (Jump)        ? pc_jump   :
                     (BranchTaken) ? pc_branch :
                                     pc_plus4;

endmodule

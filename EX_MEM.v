// EX_MEM.v
module EX_MEM (
    input  wire        clk,
    input  wire        reset,
    // control & status in
    input  wire        RegWrite_in,
    input  wire        MemWrite_in,
    input  wire        MemtoReg_in,
    input  wire        Branch_in,
    input  wire        Jump_in,
    input  wire        zero_in,
    input  wire [31:0] alu_result_in,
    input  wire [31:0] write_data_in,
    input  wire [4:0]  rd_in,
    input  wire [31:0] pc_branch_in,
    input  wire [31:0] pc_plus4E_in,
    // outputs
    output reg         RegWrite_out,
    output reg         MemWrite_out,
    output reg         MemtoReg_out,
    output reg         Branch_out,
    output reg         Jump_out,
    output reg         zero_out,
    output reg  [31:0] alu_result_out,
    output reg  [31:0] write_data_out,
    output reg  [4:0]  rd_out,
    output reg  [31:0] pc_branch_out,
    output reg  [31:0] pc_plus4M_out
);

    always @(posedge clk) begin
        if (reset) begin
            RegWrite_out   <= 0;
            MemWrite_out   <= 0;
            MemtoReg_out   <= 0;
            Branch_out     <= 0;
            Jump_out       <= 0;
            zero_out       <= 0;
            alu_result_out <= 32'b0;
            write_data_out <= 32'b0;
            rd_out         <= 5'b0;
            pc_branch_out  <= 32'b0;
            pc_plus4M_out  <= 32'b0;
        end else begin
            RegWrite_out   <= RegWrite_in;
            MemWrite_out   <= MemWrite_in;
            MemtoReg_out   <= MemtoReg_in;
            Branch_out     <= Branch_in;
            Jump_out       <= Jump_in;
            zero_out       <= zero_in;
            alu_result_out <= alu_result_in;
            write_data_out <= write_data_in;
            rd_out         <= rd_in;
            pc_branch_out  <= pc_branch_in;
            pc_plus4M_out  <= pc_plus4E_in;
        end
    end

endmodule

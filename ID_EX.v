// ID_EX.v
module ID_EX (
    input  wire        clk,
    input  wire        reset,
    // control inputs
    input  wire        RegWrite_in,
    input  wire        MemWrite_in,
    input  wire        MemtoReg_in,
    input  wire        Branch_in,
    input  wire        Jump_in,
    input  wire        ALUSrc_in,
    input  wire [1:0]  ALUOp_in,
    // data inputs
    input  wire [31:0] rs1_data_in,
    input  wire [31:0] rs2_data_in,
    input  wire [31:0] imm_ext_in,
    input  wire [4:0]  rd_in,
    input  wire [4:0]  rs1_in,
    input  wire [4:0]  rs2_in,
    input  wire [2:0]  funct3_in,
    input  wire [6:0]  funct7_in,
    input  wire [31:0] pc_plus4D_in,
    // outputs
    output reg         RegWrite_out,
    output reg         MemWrite_out,
    output reg         MemtoReg_out,
    output reg         Branch_out,
    output reg         Jump_out,
    output reg         ALUSrc_out,
    output reg  [1:0]  ALUOp_out,
    output reg  [31:0] rs1_data_out,
    output reg  [31:0] rs2_data_out,
    output reg  [31:0] imm_ext_out,
    output reg  [4:0]  rd_out,
    output reg  [4:0]  rs1_out,
    output reg  [4:0]  rs2_out,
    output reg  [2:0]  funct3_out,
    output reg  [6:0]  funct7_out,
    output reg  [31:0] pc_plus4E_out
);

    always @(posedge clk) begin
        if (reset) begin
            RegWrite_out   <= 0;
            MemWrite_out   <= 0;
            MemtoReg_out   <= 0;
            Branch_out     <= 0;
            Jump_out       <= 0;
            ALUSrc_out     <= 0;
            ALUOp_out      <= 2'b00;
            rs1_data_out   <= 32'b0;
            rs2_data_out   <= 32'b0;
            imm_ext_out    <= 32'b0;
            rd_out         <= 5'b0;
            rs1_out        <= 5'b0;
            rs2_out        <= 5'b0;
            funct3_out     <= 3'b0;
            funct7_out     <= 7'b0;
            pc_plus4E_out  <= 32'b0;
        end else begin
            RegWrite_out   <= RegWrite_in;
            MemWrite_out   <= MemWrite_in;
            MemtoReg_out   <= MemtoReg_in;
            Branch_out     <= Branch_in;
            Jump_out       <= Jump_in;
            ALUSrc_out     <= ALUSrc_in;
            ALUOp_out      <= ALUOp_in;
            rs1_data_out   <= rs1_data_in;
            rs2_data_out   <= rs2_data_in;
            imm_ext_out    <= imm_ext_in;
            rd_out         <= rd_in;
            rs1_out        <= rs1_in;
            rs2_out        <= rs2_in;
            funct3_out     <= funct3_in;
            funct7_out     <= funct7_in;
            pc_plus4E_out  <= pc_plus4D_in;
        end
    end

endmodule

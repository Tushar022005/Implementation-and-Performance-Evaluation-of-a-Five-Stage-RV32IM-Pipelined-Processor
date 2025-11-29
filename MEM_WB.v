// MEM_WB.v
module MEM_WB (
    input  wire        clk,
    input  wire        reset,
    input  wire        RegWrite_in,
    input  wire        MemtoReg_in,
    input  wire [31:0] read_data_in,
    input  wire [31:0] alu_result_in,
    input  wire [4:0]  rd_in,
    input  wire [31:0] pc_plus4M_in,
    // outputs
    output reg         RegWrite_out,
    output reg         MemtoReg_out,
    output reg  [31:0] read_data_out,
    output reg  [31:0] alu_result_out,
    output reg  [4:0]  rd_out,
    output reg  [31:0] pc_plus4W_out
);

    always @(posedge clk) begin
        if (reset) begin
            RegWrite_out   <= 0;
            MemtoReg_out   <= 0;
            read_data_out  <= 32'b0;
            alu_result_out <= 32'b0;
            rd_out         <= 5'b0;
            pc_plus4W_out  <= 32'b0;
        end else begin
            RegWrite_out   <= RegWrite_in;
            MemtoReg_out   <= MemtoReg_in;
            read_data_out  <= read_data_in;
            alu_result_out <= alu_result_in;
            rd_out         <= rd_in;
            pc_plus4W_out  <= pc_plus4M_in;
        end
    end

endmodule

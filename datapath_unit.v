`timescale 1ns/1ps

module datapath_unit (
    input wire clk,
    input wire reset,
    output wire RegWriteW
);

    // FETCH STAGE 
    wire [31:0] pc_out, next_pc, pc_plus4F, instrF;

    assign pc_plus4F = pc_out + 32'd4;

    pc u_pc (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc_out(pc_out)
    );

    imem u_imem (
        .addr(pc_out),
        .instr(instrF)
    );

    // IF/ID PIPELINE 
    wire [31:0] pc_plus4D, instrD;
    IF_ID u_if_id (
        .clk(clk),
        .reset(reset),
        .pc_plus4F(pc_plus4F),
        .instrF(instrF),
        .pc_plus4D(pc_plus4D),
        .instrD(instrD)
    );

    //  DECODE STAGE 
    wire [6:0] opcodeD = instrD[6:0];
    wire [4:0] rdD     = instrD[11:7];
    wire [2:0] funct3D = instrD[14:12];
    wire [4:0] rs1D    = instrD[19:15];
    wire [4:0] rs2D    = instrD[24:20];
    wire [6:0] funct7D = instrD[31:25];

    wire RegWriteD, MemWriteD, MemtoRegD, BranchD, JumpD, ALUSrcD;
    wire [1:0] ALUOpD;

    control_unit u_control (
        .opcode(opcodeD),
        .RegWrite(RegWriteD),
        .MemWrite(MemWriteD),
        .MemtoReg(MemtoRegD),
        .Branch(BranchD),
        .Jump(JumpD),
        .ALUSrc(ALUSrcD),
        .ALUOp(ALUOpD)
    );

    wire [31:0] rd1D, rd2D;
    wire [31:0] imm_extD;

    regfile u_regfile (
        .clk(clk),
        .we3(RegWriteW),
        .a1(rs1D),
        .a2(rs2D),
        .a3(rdW),
        .wd3(wb_data),
        .rd1(rd1D),
        .rd2(rd2D)
    );

    imm_gen u_imm_gen (
        .instr(instrD),
        .imm_ext(imm_extD)
    );

    // ID/EX PIPELINE 
    wire RegWriteE, MemWriteE, MemtoRegE, BranchE, JumpE, ALUSrcE;
    wire [1:0] ALUOpE;
    wire [31:0] rs1_dataE, rs2_dataE, imm_extE, pc_plus4E;
    wire [4:0] rdE, rs1E, rs2E;
    wire [2:0] funct3E;
    wire [6:0] funct7E;

    ID_EX u_id_ex (
        .clk(clk),
        .reset(reset),
        .RegWrite_in(RegWriteD),
        .MemWrite_in(MemWriteD),
        .MemtoReg_in(MemtoRegD),
        .Branch_in(BranchD),
        .Jump_in(JumpD),
        .ALUSrc_in(ALUSrcD),
        .ALUOp_in(ALUOpD),
        .rs1_data_in(rd1D),
        .rs2_data_in(rd2D),
        .imm_ext_in(imm_extD),
        .rd_in(rdD),
        .rs1_in(rs1D),
        .rs2_in(rs2D),
        .funct3_in(funct3D),
        .funct7_in(funct7D),
        .pc_plus4D_in(pc_plus4D),
        .RegWrite_out(RegWriteE),
        .MemWrite_out(MemWriteE),
        .MemtoReg_out(MemtoRegE),
        .Branch_out(BranchE),
        .Jump_out(JumpE),
        .ALUSrc_out(ALUSrcE),
        .ALUOp_out(ALUOpE),
        .rs1_data_out(rs1_dataE),
        .rs2_data_out(rs2_dataE),
        .imm_ext_out(imm_extE),
        .rd_out(rdE),
        .rs1_out(rs1E),
        .rs2_out(rs2E),
        .funct3_out(funct3E),
        .funct7_out(funct7E),
        .pc_plus4E_out(pc_plus4E)
    );

    //  EXECUTE STAGE 
    wire [4:0] alu_ctrlE;
    wire [31:0] alu_operandA, alu_operandB, alu_operandB_pre, alu_resultE;
    wire zeroE, branch_takenE;

    aludec u_aludec (
        .funct3(funct3E),
        .funct7(funct7E),
        .ALUOp(ALUOpE),
        .alu_ctrl(alu_ctrlE)
    );

    wire [1:0] forwardA, forwardB;

    forwarding_unit u_forwarding (
        .ID_EX_rs1(rs1E),
        .ID_EX_rs2(rs2E),
        .EX_MEM_rd(rdM),
        .MEM_WB_rd(rdW),
        .EX_MEM_RegWrite(RegWriteM),
        .MEM_WB_RegWrite(RegWriteW),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    assign alu_operandA = (forwardA == 2'b10) ? alu_resultM :
                          (forwardA == 2'b01) ? wb_data :
                          rs1_dataE;

    assign alu_operandB_pre = (forwardB == 2'b10) ? alu_resultM :
                              (forwardB == 2'b01) ? wb_data :
                              rs2_dataE;

    assign alu_operandB = (ALUSrcE) ? imm_extE : alu_operandB_pre;

    rv32im_alu u_alu (
        .a(alu_operandA),
        .b(alu_operandB),
        .alu_ctrl(alu_ctrlE),
        .result(alu_resultE),
        .zero(zeroE)
    );

    branch_unit u_branch (
        .funct3(funct3E),
        .rs1(alu_operandA),
        .rs2(alu_operandB_pre),
        .branch_taken(branch_takenE)
    );

    wire [31:0] pc_branchE = pc_plus4E + imm_extE;

    //  EX/MEM PIPELINE 
    wire RegWriteM, MemWriteM, MemtoRegM, BranchM, JumpM;
    wire zeroM;
    wire [31:0] alu_resultM, write_dataM, pc_branchM, pc_plus4M;
    wire [4:0] rdM;

    EX_MEM u_ex_mem (
        .clk(clk),
        .reset(reset),
        .RegWrite_in(RegWriteE),
        .MemWrite_in(MemWriteE),
        .MemtoReg_in(MemtoRegE),
        .Branch_in(BranchE),
        .Jump_in(JumpE),
        .zero_in(zeroE),
        .alu_result_in(alu_resultE),
        .write_data_in(alu_operandB_pre),
        .rd_in(rdE),
        .pc_branch_in(pc_branchE),
        .pc_plus4E_in(pc_plus4E),
        .RegWrite_out(RegWriteM),
        .MemWrite_out(MemWriteM),
        .MemtoReg_out(MemtoRegM),
        .Branch_out(BranchM),
        .Jump_out(JumpM),
        .zero_out(zeroM),
        .alu_result_out(alu_resultM),
        .write_data_out(write_dataM),
        .rd_out(rdM),
        .pc_branch_out(pc_branchM),
        .pc_plus4M_out(pc_plus4M)
    );

    // MEMORY STAGE 
    wire [31:0] mem_read_data;
    dmem u_dmem (
        .clk(clk),
        .mem_write(MemWriteM),
        .addr(alu_resultM),
        .write_data(write_dataM),
        .read_data(mem_read_data)
    );

    //  MEM/WB PIPELINE 
    wire RegWriteW_internal, MemtoRegW;
    wire [31:0] read_dataW, alu_resultW, pc_plus4W;
    wire [4:0] rdW;

    MEM_WB u_mem_wb (
        .clk(clk),
        .reset(reset),
        .RegWrite_in(RegWriteM),
        .MemtoReg_in(MemtoRegM),
        .read_data_in(mem_read_data),
        .alu_result_in(alu_resultM),
        .rd_in(rdM),
        .pc_plus4M_in(pc_plus4M),
        .RegWrite_out(RegWriteW_internal),
        .MemtoReg_out(MemtoRegW),
        .read_data_out(read_dataW),
        .alu_result_out(alu_resultW),
        .rd_out(rdW),
        .pc_plus4W_out(pc_plus4W)
    );

    assign RegWriteW = RegWriteW_internal;

    // WRITEBACK STAGE
    wire [31:0] wb_data;
    result_mux u_result_mux (
        .alu_result(alu_resultW),
        .mem_data(read_dataW),
        .MemtoReg(MemtoRegW),
        .write_data(wb_data)
    );

    //  HAZARD UNIT 
    wire PCWrite_dummy, IF_ID_Write_dummy;
    wire control_stall_dummy, flush_if_id_dummy, flush_id_ex_dummy;

    hazard_unit u_hazard (
        .IF_ID_rs1(rs1D),
        .IF_ID_rs2(rs2D),
        .ID_EX_rd(rdE),
        .ID_EX_MemtoReg(MemtoRegE),
        .EX_MEM_Branch(BranchM),
        .EX_MEM_zero(zeroM),
        .PCWrite(PCWrite_dummy),
        .IF_ID_Write(IF_ID_Write_dummy),
        .control_stall(control_stall_dummy),
        .flush_if_id(flush_if_id_dummy),
        .flush_id_ex(flush_id_ex_dummy)
    );

    //  PC MUX 
    wire branch_takenM = BranchM & zeroM;

    pc_mux u_pc_mux (
        .pc_plus4(pc_plus4F),
        .pc_branch(pc_branchM),
        .pc_jump(pc_plus4F),
        .BranchTaken(branch_takenM),
        .Jump(JumpM),
        .next_pc(next_pc)
    );

endmodule

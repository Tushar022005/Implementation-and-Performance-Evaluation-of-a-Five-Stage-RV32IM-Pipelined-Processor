// 32-bit RISC-V ALU with Multiply/Divide support (RV32IM)

module rv32im_alu (
    input  wire [31:0] a,          // operand A
    input  wire [31:0] b,          // operand B
    input  wire [4:0]  alu_ctrl,   // ALU control signal
    output reg  [31:0] result,     // output result
    output wire         zero       // zero flag

);

    localparam ALU_ADD  = 5'b00000;
    localparam ALU_SUB  = 5'b00001;
    localparam ALU_AND  = 5'b00010;
    localparam ALU_OR   = 5'b00011;
    localparam ALU_XOR  = 5'b00100;
    localparam ALU_SLL  = 5'b00101;
    localparam ALU_SRL  = 5'b00110;
    localparam ALU_SLT  = 5'b00111;
    localparam ALU_MUL  = 5'b01000;
    localparam ALU_DIV  = 5'b01001;
    localparam ALU_REM  = 5'b01010;

    always @(*) begin
        case (alu_ctrl)
            ALU_ADD:  result = a + b;
            ALU_SUB:  result = a - b;
            ALU_AND:  result = a & b;
            ALU_OR:   result = a | b;
            ALU_XOR:  result = a ^ b;
            ALU_SLL:  result = a << b[4:0];
            ALU_SRL:  result = a >> b[4:0];
            ALU_SLT:  result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            ALU_MUL:  result = a * b;                           // lower 32 bits only
            ALU_DIV:  result = (b != 0) ? ($signed(a) / $signed(b)) : 32'hFFFFFFFF;
            ALU_REM:  result = (b != 0) ? ($signed(a) % $signed(b)) : 32'hFFFFFFFF;
            default:  result = 32'd0;
        endcase
    end

    assign zero = (result == 32'd0);

endmodule

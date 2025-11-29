// Program Counter
module pc (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] next_pc,     // input from pc_mux
    output reg  [31:0] pc_out       // current PC value
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 32'b0;         // start from address 0 on reset
        else
            pc_out <= next_pc;       // update PC on each clock
    end

endmodule

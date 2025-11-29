
// regfile.v  —  Register File

`timescale 1ns / 1ps

module regfile (
    input  wire         clk,
    input  wire         we3,          // Write enable
    input  wire  [4:0]  a1, a2, a3,   // Read reg1, Read reg2, Write reg
    input  wire  [31:0] wd3,          // Write data
    output wire  [31:0] rd1, rd2      // Read data outputs
);

    // 32 general-purpose 32-bit registers
    reg [31:0] rf [0:31];

    // Asynchronous read (read happens immediately)
    assign rd1 = (a1 != 0) ? rf[a1] : 32'b0;
    assign rd2 = (a2 != 0) ? rf[a2] : 32'b0;

    // Synchronous write (on rising edge)
    always @(posedge clk) begin
        if (we3 && (a3 != 0)) begin
            rf[a3] <= wd3;
        end
    end

    // for tb
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            rf[i] = 32'b0;
    end

endmodule

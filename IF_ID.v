// IF_ID.v
module IF_ID (
    input  wire        clk,
    input  wire        reset,       // active-high synchronous reset
    input  wire [31:0] pc_plus4F,   // PC+4 from fetch stage
    input  wire [31:0] instrF,      // instruction fetched
    output reg  [31:0] pc_plus4D,   // forwarded to decode
    output reg  [31:0] instrD       // forwarded to decode
);

    always @(posedge clk) begin
        if (reset) begin
            pc_plus4D <= 32'b0;
            instrD    <= 32'b0;
        end else begin
            pc_plus4D <= pc_plus4F;
            instrD    <= instrF;
        end
    end

endmodule

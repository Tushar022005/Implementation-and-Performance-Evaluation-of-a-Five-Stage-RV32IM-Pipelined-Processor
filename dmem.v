// Data Memory
module dmem (
    input  wire        clk,
    input  wire        mem_write,        // control signal
    input  wire [31:0] addr,             // address (from ALU)
    input  wire [31:0] write_data,       // data to write
    output wire [31:0] read_data         // data to read
);

    reg [31:0] memory [0:255];           

    // Memory write
    always @(posedge clk) begin
        if (mem_write)
            memory[addr[9:2]] <= write_data;
    end

    // Memory read 
    assign read_data = memory[addr[9:2]];

    // for tb
    initial begin
        memory[0] = 32'd10;
        memory[1] = 32'd20;
        memory[2] = 32'd30;
    end

endmodule

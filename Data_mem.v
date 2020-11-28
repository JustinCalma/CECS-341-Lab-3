`timescale 1ns / 1ps

// Module Definition
module DataMem(MemRead, MemWrite, addr, write_data, read_data);

    // Define I/O Ports
    input wire          MemRead;
    input wire          MemWrite;
    input wire [8:0]    addr;
    input      [31:0]   write_data;
    output reg [31:0]   read_data;
    reg [31:0]  memory [127:0];
    
    integer i;
    
    // Describe Data_mem Behavior
    initial
        begin
            read_data = 0;
            // Iterate through the 128 data
            for (i = 0; i < 128; i = i + 1) begin
                memory[i] = i; 
            end
        end
    always @(*)
        begin
            // If MemWrite is true 
            if(MemWrite)
                // Overwrite the current data with the new data
                memory[addr] = write_data;
            // If MemRead is true
            if(MemRead)
                // Save and read the data at the current address
                read_data = memory[addr];
        end
endmodule   // Data_mem
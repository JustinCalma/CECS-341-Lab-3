`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2020 10:11:51 AM
// Design Name: 
// Module Name: RegFile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Module definition
module RegFile(
               clk, reset, rg_wrt_en,   // 1 - bit each
               rg_wrt_addr,             // 5 - bits
               rg_rd_addr1,             // 5 - bits
               rg_rd_addr2,             // 5 - bits
               rg_wrt_data,             // 32 - bits
               rg_rd_data1,             // 32 - bits
               rg_rd_data2              // 32 - bits
               );

    // Define the I/O Signals
    input                   clk;
    input                   reset;
    input                   rg_wrt_en;
    input       [4:0]       rg_wrt_addr;
    input       [4:0]       rg_rd_addr1;
    input       [4:0]       rg_rd_addr2;
    input       [31:0]      rg_wrt_data;
    output      [31:0]      rg_rd_data1;
    output      [31:0]      rg_rd_data2;
    
    // Define the Register File module's behavior    
    reg [31:0] register_file [31:0];
    assign rg_rd_data1 = register_file[rg_rd_addr1];
    assign rg_rd_data2 = register_file[rg_rd_addr2];
    integer i;
    
    // Always @ positive edge of clock or on reset
    always @(posedge clk or reset) begin // Always@
    
        // If reset signal is 1
        if (reset == 1'b1) begin // If
        
            // Set all registers to be 32'b0
            for (i = 0; i < 32; i = i + 1)
                register_file[i] <= 0;           
                
        // Else if, reset signal is 0 and register write signal is 1
        end else if (rg_wrt_en == 1'b1) begin // Else if
        
                //Set all registers to 0
                for (i = 0; i < 32; i = i + 1)
                    register_file[i] <= 0;
                
                // Write the value into the register
                register_file[rg_wrt_addr] <= rg_wrt_data;   
                   
        end // If
    end // Always@

endmodule // RegFile

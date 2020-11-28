`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2020 10:11:51 AM
// Design Name: 
// Module Name: FlipFlop
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

// Module Definition
module FlipFlop(
                clk, reset, // 1-bit each
                d,          // 8-bit
                q           // 8-bit 
                );

    // Define the I/O Signals
    input [7:0] d;          // Input
    input clk;              // Input
    input reset;    
    output reg [7:0] q;     // Output 
    
    // Always at the positive edge of clock
    always @(posedge clk) begin // Start
    
        // If reset is active, set output to 0
        if (reset == 1'b1) 
            q = 8'b00000000;
            
        // Else, set the output to be the input value
        else
            q = d;
    end // End
    
endmodule // FlipFlop

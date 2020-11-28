`timescale 1ns / 1ps

// Module Definition
module MUX21(
             D1, D2, S, Y
            );
            
    // Define the I/O Signals
    input            S;      // Select Line
    input   [31:0]  D1;
    input   [31:0]  D2;
    
    output  [31:0]   Y;
    
    // Assign the value of Y and determine 
    // if the writing data should come from
    // ALU or Data Memory
    assign Y = (!S & D1) | (S & D2);
    
endmodule   // Mux21

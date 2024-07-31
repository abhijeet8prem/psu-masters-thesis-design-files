`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Portland State University
// Engineer: Abhijeet Prem
// 
// Create Date: 06/22/2022 10:06:05 AM
// Design Name: 
// Module Name: clock_scaler
// Project Name: cascaded converter
// Description: 
//
// 
//
// Additional Comments:
// Based on script wiritten by Wiwin H.
//////////////////////////////////////////////////////////////////////////////////

module clock_scaler(
    input   wire    clk_in,                                 // input clock signal
    output  reg     clk_scaled_out                          // output clock signal
    );

    reg [15:0] counter;                                         // counter variable to count higher
    parameter DIVISOR = 16'd6250;                               // New clock freq = 125MHz/DIVISOR ( 125MHz for PYNQ board)

    always @(posedge clk_in)
    begin
        counter <= counter + 16'd1;                             // incrementing the counter
        if(counter >= (DIVISOR-1))                              // checking if the counter has reached the prescalar value
            counter <= 16'd0;                                   // resetting the counter
            
        clk_scaled_out <= (counter < DIVISOR/2)? 1'b1 : 1'b0;   // conition for the outputting the value.   
    end
    
endmodule
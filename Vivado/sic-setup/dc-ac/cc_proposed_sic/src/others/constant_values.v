`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////
// constant_values.v - A module for pluggign with constant values
//
// Author:	        Abhijeet Prem (abhij@pdx.edu)
// Version:         1.0
// Last Modified:	10-NOv-2022
//
// Description:
// ------------
// This module provies the contatnt values for the DC Buck/Boost module
//
// Note:  
////////////////////////////////////////////////////////////////

module constant_values
#(
     parameter SIZE = 13,                           // determines the width of the constants
     parameter OFSET_T  = 0, DTY_T = 0,             // offset and duty parametrs for the top switch
     parameter OFSET_A1 = 0, DTY_A1 = 0,            // offset and duty parametrs for the mid switch signal 1
     parameter OFSET_A2 = 0, DTY_A2 = 0,            // offset and duty parametrs for the mid switch signal 2
     parameter OFSET_B1 = 0, DTY_B1 = 0,            // offset and duty parametrs for the bottom switch signal 1
     parameter OFSET_B2 = 0, DTY_B2 = 0             // offset and duty parametrs for the bottom switch signal 2
)
(
    output wire [SIZE-1:0]  offset_t, duty_t,       // duty and offset ratios for the pwm block 
    output wire [SIZE-1:0]  offset_a1, duty_a1,     // duty and offset ratios for the pwm block
    output wire [SIZE-1:0]  offset_a2, duty_a2,     // duty and offset ratios for the pwm block
    output wire [SIZE-1:0]  offset_b1, duty_b1,     // duty and offset ratios for the pwm block
    output wire [SIZE-1:0]  offset_b2, duty_b2      // duty and offset ratios for the pwm block   
);

// assing parametes to the outputs
assign  offset_t 	= OFSET_T;
assign  offset_a1 	= OFSET_A1;
assign  offset_a2 	= OFSET_A2;
assign  offset_b1 	= OFSET_B1;
assign  offset_b2 	= OFSET_B2;
assign  duty_t 		= DTY_T;
assign  duty_a1 	= DTY_A1;
assign  duty_a2 	= DTY_A2;
assign  duty_b1 	= DTY_B1;
assign  duty_b2 	= DTY_B2;

endmodule

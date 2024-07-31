`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////
// constant_values.v - A module for pluggign with constant values
//
// Author:	        Abhijeet Prem (abhij@pdx.edu)
// Version:         1.1
// Last Modified:	Dec-11-2022
//
// Description:
// ------------
// This module provies the contatnt values for the DC-DC proposed buck operation
//
// Note:  
////////////////////////////////////////////////////////////////

module dc_dc_buck_prop_const
#(
     parameter SIZE = 13,               // determines the width of the constants
     parameter DS = 0, DL = 0,                  // duty parametrs for the top switchs 
     parameter DT = 0,                      // Generic deadtime
     parameter OL = 0,                      // Generic overlap time
     parameter DC = 0,                      // Duty for changing the tiny cap
     parameter DD = 0,                      // Duty for dischanging the tiny cap
     parameter OFF_S_A1 = 0,
     parameter OFF_L_A1 = 0,
     parameter OFF_S_B1 = 0,
     parameter OFF_L_B1 = 0,
     parameter D_L_A1   = 0

)
(
    // signals PWM modules
    output wire [SIZE-1:0]  offset_s_t,  duty_s_t,      // duty and offset ratios for the source pwm block 
    output wire [SIZE-1:0]  offset_s_a1, duty_s_a1,     // duty and offset ratios for the source pwm block
    output wire [SIZE-1:0]  offset_s_a2, duty_s_a2,     // duty and offset ratios for the source pwm block
    output wire [SIZE-1:0]  offset_s_b1, duty_s_b1,     // duty and offset ratios for the source pwm block
    output wire [SIZE-1:0]  offset_s_b2, duty_s_b2,      // duty and offset ratios for the source pwm block
    
    output wire [SIZE-1:0]  offset_l_t,  duty_l_t,      // duty and offset ratios for the load pwm block 
    output wire [SIZE-1:0]  offset_l_a1, duty_l_a1,     // duty and offset ratios for the load pwm block
    output wire [SIZE-1:0]  offset_l_a2, duty_l_a2,     // duty and offset ratios for the load pwm block
    output wire [SIZE-1:0]  offset_l_b1, duty_l_b1,     // duty and offset ratios for the load pwm block
    output wire [SIZE-1:0]  offset_l_b2, duty_l_b2      // duty and offset ratios for the load pwm block    
);

// assing values to the source pwm signals
assign  offset_s_t 	    = OL + DC + DT;
assign  offset_s_a1 	= OFF_S_A1;
assign  offset_s_a2 	= OL + DC + DT + DS + DT;
assign  offset_s_b1 	= OFF_S_B1;
assign  offset_s_b2 	= OL + DC + DT + DS + DT + DD;
assign  duty_s_t 		= DS;
assign  duty_s_a1 	    = OL + DC;
assign  duty_s_a2 	    = DD + OL;
assign  duty_s_b1 	    = OL;
assign  duty_s_b2 	    = (2**SIZE) - (OL + DC + DT + DS + DT + DD);

// assing values to the load pwm signals
assign  offset_l_t 	    = OL + DC + DT + DS + DT - DL;
assign  offset_l_a1 	= OFF_L_A1;
assign  offset_l_a2 	= OL + DC + DT + DS;
assign  offset_l_b1 	= OFF_L_B1;
assign  offset_l_b2 	= OL + DC + DT + DS + DT + DD + DT;
assign  duty_l_t 		= DL;
assign  duty_l_a1 	    = D_L_A1;
assign  duty_l_a2 	    = OL + DD;
assign  duty_l_b1 	    = OL + DC + DT + DS - DL ;
assign  duty_l_b2 	    = (2**SIZE) - (OL + DC + DT + DS + DT + DD + OL);

endmodule

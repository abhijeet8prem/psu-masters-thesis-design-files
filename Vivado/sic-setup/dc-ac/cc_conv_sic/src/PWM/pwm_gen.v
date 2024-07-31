`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// pwm_gen.sv - A template module to generate PWM signlas for the half bridge
//
// Author:	        Abhijeet Prem (abhij@pdx.edu)
// Version:         1.1
// Last Modified:	8-Nov-2022
// 
// Revision log:
// -------------
//    Version              Date                 Description
//    -------              ----                 -----------  
//      1.0             18-July-2022        Had instantiaded three blocks to generate the three sognals to one of the switch.
//                                          This desigen will fail when there is offset on the top switch and the other signal 
//                                          has multiple pulses in one frame
// 
//      1.1              8-Nov-2022
//
//		1.2				 10-June-2024	 	Deleating unwanted sections of the code             
//
// Description:
// ------------
// The modules instantiates the PWM blocks to generate 3 different PWM singls pwm signals 
// for the control unit. 
//
// Note:  This module incoperates the PWM module provide by Dr. Gupta 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module pwm_gen
#(
    parameter WIDTH = 13                                        // User input for the width of 
)
// define the input and output signals for the module
(
    input  wire             clk_in,                               // clock input clock signal
    input  wire [WIDTH-1:0] offset_T,duty_T,                      // ofset and duty values for top switch
    input  wire [WIDTH-1:0] offset_A1, duty_A1,                   // ofset and duty values for middle switch
    input  wire [WIDTH-1:0] offset_A2, duty_A2,                   // ofset and duty values for middle switch
    input  wire [WIDTH-1:0] offset_B1, duty_B1,                   // ofset and duty values for bottom clk_in
    input  wire [WIDTH-1:0] offset_B2, duty_B2,                   // ofset and duty values for bottom clk_in
    output wire             PWM_T,PWM_A,PWM_B                     // PWM output signals for the Top, Mid and Bottom switches 
 );
 
 // internal wires
 wire PWM_A1, PWM_A2, PWM_B1, PWM_B2;
 
// instantiating instance of the PWM generator block for Top switch 
    pwm_generator #(.WIDTH_P(WIDTH)) pwm_mod_t                     
    (
        .clk_in(clk_in),
        .offset(offset_T),
        .duty(duty_T),
        .pwm_out(PWM_T)
    );
    
    
    // instantiating instance of the PWM generator blocks for Middle switch
    pwm_generator #(.WIDTH_P(WIDTH)) pwm_mod_a1
    (
        .clk_in(clk_in),
        .offset(offset_A1),
        .duty(duty_A1),
        .pwm_out(PWM_A1)
    );
    
    pwm_generator #(.WIDTH_P(WIDTH)) pwm_mod_a2
    (
        .clk_in(clk_in),
        .offset(offset_A2),
        .duty(duty_A2),
        .pwm_out(PWM_A2)
    );
    
    // instantiating instance of the PWM generator blocks for Bottom switch
    pwm_generator #(.WIDTH_P(WIDTH)) pwm_mod_b1
    (
        .clk_in(clk_in),
        .offset(offset_B1),
        .duty(duty_B1),
        .pwm_out(PWM_B1)
    );
    
    pwm_generator #(.WIDTH_P(WIDTH)) pwm_mod_b2
    (
        .clk_in(clk_in),
        .offset(offset_B2),
        .duty(duty_B2),
        .pwm_out(PWM_B2)
    );
    
    or(PWM_A, PWM_A1, PWM_A2);          // merging PWM_A1 and PWM_A2 outputs together 
    or(PWM_B, PWM_B1, PWM_B2);          // merging PWM_B1 and PWM_B2 outputs together
  
 

endmodule

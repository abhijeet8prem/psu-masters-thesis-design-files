`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// LUT_ph_a.v - A module to generate the Duty ratios for the PWM block
//
// Author:	        Abhijeet Prem (abhij@pdx.edu)
// Version:         1.4
// Last Modified:	18-July-2022
// next modified:   16-Feb-2023
//
// Rivision details:
// ----------------
//  Version No      Date                                    Comment
//      1.0      18-July-2022       The inital code was created read from the text files and provide each value to the PWM block
//      1.1      2nd-Nov-2022       
//      1.2      11-Nov-2022        split the bottom signal into two and generating that pwm signals
//      1.3      14-Nov-2022        added the lut values and able to generate the output
//      1.4     16-Feb-2023         The DC componet was missing in a couple of offset values for the top switch, added that
//
// Description:
// -----------
//      o   This moduele read a bunch of text files that contains the duty ratos for Space Vector Moduluation.
//      o   Each of the duty values are stored into a 2d memory array
//      o   Offsets values for the signals are calculate
//      o   On every positive edge of the clock, a vaule from the memory is read and send out
//  
//  File discreption:
//  ----------------
//      "pwm_phase_a_dty_t.txt"         : Has the duty ratios for the top switch
//      "pwm_phase_a_dty_t_off.txt"     : Has the offset duty ratios for the top switch

//      "pwm_phase_a_dty_a.txt"         : Has the duty ratios for the middle switch
//      "pwm_phase_a_dty_a_off.txt"     : Has the offset duty ratios for the middle switch
//      "pwm_phase_a_dty_b.txt"         : Has the duty ratios for the bottom switch
//      "pwm_phase_a_dty_b_off.txt"     : Has the offset duty ratios for the bottom switch
//      
//      Make sure to include all these files into the project
//
// Note:  The moudle is written based on the code proived by Wiwin H
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module LUT_ph_a
    #(  parameter WIDTH = 13,                               // User input for PWM resulution
        parameter SIZE = 264,                               // USER INPUT for number of samples
        parameter DTIME = 20,                               // user defiend dead time ~ 160ns
        parameter DC    = 137,                              // user defined DC value, defaults to 1.1us
        parameter DD    = 137,                              // user defined DC value, defaults to 1.1us
        parameter OL    = 20,                               // user defined DC value, defaults to 160ns
        parameter S    = 0                                 // user defined DC value, defaults to 120ns
     )                               
     (    
        input  wire              clk_in,                    // input clock signal from the clock scalar                            
        output reg [WIDTH-1:0]  offset_t, duty_t,          // duty and offset ratios for the pwm block 
        output reg [WIDTH-1:0]  offset_a1, duty_a1,        // duty and offset ratios for the pwm block
        output reg [WIDTH-1:0]  offset_a2, duty_a2,        // duty and offset ratios for the pwm block
        output reg [WIDTH-1:0]  offset_b1, duty_b1,        // duty and offset ratios for the pwm block
        output reg [WIDTH-1:0]  offset_b2, duty_b2         // duty and offset ratios for the pwm block    
     );
    
     
    
    reg [WIDTH-1:0] rom_mem_dty_t       [0:SIZE-1];          // 2D memeory array to store duty ratios for the top switch signal
    reg [WIDTH-1:0] rom_mem_dty_t_off   [0:SIZE-1];          // 2D memeory array to store offset values for the top switch signal
    //reg [WIDTH-1:0] rom_mem_dty_a       [0:SIZE-1];          // 2D memeory array to store duty ratios for the middle switch signal  
    //reg [WIDTH-1:0] rom_mem_dty_a_off   [0:SIZE-1];          // 2D memeory array to store offset values for the middle switch signal
    
    integer         count = 0;                                // varible for counting
      
    // initial block, non-synthesizable
    initial begin

       count = 0; 

//////////////// TOP SWITCH DUTY /////////////////////////////////

  		rom_mem_dty_t[0] = 13'd5222;
		rom_mem_dty_t[1] = 13'd5292;
		rom_mem_dty_t[2] = 13'd5360;
		rom_mem_dty_t[3] = 13'd5424;
		rom_mem_dty_t[4] = 13'd5486;
		rom_mem_dty_t[5] = 13'd5544;
		rom_mem_dty_t[6] = 13'd5599;
		rom_mem_dty_t[7] = 13'd5651;
		rom_mem_dty_t[8] = 13'd5700;
		rom_mem_dty_t[9] = 13'd5745;
		rom_mem_dty_t[10] = 13'd5787;
		rom_mem_dty_t[11] = 13'd5826;
		rom_mem_dty_t[12] = 13'd5861;
		rom_mem_dty_t[13] = 13'd5894;
		rom_mem_dty_t[14] = 13'd5922;
		rom_mem_dty_t[15] = 13'd5948;
		rom_mem_dty_t[16] = 13'd5970;
		rom_mem_dty_t[17] = 13'd5988;
		rom_mem_dty_t[18] = 13'd6003;
		rom_mem_dty_t[19] = 13'd6015;
		rom_mem_dty_t[20] = 13'd6023;
		rom_mem_dty_t[21] = 13'd6028;
		rom_mem_dty_t[22] = 13'd6030;
		rom_mem_dty_t[23] = 13'd6028;
		rom_mem_dty_t[24] = 13'd6022;
		rom_mem_dty_t[25] = 13'd6013;
		rom_mem_dty_t[26] = 13'd6001;
		rom_mem_dty_t[27] = 13'd5985;
		rom_mem_dty_t[28] = 13'd5966;
		rom_mem_dty_t[29] = 13'd5944;
		rom_mem_dty_t[30] = 13'd5918;
		rom_mem_dty_t[31] = 13'd5888;
		rom_mem_dty_t[32] = 13'd5856;
		rom_mem_dty_t[33] = 13'd5820;
		rom_mem_dty_t[34] = 13'd5780;
		rom_mem_dty_t[35] = 13'd5738;
		rom_mem_dty_t[36] = 13'd5692;
		rom_mem_dty_t[37] = 13'd5643;
		rom_mem_dty_t[38] = 13'd5590;
		rom_mem_dty_t[39] = 13'd5535;
		rom_mem_dty_t[40] = 13'd5476;
		rom_mem_dty_t[41] = 13'd5414;
		rom_mem_dty_t[42] = 13'd5349;
		rom_mem_dty_t[43] = 13'd5281;
		rom_mem_dty_t[44] = 13'd5210;
		rom_mem_dty_t[45] = 13'd5136;
		rom_mem_dty_t[46] = 13'd5059;
		rom_mem_dty_t[47] = 13'd4979;
		rom_mem_dty_t[48] = 13'd4896;
		rom_mem_dty_t[49] = 13'd4811;
		rom_mem_dty_t[50] = 13'd4723;
		rom_mem_dty_t[51] = 13'd4632;
		rom_mem_dty_t[52] = 13'd4538;
		rom_mem_dty_t[53] = 13'd4442;
		rom_mem_dty_t[54] = 13'd4343;
		rom_mem_dty_t[55] = 13'd4242;
		rom_mem_dty_t[56] = 13'd4139;
		rom_mem_dty_t[57] = 13'd4033;
		rom_mem_dty_t[58] = 13'd3925;
		rom_mem_dty_t[59] = 13'd3814;
		rom_mem_dty_t[60] = 13'd3701;
		rom_mem_dty_t[61] = 13'd3587;
		rom_mem_dty_t[62] = 13'd3470;
		rom_mem_dty_t[63] = 13'd3351;
		rom_mem_dty_t[64] = 13'd3230;
		rom_mem_dty_t[65] = 13'd3108;
		rom_mem_dty_t[66] = 13'd2983;
		rom_mem_dty_t[67] = 13'd2857;
		rom_mem_dty_t[68] = 13'd2730;
		rom_mem_dty_t[69] = 13'd2600;
		rom_mem_dty_t[70] = 13'd2470;
		rom_mem_dty_t[71] = 13'd2338;
		rom_mem_dty_t[72] = 13'd2204;
		rom_mem_dty_t[73] = 13'd2070;
		rom_mem_dty_t[74] = 13'd1934;
		rom_mem_dty_t[75] = 13'd1797;
		rom_mem_dty_t[76] = 13'd1659;
		rom_mem_dty_t[77] = 13'd1520;
		rom_mem_dty_t[78] = 13'd1380;
		rom_mem_dty_t[79] = 13'd1239;
		rom_mem_dty_t[80] = 13'd1098;
		rom_mem_dty_t[81] = 13'd956;
		rom_mem_dty_t[82] = 13'd813;
		rom_mem_dty_t[83] = 13'd670;
		rom_mem_dty_t[84] = 13'd527;
		rom_mem_dty_t[85] = 13'd383;
		rom_mem_dty_t[86] = 13'd240;
		rom_mem_dty_t[87] = 13'd96;
		rom_mem_dty_t[88] = 13'd0;
		rom_mem_dty_t[89] = 13'd0;
		rom_mem_dty_t[90] = 13'd0;
		rom_mem_dty_t[91] = 13'd0;
		rom_mem_dty_t[92] = 13'd0;
		rom_mem_dty_t[93] = 13'd0;
		rom_mem_dty_t[94] = 13'd0;
		rom_mem_dty_t[95] = 13'd0;
		rom_mem_dty_t[96] = 13'd0;
		rom_mem_dty_t[97] = 13'd0;
		rom_mem_dty_t[98] = 13'd0;
		rom_mem_dty_t[99] = 13'd0;
		rom_mem_dty_t[100] = 13'd0;
		rom_mem_dty_t[101] = 13'd0;
		rom_mem_dty_t[102] = 13'd0;
		rom_mem_dty_t[103] = 13'd0;
		rom_mem_dty_t[104] = 13'd0;
		rom_mem_dty_t[105] = 13'd0;
		rom_mem_dty_t[106] = 13'd0;
		rom_mem_dty_t[107] = 13'd0;
		rom_mem_dty_t[108] = 13'd0;
		rom_mem_dty_t[109] = 13'd0;
		rom_mem_dty_t[110] = 13'd0;
		rom_mem_dty_t[111] = 13'd0;
		rom_mem_dty_t[112] = 13'd0;
		rom_mem_dty_t[113] = 13'd0;
		rom_mem_dty_t[114] = 13'd0;
		rom_mem_dty_t[115] = 13'd0;
		rom_mem_dty_t[116] = 13'd0;
		rom_mem_dty_t[117] = 13'd0;
		rom_mem_dty_t[118] = 13'd0;
		rom_mem_dty_t[119] = 13'd0;
		rom_mem_dty_t[120] = 13'd0;
		rom_mem_dty_t[121] = 13'd0;
		rom_mem_dty_t[122] = 13'd0;
		rom_mem_dty_t[123] = 13'd0;
		rom_mem_dty_t[124] = 13'd0;
		rom_mem_dty_t[125] = 13'd0;
		rom_mem_dty_t[126] = 13'd0;
		rom_mem_dty_t[127] = 13'd0;
		rom_mem_dty_t[128] = 13'd0;
		rom_mem_dty_t[129] = 13'd0;
		rom_mem_dty_t[130] = 13'd0;
		rom_mem_dty_t[131] = 13'd0;
		rom_mem_dty_t[132] = 13'd0;
		rom_mem_dty_t[133] = 13'd0;
		rom_mem_dty_t[134] = 13'd0;
		rom_mem_dty_t[135] = 13'd0;
		rom_mem_dty_t[136] = 13'd0;
		rom_mem_dty_t[137] = 13'd0;
		rom_mem_dty_t[138] = 13'd0;
		rom_mem_dty_t[139] = 13'd0;
		rom_mem_dty_t[140] = 13'd0;
		rom_mem_dty_t[141] = 13'd0;
		rom_mem_dty_t[142] = 13'd0;
		rom_mem_dty_t[143] = 13'd0;
		rom_mem_dty_t[144] = 13'd0;
		rom_mem_dty_t[145] = 13'd0;
		rom_mem_dty_t[146] = 13'd0;
		rom_mem_dty_t[147] = 13'd0;
		rom_mem_dty_t[148] = 13'd0;
		rom_mem_dty_t[149] = 13'd0;
		rom_mem_dty_t[150] = 13'd0;
		rom_mem_dty_t[151] = 13'd0;
		rom_mem_dty_t[152] = 13'd0;
		rom_mem_dty_t[153] = 13'd0;
		rom_mem_dty_t[154] = 13'd0;
		rom_mem_dty_t[155] = 13'd0;
		rom_mem_dty_t[156] = 13'd0;
		rom_mem_dty_t[157] = 13'd0;
		rom_mem_dty_t[158] = 13'd0;
		rom_mem_dty_t[159] = 13'd0;
		rom_mem_dty_t[160] = 13'd0;
		rom_mem_dty_t[161] = 13'd0;
		rom_mem_dty_t[162] = 13'd0;
		rom_mem_dty_t[163] = 13'd0;
		rom_mem_dty_t[164] = 13'd0;
		rom_mem_dty_t[165] = 13'd0;
		rom_mem_dty_t[166] = 13'd0;
		rom_mem_dty_t[167] = 13'd0;
		rom_mem_dty_t[168] = 13'd0;
		rom_mem_dty_t[169] = 13'd0;
		rom_mem_dty_t[170] = 13'd0;
		rom_mem_dty_t[171] = 13'd0;
		rom_mem_dty_t[172] = 13'd0;
		rom_mem_dty_t[173] = 13'd0;
		rom_mem_dty_t[174] = 13'd0;
		rom_mem_dty_t[175] = 13'd0;
		rom_mem_dty_t[176] = 13'd96;
		rom_mem_dty_t[177] = 13'd240;
		rom_mem_dty_t[178] = 13'd383;
		rom_mem_dty_t[179] = 13'd527;
		rom_mem_dty_t[180] = 13'd670;
		rom_mem_dty_t[181] = 13'd813;
		rom_mem_dty_t[182] = 13'd956;
		rom_mem_dty_t[183] = 13'd1098;
		rom_mem_dty_t[184] = 13'd1239;
		rom_mem_dty_t[185] = 13'd1380;
		rom_mem_dty_t[186] = 13'd1520;
		rom_mem_dty_t[187] = 13'd1659;
		rom_mem_dty_t[188] = 13'd1797;
		rom_mem_dty_t[189] = 13'd1934;
		rom_mem_dty_t[190] = 13'd2070;
		rom_mem_dty_t[191] = 13'd2204;
		rom_mem_dty_t[192] = 13'd2338;
		rom_mem_dty_t[193] = 13'd2470;
		rom_mem_dty_t[194] = 13'd2600;
		rom_mem_dty_t[195] = 13'd2730;
		rom_mem_dty_t[196] = 13'd2857;
		rom_mem_dty_t[197] = 13'd2983;
		rom_mem_dty_t[198] = 13'd3108;
		rom_mem_dty_t[199] = 13'd3230;
		rom_mem_dty_t[200] = 13'd3351;
		rom_mem_dty_t[201] = 13'd3470;
		rom_mem_dty_t[202] = 13'd3587;
		rom_mem_dty_t[203] = 13'd3701;
		rom_mem_dty_t[204] = 13'd3814;
		rom_mem_dty_t[205] = 13'd3925;
		rom_mem_dty_t[206] = 13'd4033;
		rom_mem_dty_t[207] = 13'd4139;
		rom_mem_dty_t[208] = 13'd4242;
		rom_mem_dty_t[209] = 13'd4343;
		rom_mem_dty_t[210] = 13'd4442;
		rom_mem_dty_t[211] = 13'd4538;
		rom_mem_dty_t[212] = 13'd4632;
		rom_mem_dty_t[213] = 13'd4723;
		rom_mem_dty_t[214] = 13'd4811;
		rom_mem_dty_t[215] = 13'd4896;
		rom_mem_dty_t[216] = 13'd4979;
		rom_mem_dty_t[217] = 13'd5059;
		rom_mem_dty_t[218] = 13'd5136;
		rom_mem_dty_t[219] = 13'd5210;
		rom_mem_dty_t[220] = 13'd5281;
		rom_mem_dty_t[221] = 13'd5349;
		rom_mem_dty_t[222] = 13'd5414;
		rom_mem_dty_t[223] = 13'd5476;
		rom_mem_dty_t[224] = 13'd5535;
		rom_mem_dty_t[225] = 13'd5590;
		rom_mem_dty_t[226] = 13'd5643;
		rom_mem_dty_t[227] = 13'd5692;
		rom_mem_dty_t[228] = 13'd5738;
		rom_mem_dty_t[229] = 13'd5780;
		rom_mem_dty_t[230] = 13'd5820;
		rom_mem_dty_t[231] = 13'd5856;
		rom_mem_dty_t[232] = 13'd5888;
		rom_mem_dty_t[233] = 13'd5918;
		rom_mem_dty_t[234] = 13'd5944;
		rom_mem_dty_t[235] = 13'd5966;
		rom_mem_dty_t[236] = 13'd5985;
		rom_mem_dty_t[237] = 13'd6001;
		rom_mem_dty_t[238] = 13'd6013;
		rom_mem_dty_t[239] = 13'd6022;
		rom_mem_dty_t[240] = 13'd6028;
		rom_mem_dty_t[241] = 13'd6030;
		rom_mem_dty_t[242] = 13'd6028;
		rom_mem_dty_t[243] = 13'd6023;
		rom_mem_dty_t[244] = 13'd6015;
		rom_mem_dty_t[245] = 13'd6003;
		rom_mem_dty_t[246] = 13'd5988;
		rom_mem_dty_t[247] = 13'd5970;
		rom_mem_dty_t[248] = 13'd5948;
		rom_mem_dty_t[249] = 13'd5922;
		rom_mem_dty_t[250] = 13'd5894;
		rom_mem_dty_t[251] = 13'd5861;
		rom_mem_dty_t[252] = 13'd5826;
		rom_mem_dty_t[253] = 13'd5787;
		rom_mem_dty_t[254] = 13'd5745;
		rom_mem_dty_t[255] = 13'd5700;
		rom_mem_dty_t[256] = 13'd5651;
		rom_mem_dty_t[257] = 13'd5599;
		rom_mem_dty_t[258] = 13'd5544;
		rom_mem_dty_t[259] = 13'd5486;
		rom_mem_dty_t[260] = 13'd5424;
		rom_mem_dty_t[261] = 13'd5360;
		rom_mem_dty_t[262] = 13'd5292;
		rom_mem_dty_t[263] = 13'd5222;

    
    
//////////////// TOP SWITCH OFFSET /////////////////////////////////
        
        rom_mem_dty_t_off[0] = 13'd19;
		rom_mem_dty_t_off[1] = 13'd19;
		rom_mem_dty_t_off[2] = 13'd19;
		rom_mem_dty_t_off[3] = 13'd19;
		rom_mem_dty_t_off[4] = 13'd19;
		rom_mem_dty_t_off[5] = 13'd19;
		rom_mem_dty_t_off[6] = 13'd19;
		rom_mem_dty_t_off[7] = 13'd19;
		rom_mem_dty_t_off[8] = 13'd19;
		rom_mem_dty_t_off[9] = 13'd19;
		rom_mem_dty_t_off[10] = 13'd19;
		rom_mem_dty_t_off[11] = 13'd19;
		rom_mem_dty_t_off[12] = 13'd19;
		rom_mem_dty_t_off[13] = 13'd19;
		rom_mem_dty_t_off[14] = 13'd19;
		rom_mem_dty_t_off[15] = 13'd19;
		rom_mem_dty_t_off[16] = 13'd19;
		rom_mem_dty_t_off[17] = 13'd19;
		rom_mem_dty_t_off[18] = 13'd19;
		rom_mem_dty_t_off[19] = 13'd19;
		rom_mem_dty_t_off[20] = 13'd19;
		rom_mem_dty_t_off[21] = 13'd19;
		rom_mem_dty_t_off[22] = 13'd19;
		rom_mem_dty_t_off[23] = 13'd19;
		rom_mem_dty_t_off[24] = 13'd19;
		rom_mem_dty_t_off[25] = 13'd19;
		rom_mem_dty_t_off[26] = 13'd19;
		rom_mem_dty_t_off[27] = 13'd19;
		rom_mem_dty_t_off[28] = 13'd19;
		rom_mem_dty_t_off[29] = 13'd19;
		rom_mem_dty_t_off[30] = 13'd19;
		rom_mem_dty_t_off[31] = 13'd19;
		rom_mem_dty_t_off[32] = 13'd19;
		rom_mem_dty_t_off[33] = 13'd19;
		rom_mem_dty_t_off[34] = 13'd19;
		rom_mem_dty_t_off[35] = 13'd19;
		rom_mem_dty_t_off[36] = 13'd19;
		rom_mem_dty_t_off[37] = 13'd19;
		rom_mem_dty_t_off[38] = 13'd19;
		rom_mem_dty_t_off[39] = 13'd19;
		rom_mem_dty_t_off[40] = 13'd19;
		rom_mem_dty_t_off[41] = 13'd19;
		rom_mem_dty_t_off[42] = 13'd19;
		rom_mem_dty_t_off[43] = 13'd19;
		rom_mem_dty_t_off[44] = 13'd19;
		rom_mem_dty_t_off[45] = 13'd19;
		rom_mem_dty_t_off[46] = 13'd19;
		rom_mem_dty_t_off[47] = 13'd19;
		rom_mem_dty_t_off[48] = 13'd19;
		rom_mem_dty_t_off[49] = 13'd19;
		rom_mem_dty_t_off[50] = 13'd19;
		rom_mem_dty_t_off[51] = 13'd19;
		rom_mem_dty_t_off[52] = 13'd19;
		rom_mem_dty_t_off[53] = 13'd19;
		rom_mem_dty_t_off[54] = 13'd19;
		rom_mem_dty_t_off[55] = 13'd19;
		rom_mem_dty_t_off[56] = 13'd19;
		rom_mem_dty_t_off[57] = 13'd19;
		rom_mem_dty_t_off[58] = 13'd19;
		rom_mem_dty_t_off[59] = 13'd19;
		rom_mem_dty_t_off[60] = 13'd19;
		rom_mem_dty_t_off[61] = 13'd19;
		rom_mem_dty_t_off[62] = 13'd19;
		rom_mem_dty_t_off[63] = 13'd19;
		rom_mem_dty_t_off[64] = 13'd19;
		rom_mem_dty_t_off[65] = 13'd19;
		rom_mem_dty_t_off[66] = 13'd3066;
		rom_mem_dty_t_off[67] = 13'd3189;
		rom_mem_dty_t_off[68] = 13'd3311;
		rom_mem_dty_t_off[69] = 13'd3431;
		rom_mem_dty_t_off[70] = 13'd3548;
		rom_mem_dty_t_off[71] = 13'd3664;
		rom_mem_dty_t_off[72] = 13'd3778;
		rom_mem_dty_t_off[73] = 13'd3890;
		rom_mem_dty_t_off[74] = 13'd3999;
		rom_mem_dty_t_off[75] = 13'd4106;
		rom_mem_dty_t_off[76] = 13'd4211;
		rom_mem_dty_t_off[77] = 13'd4313;
		rom_mem_dty_t_off[78] = 13'd4413;
		rom_mem_dty_t_off[79] = 13'd4511;
		rom_mem_dty_t_off[80] = 13'd4605;
		rom_mem_dty_t_off[81] = 13'd4698;
		rom_mem_dty_t_off[82] = 13'd4787;
		rom_mem_dty_t_off[83] = 13'd4874;
		rom_mem_dty_t_off[84] = 13'd4958;
		rom_mem_dty_t_off[85] = 13'd5039;
		rom_mem_dty_t_off[86] = 13'd5118;
		rom_mem_dty_t_off[87] = 13'd5193;
		rom_mem_dty_t_off[88] = 13'd0;
		rom_mem_dty_t_off[89] = 13'd0;
		rom_mem_dty_t_off[90] = 13'd0;
		rom_mem_dty_t_off[91] = 13'd0;
		rom_mem_dty_t_off[92] = 13'd0;
		rom_mem_dty_t_off[93] = 13'd0;
		rom_mem_dty_t_off[94] = 13'd0;
		rom_mem_dty_t_off[95] = 13'd0;
		rom_mem_dty_t_off[96] = 13'd0;
		rom_mem_dty_t_off[97] = 13'd0;
		rom_mem_dty_t_off[98] = 13'd0;
		rom_mem_dty_t_off[99] = 13'd0;
		rom_mem_dty_t_off[100] = 13'd0;
		rom_mem_dty_t_off[101] = 13'd0;
		rom_mem_dty_t_off[102] = 13'd0;
		rom_mem_dty_t_off[103] = 13'd0;
		rom_mem_dty_t_off[104] = 13'd0;
		rom_mem_dty_t_off[105] = 13'd0;
		rom_mem_dty_t_off[106] = 13'd0;
		rom_mem_dty_t_off[107] = 13'd0;
		rom_mem_dty_t_off[108] = 13'd0;
		rom_mem_dty_t_off[109] = 13'd0;
		rom_mem_dty_t_off[110] = 13'd0;
		rom_mem_dty_t_off[111] = 13'd0;
		rom_mem_dty_t_off[112] = 13'd0;
		rom_mem_dty_t_off[113] = 13'd0;
		rom_mem_dty_t_off[114] = 13'd0;
		rom_mem_dty_t_off[115] = 13'd0;
		rom_mem_dty_t_off[116] = 13'd0;
		rom_mem_dty_t_off[117] = 13'd0;
		rom_mem_dty_t_off[118] = 13'd0;
		rom_mem_dty_t_off[119] = 13'd0;
		rom_mem_dty_t_off[120] = 13'd0;
		rom_mem_dty_t_off[121] = 13'd0;
		rom_mem_dty_t_off[122] = 13'd0;
		rom_mem_dty_t_off[123] = 13'd0;
		rom_mem_dty_t_off[124] = 13'd0;
		rom_mem_dty_t_off[125] = 13'd0;
		rom_mem_dty_t_off[126] = 13'd0;
		rom_mem_dty_t_off[127] = 13'd0;
		rom_mem_dty_t_off[128] = 13'd0;
		rom_mem_dty_t_off[129] = 13'd0;
		rom_mem_dty_t_off[130] = 13'd0;
		rom_mem_dty_t_off[131] = 13'd0;
		rom_mem_dty_t_off[132] = 13'd0;
		rom_mem_dty_t_off[133] = 13'd0;
		rom_mem_dty_t_off[134] = 13'd0;
		rom_mem_dty_t_off[135] = 13'd0;
		rom_mem_dty_t_off[136] = 13'd0;
		rom_mem_dty_t_off[137] = 13'd0;
		rom_mem_dty_t_off[138] = 13'd0;
		rom_mem_dty_t_off[139] = 13'd0;
		rom_mem_dty_t_off[140] = 13'd0;
		rom_mem_dty_t_off[141] = 13'd0;
		rom_mem_dty_t_off[142] = 13'd0;
		rom_mem_dty_t_off[143] = 13'd0;
		rom_mem_dty_t_off[144] = 13'd0;
		rom_mem_dty_t_off[145] = 13'd0;
		rom_mem_dty_t_off[146] = 13'd0;
		rom_mem_dty_t_off[147] = 13'd0;
		rom_mem_dty_t_off[148] = 13'd0;
		rom_mem_dty_t_off[149] = 13'd0;
		rom_mem_dty_t_off[150] = 13'd0;
		rom_mem_dty_t_off[151] = 13'd0;
		rom_mem_dty_t_off[152] = 13'd0;
		rom_mem_dty_t_off[153] = 13'd0;
		rom_mem_dty_t_off[154] = 13'd0;
		rom_mem_dty_t_off[155] = 13'd0;
		rom_mem_dty_t_off[156] = 13'd0;
		rom_mem_dty_t_off[157] = 13'd0;
		rom_mem_dty_t_off[158] = 13'd0;
		rom_mem_dty_t_off[159] = 13'd0;
		rom_mem_dty_t_off[160] = 13'd0;
		rom_mem_dty_t_off[161] = 13'd0;
		rom_mem_dty_t_off[162] = 13'd0;
		rom_mem_dty_t_off[163] = 13'd0;
		rom_mem_dty_t_off[164] = 13'd0;
		rom_mem_dty_t_off[165] = 13'd0;
		rom_mem_dty_t_off[166] = 13'd0;
		rom_mem_dty_t_off[167] = 13'd0;
		rom_mem_dty_t_off[168] = 13'd0;
		rom_mem_dty_t_off[169] = 13'd0;
		rom_mem_dty_t_off[170] = 13'd0;
		rom_mem_dty_t_off[171] = 13'd0;
		rom_mem_dty_t_off[172] = 13'd0;
		rom_mem_dty_t_off[173] = 13'd0;
		rom_mem_dty_t_off[174] = 13'd0;
		rom_mem_dty_t_off[175] = 13'd0;
		rom_mem_dty_t_off[176] = 13'd5193;
		rom_mem_dty_t_off[177] = 13'd5118;
		rom_mem_dty_t_off[178] = 13'd5039;
		rom_mem_dty_t_off[179] = 13'd4958;
		rom_mem_dty_t_off[180] = 13'd4874;
		rom_mem_dty_t_off[181] = 13'd4787;
		rom_mem_dty_t_off[182] = 13'd4698;
		rom_mem_dty_t_off[183] = 13'd4605;
		rom_mem_dty_t_off[184] = 13'd4511;
		rom_mem_dty_t_off[185] = 13'd4413;
		rom_mem_dty_t_off[186] = 13'd4313;
		rom_mem_dty_t_off[187] = 13'd4211;
		rom_mem_dty_t_off[188] = 13'd4106;
		rom_mem_dty_t_off[189] = 13'd3999;
		rom_mem_dty_t_off[190] = 13'd3890;
		rom_mem_dty_t_off[191] = 13'd3778;
		rom_mem_dty_t_off[192] = 13'd3664;
		rom_mem_dty_t_off[193] = 13'd3548;
		rom_mem_dty_t_off[194] = 13'd3431;
		rom_mem_dty_t_off[195] = 13'd3311;
		rom_mem_dty_t_off[196] = 13'd3189;
		rom_mem_dty_t_off[197] = 13'd3066;
		rom_mem_dty_t_off[198] = 13'd19;
		rom_mem_dty_t_off[199] = 13'd19;
		rom_mem_dty_t_off[200] = 13'd19;
		rom_mem_dty_t_off[201] = 13'd19;
		rom_mem_dty_t_off[202] = 13'd19;
		rom_mem_dty_t_off[203] = 13'd19;
		rom_mem_dty_t_off[204] = 13'd19;
		rom_mem_dty_t_off[205] = 13'd19;
		rom_mem_dty_t_off[206] = 13'd19;
		rom_mem_dty_t_off[207] = 13'd19;
		rom_mem_dty_t_off[208] = 13'd19;
		rom_mem_dty_t_off[209] = 13'd19;
		rom_mem_dty_t_off[210] = 13'd19;
		rom_mem_dty_t_off[211] = 13'd19;
		rom_mem_dty_t_off[212] = 13'd19;
		rom_mem_dty_t_off[213] = 13'd19;
		rom_mem_dty_t_off[214] = 13'd19;
		rom_mem_dty_t_off[215] = 13'd19;
		rom_mem_dty_t_off[216] = 13'd19;
		rom_mem_dty_t_off[217] = 13'd19;
		rom_mem_dty_t_off[218] = 13'd19;
		rom_mem_dty_t_off[219] = 13'd19;
		rom_mem_dty_t_off[220] = 13'd19;
		rom_mem_dty_t_off[221] = 13'd19;
		rom_mem_dty_t_off[222] = 13'd19;
		rom_mem_dty_t_off[223] = 13'd19;
		rom_mem_dty_t_off[224] = 13'd19;
		rom_mem_dty_t_off[225] = 13'd19;
		rom_mem_dty_t_off[226] = 13'd19;
		rom_mem_dty_t_off[227] = 13'd19;
		rom_mem_dty_t_off[228] = 13'd19;
		rom_mem_dty_t_off[229] = 13'd19;
		rom_mem_dty_t_off[230] = 13'd19;
		rom_mem_dty_t_off[231] = 13'd19;
		rom_mem_dty_t_off[232] = 13'd19;
		rom_mem_dty_t_off[233] = 13'd19;
		rom_mem_dty_t_off[234] = 13'd19;
		rom_mem_dty_t_off[235] = 13'd19;
		rom_mem_dty_t_off[236] = 13'd19;
		rom_mem_dty_t_off[237] = 13'd19;
		rom_mem_dty_t_off[238] = 13'd19;
		rom_mem_dty_t_off[239] = 13'd19;
		rom_mem_dty_t_off[240] = 13'd19;
		rom_mem_dty_t_off[241] = 13'd19;
		rom_mem_dty_t_off[242] = 13'd19;
		rom_mem_dty_t_off[243] = 13'd19;
		rom_mem_dty_t_off[244] = 13'd19;
		rom_mem_dty_t_off[245] = 13'd19;
		rom_mem_dty_t_off[246] = 13'd19;
		rom_mem_dty_t_off[247] = 13'd19;
		rom_mem_dty_t_off[248] = 13'd19;
		rom_mem_dty_t_off[249] = 13'd19;
		rom_mem_dty_t_off[250] = 13'd19;
		rom_mem_dty_t_off[251] = 13'd19;
		rom_mem_dty_t_off[252] = 13'd19;
		rom_mem_dty_t_off[253] = 13'd19;
		rom_mem_dty_t_off[254] = 13'd19;
		rom_mem_dty_t_off[255] = 13'd19;
		rom_mem_dty_t_off[256] = 13'd19;
		rom_mem_dty_t_off[257] = 13'd19;
		rom_mem_dty_t_off[258] = 13'd19;
		rom_mem_dty_t_off[259] = 13'd19;
		rom_mem_dty_t_off[260] = 13'd19;
		rom_mem_dty_t_off[261] = 13'd19;
		rom_mem_dty_t_off[262] = 13'd19;
		rom_mem_dty_t_off[263] = 13'd19;
          
        
    end   
        
    //At every positive edge of the clock, read a sine wave sample 
    always @(posedge clk_in)
    begin
        duty_t          = rom_mem_dty_t[count];                                     // reading duty ratio for top switch
        
        // Sector 1 X
        if (count < 22) begin
            offset_t        = rom_mem_dty_t_off[count] + DC ;                       // reading offset duty ratio for top switch
            duty_a1         = DC + OL ;                                             // Duty ratio for middle switch signal 1
            offset_a1       = DTIME + S;
            duty_a2         = OL + DD;                                                        // reading duty ratio for middle switch
            offset_a2       = rom_mem_dty_t_off[count]+ rom_mem_dty_t[count]+ DC - OL ;  // reading offset duty ratio for middle switch
            duty_b1         = DTIME;
            offset_b1       = 0;
            duty_b2         = 13'd8192 - (rom_mem_dty_t[count] + offset_t + DD + DTIME) ;
            offset_b2       = rom_mem_dty_t[count] + offset_t + DD + DTIME;
        end
        
        // Sector 1 Y
        else if (count >= 22 && count <44) begin
            offset_t        = rom_mem_dty_t_off[count] + DC ;                                 // reading offset duty ratio for top switch               
            duty_a1         = DC + OL ;                                                       // Duty ratio for middle switch signal 1                  
            offset_a1       = DTIME + S;                                                                                                      
            duty_a2         = OL + DD;                                                        // reading duty ratio for middle switch         
            offset_a2       = DTIME + DD + rom_mem_dty_t[count] - OL ;                        // reading offset duty ratio for middle switch  
            duty_b1         = DTIME;                                                                                                          
            offset_b1       = 0;                                                                                                              
            duty_b2         = 13'd8192 - (rom_mem_dty_t[count] + offset_t + DD + DTIME) ;                                                     
            offset_b2       = rom_mem_dty_t[count] + offset_t + DD + DTIME;                                                                   
        end
        
        // Sector 2 X
        else if (count >= 44 && count <66) begin
            offset_t        = rom_mem_dty_t_off[count] + DC ;                                 // reading offset duty ratio for top switch               
            duty_a1         = DC + OL ;                                                       // Duty ratio for middle switch signal 1                  
            offset_a1       = DTIME + S;                                                                                                      
            duty_a2         = 0;                                                        // reading duty ratio for middle switch         
            offset_a2       = 0;                        // reading offset duty ratio for middle switch  
            duty_b1         = DTIME;                                                                                                          
            offset_b1       = 0;                                                                                                              
            duty_b2         = 13'd8192 - (rom_mem_dty_t[count] + offset_t + DTIME) ;                                                     
            offset_b2       = rom_mem_dty_t[count] + offset_t + DTIME;
        end
        
       // Sector 2 Y
        else if (count >= 66 && count <88) begin
            offset_t        =  rom_mem_dty_t_off[count] + DC - DTIME - OL  ;         // reading offset duty ratio for top switch
            duty_a1         =  0;                                 // Duty ratio for middle switch signal 1
            offset_a1       =  0;
            duty_a2         =  OL + DD;                             // reading duty ratio for middle switch
            offset_a2       =  rom_mem_dty_t_off[count]+ rom_mem_dty_t[count]+ DC - OL;                         // reading offset duty ratio for middle switch
            duty_b1         =  offset_t - DTIME;
            offset_b1       =  0;
            duty_b2         =  13'd8192 - (offset_t + duty_t + DD + OL  );
            offset_b2       =   offset_t + duty_t + DD + OL;
        end
        
        // Sector 3 X
        else if (count >= 88 && count <110) begin
            offset_t        = 0;              // reading offset duty ratio for top switch
            duty_a1         = 0;              // Duty ratio for middle switch signal 1
            offset_a1       = 0;
            duty_a2         = 0;              // reading duty ratio for middle switch
            offset_a2       = 0;              // reading offset duty ratio for middle switch
            duty_b1         = 0;
            offset_b1       = 0; 
            duty_b2         = 13'd8190; 
            offset_b2       = 0;
        end
        
        // Sector 3 Y
        else if (count >= 110 && count <132) begin
            offset_t        = 0;              // reading offset duty ratio for top switch
            duty_a1         = 0;              // Duty ratio for middle switch signal 1
            offset_a1       = 0;
            duty_a2         = 0;              // reading duty ratio for middle switch
            offset_a2       = 0;              // reading offset duty ratio for middle switch
            duty_b1         = 0;
            offset_b1       = 0; 
            duty_b2         = 13'd8190; 
            offset_b2       = 0;
        end
        
        // Sector 4 X
        else if (count >= 132 && count <154) begin
            offset_t        = 0;              // reading offset duty ratio for top switch
            duty_a1         = 0;              // Duty ratio for middle switch signal 1
            offset_a1       = 0;
            duty_a2         = 0;              // reading duty ratio for middle switch
            offset_a2       = 0;              // reading offset duty ratio for middle switch
            duty_b1         = 0;
            offset_b1       = 0; 
            duty_b2         = 13'd8190; 
            offset_b2       = 0;
        end
        
        // Sector 4 Y
        else if (count >= 154 && count <176) begin
            offset_t        = 0;              // reading offset duty ratio for top switch
            duty_a1         = 0;              // Duty ratio for middle switch signal 1
            offset_a1       = 0;
            duty_a2         = 0;              // reading duty ratio for middle switch
            offset_a2       = 0;              // reading offset duty ratio for middle switch
            duty_b1         = 0;
            offset_b1       = 0; 
            duty_b2         = 13'd8190; 
            offset_b2       = 0;
        end
        
        // Sector 5 X
        else if (count >= 176 && count <198) begin
            offset_t        =  rom_mem_dty_t_off[count] + DC - DTIME - OL  ;         // reading offset duty ratio for top switch
            duty_a1         =  0;                                 // Duty ratio for middle switch signal 1
            offset_a1       =  0;
            duty_a2         =  OL + DD;                             // reading duty ratio for middle switch
            offset_a2       =  rom_mem_dty_t_off[count]+ rom_mem_dty_t[count]+ DC - OL;                         // reading offset duty ratio for middle switch
            duty_b1         =  offset_t - DTIME;
            offset_b1       =  0;
            duty_b2         =  13'd8192 - (offset_t + duty_t + DD + OL  );
            offset_b2       =   offset_t + duty_t + DD + OL;
        end
        
        // Sector 5 Y
        else if (count >= 198 && count <220) begin
            offset_t        = rom_mem_dty_t_off[count] + DC ;                                 // reading offset duty ratio for top switch               
            duty_a1         = DC + OL ;                                                       // Duty ratio for middle switch signal 1                  
            offset_a1       = DTIME + S;                                                                                                      
            duty_a2         = 0;                                                        // reading duty ratio for middle switch         
            offset_a2       = 0;                        // reading offset duty ratio for middle switch  
            duty_b1         = DTIME;                                                                                                          
            offset_b1       = 0;                                                                                                              
            duty_b2         = 13'd8192 - (rom_mem_dty_t[count] + offset_t + DTIME) ;                                                     
            offset_b2       = rom_mem_dty_t[count] + offset_t + DTIME;
        end
        
        // Sector 6 X
        else if (count >= 220 && count <242) begin
            offset_t        = rom_mem_dty_t_off[count] + DC ;                       // reading offset duty ratio for top switch
            duty_a1         = DC + OL ;                                             // Duty ratio for middle switch signal 1
            offset_a1       = DTIME + S;
            duty_a2         = OL + DD;                                                        // reading duty ratio for middle switch
            offset_a2       = DTIME + DD + rom_mem_dty_t[count] - OL ;                        // reading offset duty ratio for middle switch
            duty_b1         = DTIME;
            offset_b1       = 0;
            duty_b2         = 13'd8192 - (rom_mem_dty_t[count] + offset_t + DD + DTIME) ;
            offset_b2       = rom_mem_dty_t[count] + offset_t + DD + DTIME;
        end
       
        // Sector 6 Y
        else if (count >= 242 && count <264) begin
            offset_t        = rom_mem_dty_t_off[count] + DC ;                       // reading offset duty ratio for top switch
            duty_a1         = DC + OL ;                                             // Duty ratio for middle switch signal 1
            offset_a1       = DTIME + S;
            duty_a2         = OL + DD;                                                        // reading duty ratio for middle switch
            offset_a2       = rom_mem_dty_t_off[count]+ rom_mem_dty_t[count]+ DC - OL ;  // reading offset duty ratio for middle switch
            duty_b1         = DTIME;
            offset_b1       = 0;
            duty_b2         = 13'd8192 - (rom_mem_dty_t[count] + offset_t + DD + DTIME) ;
            offset_b2       = rom_mem_dty_t[count] + offset_t + DD + DTIME;
        end
        
        else begin
            offset_t        = offset_t;   // reading offset duty ratio for top switch
            duty_a1         = duty_a1;    // Duty ratio for middle switch signal 1
            offset_a1       = offset_a1;
            duty_a2         = duty_a2;              // reading duty ratio for middle switch
            offset_a2       = offset_a2;            // reading offset duty ratio for middle switch
            duty_b1         = duty_b1;  
            offset_b1       = offset_b1;
            duty_b2         = duty_b2;
            offset_b2       = offset_b2;
        end
        
        count = count + 1;                                                          // incremeinting the counter 
        
        if(count == SIZE)                                                           // condition to reset the counter
            count= 0;
    end
    
endmodule



/*
        duty_t          = rom_mem_dty_t[count];                                     // reading duty ratio for top switch
        offset_t        = rom_mem_dty_t_off[count] ;                                // reading offset duty ratio for top switch
        
        duty_a1         = 0;                                                        // reading duty ratio for middle switch
        offset_a1       = 0;                                                        // reading offset duty ratio for middle switch
        duty_a2         = 0;                                                        // reading duty ratio for middle switch
        offset_a2       = 0;                                                        // reading offset duty ratio for middle switch
        
        duty_b1         = rom_mem_dty_t_off[count] > 20 ? rom_mem_dty_t_off[count]- DTIME : 13'd0;
        offset_b1       = 0;
        
        // generating the  offset duty ratio for middle switch
        duty_b2         = rom_mem_dty_t[count] == 0? 13'd8190 : 13'd8192 - (rom_mem_dty_t[count] + rom_mem_dty_t_off[count] + DTIME) ;
        offset_b2       = rom_mem_dty_t[count] == 0? 13'd0 : rom_mem_dty_t[count] + rom_mem_dty_t_off[count] + DTIME;
*/
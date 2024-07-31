`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////
// LUT_ph_a.v - A module to generate the Duty ratios for the PWM block
//
// Author:	        Abhijeet Prem (abhij@pdx.edu)
// Version:         1.4
// Last Modified:	18-July-2022
// next modified:   13=Feb-2023
//
// Rivision details:
// ----------------
//  Version No      Date                                    Comment
//      1.0      18-July-2022       The inital code was created read from the text files and provide each value to the PWM block
//      1.1      2nd-Nov-2022       
//      1.2      11-Nov-2022        split the bottom signal into two and generating that pwm signals
//      1.3      14-Nov-2022        added the lut values and able to 
//      1.4      13=Feb-2023        changed blocking assignments to non- blocking in sequential block
//      1.5      12-june-2024       modifiying the to fit the need of SiC testing, file handeling not working hence removed that capibility
//
// Description:
// -----------
//      o   Each of the duty values are stored into a 2d memory array
//      o   Offsets values for the signals are calculate
//      o   On every positive edge of the clock, a vaule from the memory is read and send out
//  
//  File discreption:
//  ----------------
//
// Note:  The moudle is written based on the code proived by Wiwin H
//         
//      13 Feb update: 
//          - noticed some noise on the bottom switch when top switch is off, has to do with the duty input
//          - Changing the duty to 13'd8191 from 13'd8190 to see if there is any improvement
//          - changed blocking assignemts to non- blcoking in the sequential block    
//              -   need to see if that broke someting or not! 

//      12 June, 24 Note:
//          - The module needs to be tested for errors
//
////////////////////////////////////////////////////////////////


module LUT_ph_b
    
    #(  parameter WIDTH = 13,                                // User input for PWM resulution
        parameter SIZE = 264,                                 // USER INPUT for number of samples
        parameter  DTIME = 20                               // user defiend dead time ~ 160ns 
     )                           
    (
    input  wire              clk_in,                         // input clock signal from the clock scalar                            
    output reg [WIDTH-1:0]  offset_t, duty_t,               // duty and offset ratios for the pwm block 
    output reg [WIDTH-1:0]  offset_a1, duty_a1,             // duty and offset ratios for the pwm block
    output reg [WIDTH-1:0]  offset_a2, duty_a2,             // duty and offset ratios for the pwm block
    output reg [WIDTH-1:0]  offset_b1, duty_b1,             // duty and offset ratios for the pwm block
    output reg [WIDTH-1:0]  offset_b2, duty_b2              // duty and offset ratios for the pwm block   
    );
    


    reg [WIDTH-1:0] rom_mem_dty_t       [0:SIZE-1];          // 2D memeory array to store duty ratios for the top switch signal
    reg [WIDTH-1:0] rom_mem_dty_t_off   [0:SIZE-1];          // 2D memeory array to store offset values for the top switch signal
    
    integer count;                                           // varible for counting
    
    // initial block, non-synthesizable
    initial begin
        
        count = 0;
//////////////// TOP SWITCH DUTY /////////////////////////////////       
        rom_mem_dty_t[0] = 13'd96;
		rom_mem_dty_t[1] = 13'd144;
		rom_mem_dty_t[2] = 13'd288;
		rom_mem_dty_t[3] = 13'd431;
		rom_mem_dty_t[4] = 13'd575;
		rom_mem_dty_t[5] = 13'd718;
		rom_mem_dty_t[6] = 13'd861;
		rom_mem_dty_t[7] = 13'd1003;
		rom_mem_dty_t[8] = 13'd1145;
		rom_mem_dty_t[9] = 13'd1286;
		rom_mem_dty_t[10] = 13'd1427;
		rom_mem_dty_t[11] = 13'd1566;
		rom_mem_dty_t[12] = 13'd1705;
		rom_mem_dty_t[13] = 13'd1842;
		rom_mem_dty_t[14] = 13'd1979;
		rom_mem_dty_t[15] = 13'd2115;
		rom_mem_dty_t[16] = 13'd2249;
		rom_mem_dty_t[17] = 13'd2382;
		rom_mem_dty_t[18] = 13'd2514;
		rom_mem_dty_t[19] = 13'd2644;
		rom_mem_dty_t[20] = 13'd2772;
		rom_mem_dty_t[21] = 13'd2900;
		rom_mem_dty_t[22] = 13'd3025;
		rom_mem_dty_t[23] = 13'd3149;
		rom_mem_dty_t[24] = 13'd3271;
		rom_mem_dty_t[25] = 13'd3391;
		rom_mem_dty_t[26] = 13'd3509;
		rom_mem_dty_t[27] = 13'd3625;
		rom_mem_dty_t[28] = 13'd3739;
		rom_mem_dty_t[29] = 13'd3851;
		rom_mem_dty_t[30] = 13'd3961;
		rom_mem_dty_t[31] = 13'd4068;
		rom_mem_dty_t[32] = 13'd4174;
		rom_mem_dty_t[33] = 13'd4276;
		rom_mem_dty_t[34] = 13'd4377;
		rom_mem_dty_t[35] = 13'd4474;
		rom_mem_dty_t[36] = 13'd4570;
		rom_mem_dty_t[37] = 13'd4662;
		rom_mem_dty_t[38] = 13'd4752;
		rom_mem_dty_t[39] = 13'd4840;
		rom_mem_dty_t[40] = 13'd4924;
		rom_mem_dty_t[41] = 13'd5006;
		rom_mem_dty_t[42] = 13'd5085;
		rom_mem_dty_t[43] = 13'd5161;
		rom_mem_dty_t[44] = 13'd5234;
		rom_mem_dty_t[45] = 13'd5304;
		rom_mem_dty_t[46] = 13'd5371;
		rom_mem_dty_t[47] = 13'd5435;
		rom_mem_dty_t[48] = 13'd5496;
		rom_mem_dty_t[49] = 13'd5553;
		rom_mem_dty_t[50] = 13'd5608;
		rom_mem_dty_t[51] = 13'd5659;
		rom_mem_dty_t[52] = 13'd5707;
		rom_mem_dty_t[53] = 13'd5752;
		rom_mem_dty_t[54] = 13'd5794;
		rom_mem_dty_t[55] = 13'd5832;
		rom_mem_dty_t[56] = 13'd5867;
		rom_mem_dty_t[57] = 13'd5899;
		rom_mem_dty_t[58] = 13'd5927;
		rom_mem_dty_t[59] = 13'd5952;
		rom_mem_dty_t[60] = 13'd5973;
		rom_mem_dty_t[61] = 13'd5991;
		rom_mem_dty_t[62] = 13'd6006;
		rom_mem_dty_t[63] = 13'd6017;
		rom_mem_dty_t[64] = 13'd6025;
		rom_mem_dty_t[65] = 13'd6029;
		rom_mem_dty_t[66] = 13'd6030;
		rom_mem_dty_t[67] = 13'd6027;
		rom_mem_dty_t[68] = 13'd6021;
		rom_mem_dty_t[69] = 13'd6012;
		rom_mem_dty_t[70] = 13'd5999;
		rom_mem_dty_t[71] = 13'd5982;
		rom_mem_dty_t[72] = 13'd5963;
		rom_mem_dty_t[73] = 13'd5940;
		rom_mem_dty_t[74] = 13'd5913;
		rom_mem_dty_t[75] = 13'd5883;
		rom_mem_dty_t[76] = 13'd5850;
		rom_mem_dty_t[77] = 13'd5813;
		rom_mem_dty_t[78] = 13'd5773;
		rom_mem_dty_t[79] = 13'd5730;
		rom_mem_dty_t[80] = 13'd5684;
		rom_mem_dty_t[81] = 13'd5634;
		rom_mem_dty_t[82] = 13'd5581;
		rom_mem_dty_t[83] = 13'd5525;
		rom_mem_dty_t[84] = 13'd5466;
		rom_mem_dty_t[85] = 13'd5403;
		rom_mem_dty_t[86] = 13'd5338;
		rom_mem_dty_t[87] = 13'd5269;
		rom_mem_dty_t[88] = 13'd5246;
		rom_mem_dty_t[89] = 13'd5315;
		rom_mem_dty_t[90] = 13'd5382;
		rom_mem_dty_t[91] = 13'd5445;
		rom_mem_dty_t[92] = 13'd5506;
		rom_mem_dty_t[93] = 13'd5563;
		rom_mem_dty_t[94] = 13'd5617;
		rom_mem_dty_t[95] = 13'd5668;
		rom_mem_dty_t[96] = 13'd5715;
		rom_mem_dty_t[97] = 13'd5759;
		rom_mem_dty_t[98] = 13'd5800;
		rom_mem_dty_t[99] = 13'd5838;
		rom_mem_dty_t[100] = 13'd5872;
		rom_mem_dty_t[101] = 13'd5903;
		rom_mem_dty_t[102] = 13'd5931;
		rom_mem_dty_t[103] = 13'd5955;
		rom_mem_dty_t[104] = 13'd5976;
		rom_mem_dty_t[105] = 13'd5994;
		rom_mem_dty_t[106] = 13'd6008;
		rom_mem_dty_t[107] = 13'd6018;
		rom_mem_dty_t[108] = 13'd6025;
		rom_mem_dty_t[109] = 13'd6029;
		rom_mem_dty_t[110] = 13'd6030;
		rom_mem_dty_t[111] = 13'd6026;
		rom_mem_dty_t[112] = 13'd6020;
		rom_mem_dty_t[113] = 13'd6010;
		rom_mem_dty_t[114] = 13'd5996;
		rom_mem_dty_t[115] = 13'd5979;
		rom_mem_dty_t[116] = 13'd5959;
		rom_mem_dty_t[117] = 13'd5935;
		rom_mem_dty_t[118] = 13'd5908;
		rom_mem_dty_t[119] = 13'd5878;
		rom_mem_dty_t[120] = 13'd5844;
		rom_mem_dty_t[121] = 13'd5807;
		rom_mem_dty_t[122] = 13'd5766;
		rom_mem_dty_t[123] = 13'd5723;
		rom_mem_dty_t[124] = 13'd5676;
		rom_mem_dty_t[125] = 13'd5625;
		rom_mem_dty_t[126] = 13'd5572;
		rom_mem_dty_t[127] = 13'd5515;
		rom_mem_dty_t[128] = 13'd5455;
		rom_mem_dty_t[129] = 13'd5393;
		rom_mem_dty_t[130] = 13'd5327;
		rom_mem_dty_t[131] = 13'd5258;
		rom_mem_dty_t[132] = 13'd5186;
		rom_mem_dty_t[133] = 13'd5111;
		rom_mem_dty_t[134] = 13'd5033;
		rom_mem_dty_t[135] = 13'd4952;
		rom_mem_dty_t[136] = 13'd4868;
		rom_mem_dty_t[137] = 13'd4782;
		rom_mem_dty_t[138] = 13'd4693;
		rom_mem_dty_t[139] = 13'd4601;
		rom_mem_dty_t[140] = 13'd4507;
		rom_mem_dty_t[141] = 13'd4410;
		rom_mem_dty_t[142] = 13'd4310;
		rom_mem_dty_t[143] = 13'd4208;
		rom_mem_dty_t[144] = 13'd4104;
		rom_mem_dty_t[145] = 13'd3997;
		rom_mem_dty_t[146] = 13'd3888;
		rom_mem_dty_t[147] = 13'd3777;
		rom_mem_dty_t[148] = 13'd3663;
		rom_mem_dty_t[149] = 13'd3548;
		rom_mem_dty_t[150] = 13'd3430;
		rom_mem_dty_t[151] = 13'd3311;
		rom_mem_dty_t[152] = 13'd3190;
		rom_mem_dty_t[153] = 13'd3066;
		rom_mem_dty_t[154] = 13'd2942;
		rom_mem_dty_t[155] = 13'd2815;
		rom_mem_dty_t[156] = 13'd2687;
		rom_mem_dty_t[157] = 13'd2557;
		rom_mem_dty_t[158] = 13'd2426;
		rom_mem_dty_t[159] = 13'd2293;
		rom_mem_dty_t[160] = 13'd2159;
		rom_mem_dty_t[161] = 13'd2024;
		rom_mem_dty_t[162] = 13'd1888;
		rom_mem_dty_t[163] = 13'd1751;
		rom_mem_dty_t[164] = 13'd1612;
		rom_mem_dty_t[165] = 13'd1473;
		rom_mem_dty_t[166] = 13'd1333;
		rom_mem_dty_t[167] = 13'd1192;
		rom_mem_dty_t[168] = 13'd1051;
		rom_mem_dty_t[169] = 13'd908;
		rom_mem_dty_t[170] = 13'd766;
		rom_mem_dty_t[171] = 13'd623;
		rom_mem_dty_t[172] = 13'd479;
		rom_mem_dty_t[173] = 13'd335;
		rom_mem_dty_t[174] = 13'd192;
		rom_mem_dty_t[175] = 13'd48;
		rom_mem_dty_t[176] = 13'd0;
		rom_mem_dty_t[177] = 13'd0;
		rom_mem_dty_t[178] = 13'd0;
		rom_mem_dty_t[179] = 13'd0;
		rom_mem_dty_t[180] = 13'd0;
		rom_mem_dty_t[181] = 13'd0;
		rom_mem_dty_t[182] = 13'd0;
		rom_mem_dty_t[183] = 13'd0;
		rom_mem_dty_t[184] = 13'd0;
		rom_mem_dty_t[185] = 13'd0;
		rom_mem_dty_t[186] = 13'd0;
		rom_mem_dty_t[187] = 13'd0;
		rom_mem_dty_t[188] = 13'd0;
		rom_mem_dty_t[189] = 13'd0;
		rom_mem_dty_t[190] = 13'd0;
		rom_mem_dty_t[191] = 13'd0;
		rom_mem_dty_t[192] = 13'd0;
		rom_mem_dty_t[193] = 13'd0;
		rom_mem_dty_t[194] = 13'd0;
		rom_mem_dty_t[195] = 13'd0;
		rom_mem_dty_t[196] = 13'd0;
		rom_mem_dty_t[197] = 13'd0;
		rom_mem_dty_t[198] = 13'd0;
		rom_mem_dty_t[199] = 13'd0;
		rom_mem_dty_t[200] = 13'd0;
		rom_mem_dty_t[201] = 13'd0;
		rom_mem_dty_t[202] = 13'd0;
		rom_mem_dty_t[203] = 13'd0;
		rom_mem_dty_t[204] = 13'd0;
		rom_mem_dty_t[205] = 13'd0;
		rom_mem_dty_t[206] = 13'd0;
		rom_mem_dty_t[207] = 13'd0;
		rom_mem_dty_t[208] = 13'd0;
		rom_mem_dty_t[209] = 13'd0;
		rom_mem_dty_t[210] = 13'd0;
		rom_mem_dty_t[211] = 13'd0;
		rom_mem_dty_t[212] = 13'd0;
		rom_mem_dty_t[213] = 13'd0;
		rom_mem_dty_t[214] = 13'd0;
		rom_mem_dty_t[215] = 13'd0;
		rom_mem_dty_t[216] = 13'd0;
		rom_mem_dty_t[217] = 13'd0;
		rom_mem_dty_t[218] = 13'd0;
		rom_mem_dty_t[219] = 13'd0;
		rom_mem_dty_t[220] = 13'd0;
		rom_mem_dty_t[221] = 13'd0;
		rom_mem_dty_t[222] = 13'd0;
		rom_mem_dty_t[223] = 13'd0;
		rom_mem_dty_t[224] = 13'd0;
		rom_mem_dty_t[225] = 13'd0;
		rom_mem_dty_t[226] = 13'd0;
		rom_mem_dty_t[227] = 13'd0;
		rom_mem_dty_t[228] = 13'd0;
		rom_mem_dty_t[229] = 13'd0;
		rom_mem_dty_t[230] = 13'd0;
		rom_mem_dty_t[231] = 13'd0;
		rom_mem_dty_t[232] = 13'd0;
		rom_mem_dty_t[233] = 13'd0;
		rom_mem_dty_t[234] = 13'd0;
		rom_mem_dty_t[235] = 13'd0;
		rom_mem_dty_t[236] = 13'd0;
		rom_mem_dty_t[237] = 13'd0;
		rom_mem_dty_t[238] = 13'd0;
		rom_mem_dty_t[239] = 13'd0;
		rom_mem_dty_t[240] = 13'd0;
		rom_mem_dty_t[241] = 13'd0;
		rom_mem_dty_t[242] = 13'd0;
		rom_mem_dty_t[243] = 13'd0;
		rom_mem_dty_t[244] = 13'd0;
		rom_mem_dty_t[245] = 13'd0;
		rom_mem_dty_t[246] = 13'd0;
		rom_mem_dty_t[247] = 13'd0;
		rom_mem_dty_t[248] = 13'd0;
		rom_mem_dty_t[249] = 13'd0;
		rom_mem_dty_t[250] = 13'd0;
		rom_mem_dty_t[251] = 13'd0;
		rom_mem_dty_t[252] = 13'd0;
		rom_mem_dty_t[253] = 13'd0;
		rom_mem_dty_t[254] = 13'd0;
		rom_mem_dty_t[255] = 13'd0;
		rom_mem_dty_t[256] = 13'd0;
		rom_mem_dty_t[257] = 13'd0;
		rom_mem_dty_t[258] = 13'd0;
		rom_mem_dty_t[259] = 13'd0;
		rom_mem_dty_t[260] = 13'd0;
		rom_mem_dty_t[261] = 13'd0;
		rom_mem_dty_t[262] = 13'd0;
		rom_mem_dty_t[263] = 13'd0;


		
//////////////// TOP SWITCH OFFSET /////////////////////////////////
		rom_mem_dty_t_off[0] = 13'd5242;
		rom_mem_dty_t_off[1] = 13'd5168;
		rom_mem_dty_t_off[2] = 13'd5092;
		rom_mem_dty_t_off[3] = 13'd5013;
		rom_mem_dty_t_off[4] = 13'd4930;
		rom_mem_dty_t_off[5] = 13'd4845;
		rom_mem_dty_t_off[6] = 13'd4758;
		rom_mem_dty_t_off[7] = 13'd4667;
		rom_mem_dty_t_off[8] = 13'd4574;
		rom_mem_dty_t_off[9] = 13'd4478;
		rom_mem_dty_t_off[10] = 13'd4380;
		rom_mem_dty_t_off[11] = 13'd4279;
		rom_mem_dty_t_off[12] = 13'd4176;
		rom_mem_dty_t_off[13] = 13'd4071;
		rom_mem_dty_t_off[14] = 13'd3963;
		rom_mem_dty_t_off[15] = 13'd3853;
		rom_mem_dty_t_off[16] = 13'd3740;
		rom_mem_dty_t_off[17] = 13'd3626;
		rom_mem_dty_t_off[18] = 13'd3509;
		rom_mem_dty_t_off[19] = 13'd3391;
		rom_mem_dty_t_off[20] = 13'd3271;
		rom_mem_dty_t_off[21] = 13'd3148;
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
		rom_mem_dty_t_off[66] = 13'd19;
		rom_mem_dty_t_off[67] = 13'd19;
		rom_mem_dty_t_off[68] = 13'd19;
		rom_mem_dty_t_off[69] = 13'd19;
		rom_mem_dty_t_off[70] = 13'd19;
		rom_mem_dty_t_off[71] = 13'd19;
		rom_mem_dty_t_off[72] = 13'd19;
		rom_mem_dty_t_off[73] = 13'd19;
		rom_mem_dty_t_off[74] = 13'd19;
		rom_mem_dty_t_off[75] = 13'd19;
		rom_mem_dty_t_off[76] = 13'd19;
		rom_mem_dty_t_off[77] = 13'd19;
		rom_mem_dty_t_off[78] = 13'd19;
		rom_mem_dty_t_off[79] = 13'd19;
		rom_mem_dty_t_off[80] = 13'd19;
		rom_mem_dty_t_off[81] = 13'd19;
		rom_mem_dty_t_off[82] = 13'd19;
		rom_mem_dty_t_off[83] = 13'd19;
		rom_mem_dty_t_off[84] = 13'd19;
		rom_mem_dty_t_off[85] = 13'd19;
		rom_mem_dty_t_off[86] = 13'd19;
		rom_mem_dty_t_off[87] = 13'd19;
		rom_mem_dty_t_off[88] = 13'd19;
		rom_mem_dty_t_off[89] = 13'd19;
		rom_mem_dty_t_off[90] = 13'd19;
		rom_mem_dty_t_off[91] = 13'd19;
		rom_mem_dty_t_off[92] = 13'd19;
		rom_mem_dty_t_off[93] = 13'd19;
		rom_mem_dty_t_off[94] = 13'd19;
		rom_mem_dty_t_off[95] = 13'd19;
		rom_mem_dty_t_off[96] = 13'd19;
		rom_mem_dty_t_off[97] = 13'd19;
		rom_mem_dty_t_off[98] = 13'd19;
		rom_mem_dty_t_off[99] = 13'd19;
		rom_mem_dty_t_off[100] = 13'd19;
		rom_mem_dty_t_off[101] = 13'd19;
		rom_mem_dty_t_off[102] = 13'd19;
		rom_mem_dty_t_off[103] = 13'd19;
		rom_mem_dty_t_off[104] = 13'd19;
		rom_mem_dty_t_off[105] = 13'd19;
		rom_mem_dty_t_off[106] = 13'd19;
		rom_mem_dty_t_off[107] = 13'd19;
		rom_mem_dty_t_off[108] = 13'd19;
		rom_mem_dty_t_off[109] = 13'd19;
		rom_mem_dty_t_off[110] = 13'd19;
		rom_mem_dty_t_off[111] = 13'd19;
		rom_mem_dty_t_off[112] = 13'd19;
		rom_mem_dty_t_off[113] = 13'd19;
		rom_mem_dty_t_off[114] = 13'd19;
		rom_mem_dty_t_off[115] = 13'd19;
		rom_mem_dty_t_off[116] = 13'd19;
		rom_mem_dty_t_off[117] = 13'd19;
		rom_mem_dty_t_off[118] = 13'd19;
		rom_mem_dty_t_off[119] = 13'd19;
		rom_mem_dty_t_off[120] = 13'd19;
		rom_mem_dty_t_off[121] = 13'd19;
		rom_mem_dty_t_off[122] = 13'd19;
		rom_mem_dty_t_off[123] = 13'd19;
		rom_mem_dty_t_off[124] = 13'd19;
		rom_mem_dty_t_off[125] = 13'd19;
		rom_mem_dty_t_off[126] = 13'd19;
		rom_mem_dty_t_off[127] = 13'd19;
		rom_mem_dty_t_off[128] = 13'd19;
		rom_mem_dty_t_off[129] = 13'd19;
		rom_mem_dty_t_off[130] = 13'd19;
		rom_mem_dty_t_off[131] = 13'd19;
		rom_mem_dty_t_off[132] = 13'd19;
		rom_mem_dty_t_off[133] = 13'd19;
		rom_mem_dty_t_off[134] = 13'd19;
		rom_mem_dty_t_off[135] = 13'd19;
		rom_mem_dty_t_off[136] = 13'd19;
		rom_mem_dty_t_off[137] = 13'd19;
		rom_mem_dty_t_off[138] = 13'd19;
		rom_mem_dty_t_off[139] = 13'd19;
		rom_mem_dty_t_off[140] = 13'd19;
		rom_mem_dty_t_off[141] = 13'd19;
		rom_mem_dty_t_off[142] = 13'd19;
		rom_mem_dty_t_off[143] = 13'd19;
		rom_mem_dty_t_off[144] = 13'd19;
		rom_mem_dty_t_off[145] = 13'd19;
		rom_mem_dty_t_off[146] = 13'd19;
		rom_mem_dty_t_off[147] = 13'd19;
		rom_mem_dty_t_off[148] = 13'd19;
		rom_mem_dty_t_off[149] = 13'd19;
		rom_mem_dty_t_off[150] = 13'd19;
		rom_mem_dty_t_off[151] = 13'd19;
		rom_mem_dty_t_off[152] = 13'd19;
		rom_mem_dty_t_off[153] = 13'd19;
		rom_mem_dty_t_off[154] = 13'd3107;
		rom_mem_dty_t_off[155] = 13'd3230;
		rom_mem_dty_t_off[156] = 13'd3351;
		rom_mem_dty_t_off[157] = 13'd3470;
		rom_mem_dty_t_off[158] = 13'd3587;
		rom_mem_dty_t_off[159] = 13'd3702;
		rom_mem_dty_t_off[160] = 13'd3815;
		rom_mem_dty_t_off[161] = 13'd3926;
		rom_mem_dty_t_off[162] = 13'd4035;
		rom_mem_dty_t_off[163] = 13'd4141;
		rom_mem_dty_t_off[164] = 13'd4245;
		rom_mem_dty_t_off[165] = 13'd4347;
		rom_mem_dty_t_off[166] = 13'd4446;
		rom_mem_dty_t_off[167] = 13'd4542;
		rom_mem_dty_t_off[168] = 13'd4636;
		rom_mem_dty_t_off[169] = 13'd4728;
		rom_mem_dty_t_off[170] = 13'd4816;
		rom_mem_dty_t_off[171] = 13'd4902;
		rom_mem_dty_t_off[172] = 13'd4985;
		rom_mem_dty_t_off[173] = 13'd5066;
		rom_mem_dty_t_off[174] = 13'd5143;
		rom_mem_dty_t_off[175] = 13'd5218;
		rom_mem_dty_t_off[176] = 13'd0;
		rom_mem_dty_t_off[177] = 13'd0;
		rom_mem_dty_t_off[178] = 13'd0;
		rom_mem_dty_t_off[179] = 13'd0;
		rom_mem_dty_t_off[180] = 13'd0;
		rom_mem_dty_t_off[181] = 13'd0;
		rom_mem_dty_t_off[182] = 13'd0;
		rom_mem_dty_t_off[183] = 13'd0;
		rom_mem_dty_t_off[184] = 13'd0;
		rom_mem_dty_t_off[185] = 13'd0;
		rom_mem_dty_t_off[186] = 13'd0;
		rom_mem_dty_t_off[187] = 13'd0;
		rom_mem_dty_t_off[188] = 13'd0;
		rom_mem_dty_t_off[189] = 13'd0;
		rom_mem_dty_t_off[190] = 13'd0;
		rom_mem_dty_t_off[191] = 13'd0;
		rom_mem_dty_t_off[192] = 13'd0;
		rom_mem_dty_t_off[193] = 13'd0;
		rom_mem_dty_t_off[194] = 13'd0;
		rom_mem_dty_t_off[195] = 13'd0;
		rom_mem_dty_t_off[196] = 13'd0;
		rom_mem_dty_t_off[197] = 13'd0;
		rom_mem_dty_t_off[198] = 13'd0;
		rom_mem_dty_t_off[199] = 13'd0;
		rom_mem_dty_t_off[200] = 13'd0;
		rom_mem_dty_t_off[201] = 13'd0;
		rom_mem_dty_t_off[202] = 13'd0;
		rom_mem_dty_t_off[203] = 13'd0;
		rom_mem_dty_t_off[204] = 13'd0;
		rom_mem_dty_t_off[205] = 13'd0;
		rom_mem_dty_t_off[206] = 13'd0;
		rom_mem_dty_t_off[207] = 13'd0;
		rom_mem_dty_t_off[208] = 13'd0;
		rom_mem_dty_t_off[209] = 13'd0;
		rom_mem_dty_t_off[210] = 13'd0;
		rom_mem_dty_t_off[211] = 13'd0;
		rom_mem_dty_t_off[212] = 13'd0;
		rom_mem_dty_t_off[213] = 13'd0;
		rom_mem_dty_t_off[214] = 13'd0;
		rom_mem_dty_t_off[215] = 13'd0;
		rom_mem_dty_t_off[216] = 13'd0;
		rom_mem_dty_t_off[217] = 13'd0;
		rom_mem_dty_t_off[218] = 13'd0;
		rom_mem_dty_t_off[219] = 13'd0;
		rom_mem_dty_t_off[220] = 13'd0;
		rom_mem_dty_t_off[221] = 13'd0;
		rom_mem_dty_t_off[222] = 13'd0;
		rom_mem_dty_t_off[223] = 13'd0;
		rom_mem_dty_t_off[224] = 13'd0;
		rom_mem_dty_t_off[225] = 13'd0;
		rom_mem_dty_t_off[226] = 13'd0;
		rom_mem_dty_t_off[227] = 13'd0;
		rom_mem_dty_t_off[228] = 13'd0;
		rom_mem_dty_t_off[229] = 13'd0;
		rom_mem_dty_t_off[230] = 13'd0;
		rom_mem_dty_t_off[231] = 13'd0;
		rom_mem_dty_t_off[232] = 13'd0;
		rom_mem_dty_t_off[233] = 13'd0;
		rom_mem_dty_t_off[234] = 13'd0;
		rom_mem_dty_t_off[235] = 13'd0;
		rom_mem_dty_t_off[236] = 13'd0;
		rom_mem_dty_t_off[237] = 13'd0;
		rom_mem_dty_t_off[238] = 13'd0;
		rom_mem_dty_t_off[239] = 13'd0;
		rom_mem_dty_t_off[240] = 13'd0;
		rom_mem_dty_t_off[241] = 13'd0;
		rom_mem_dty_t_off[242] = 13'd0;
		rom_mem_dty_t_off[243] = 13'd0;
		rom_mem_dty_t_off[244] = 13'd0;
		rom_mem_dty_t_off[245] = 13'd0;
		rom_mem_dty_t_off[246] = 13'd0;
		rom_mem_dty_t_off[247] = 13'd0;
		rom_mem_dty_t_off[248] = 13'd0;
		rom_mem_dty_t_off[249] = 13'd0;
		rom_mem_dty_t_off[250] = 13'd0;
		rom_mem_dty_t_off[251] = 13'd0;
		rom_mem_dty_t_off[252] = 13'd0;
		rom_mem_dty_t_off[253] = 13'd0;
		rom_mem_dty_t_off[254] = 13'd0;
		rom_mem_dty_t_off[255] = 13'd0;
		rom_mem_dty_t_off[256] = 13'd0;
		rom_mem_dty_t_off[257] = 13'd0;
		rom_mem_dty_t_off[258] = 13'd0;
		rom_mem_dty_t_off[259] = 13'd0;
		rom_mem_dty_t_off[260] = 13'd0;
		rom_mem_dty_t_off[261] = 13'd0;
		rom_mem_dty_t_off[262] = 13'd0;
		rom_mem_dty_t_off[263] = 13'd0; //13'd5242;


    end
        
     //At every positive edge of the clock, read a sine wave sample 
    always @(posedge clk_in)
    begin
        duty_t          = rom_mem_dty_t[count];                                     // reading duty ratio for top switch
        offset_t        = rom_mem_dty_t_off[count] ;                                // reading offset duty ratio for top switch
                        
        duty_a1         = 0;                                                        // reading duty ratio for middle switch
        offset_a1       = 0;                                                        // reading offset duty ratio for middle switch
        duty_a2         = 0;                                                        // reading duty ratio for middle switch
        offset_a2       = 0;                                                        // reading offset duty ratio for middle switch
                        
        duty_b1         = rom_mem_dty_t_off[count] > 20 ? rom_mem_dty_t_off[count]- DTIME : 13'd0;
        offset_b1       = 0;
        
        // generating the duty and offset ratios for bottom switch
        duty_b2         = rom_mem_dty_t[count] == 0? 13'd8190 : 13'd8192 - (rom_mem_dty_t[count] + rom_mem_dty_t_off[count] + DTIME) ;
        offset_b2       = rom_mem_dty_t[count] == 0? 13'd0 : rom_mem_dty_t[count] + rom_mem_dty_t_off[count] + DTIME;
        
        count = count + 1;                                 // incremeinting the counter 
        
        if(count == SIZE)                                   // condition to reset the counter
            count = 0;
    end

endmodule
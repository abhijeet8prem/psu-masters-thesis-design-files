----------------------------------------------------------------------------------
-- Company: Portland State University
-- Engineer: Dr. Mahima Gupta, Abhijeet Prem
-- 
-- Create Date: 07/19/2018 03:51:23 PM
-- Design Name: PWM generator
-- Module Name: PWM_hx2 - Behavioral
-- Project Name: Cascade Power Converter poject
-- Target Devices: Any
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: Nil 
-- 
-- Revision: 1
-- Revision 0.01 - File Created
-- Additional Comments:
-- The orginal code has been modified to fit the needs for the project
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_generator is
    Generic ( WIDTH_P   : Integer range 0 to 20 := 13;                  -- parameter for chaanging the resulution of the PWM block
              DVSR: Integer range 0 to 2**20 := 6250);                  -- hexadecimal value for the prescalar to cnage output frequency
    

-- assign the input and output ports            
    Port ( clk_in       : in STD_LOGIC;                                         -- input clock signal                    
           offset        : in STD_LOGIC_VECTOR (WIDTH_P-1 downto 0);            -- input offset value
           duty        : in STD_LOGIC_VECTOR (WIDTH_P-1 downto 0);              -- input duty value
           pwm_out          : out STD_LOGIC);                                   -- output PWM signal
          
end pwm_generator;

-- 

architecture Behavioral of pwm_generator is

    type states is (load_new_duty, pwm_low, pwm_high);                  -- declaring the 3 states of the state machine
    signal state_of_machine : states;                                   -- assignning a variabel for the states 

begin

    StateMachinehx2     : process (clk_in)                              -- variable for the process
    
    -- assigning varables for the state machine
    variable d1         : Integer range 0 to ((2**Width_P)-1) := 0;     -- 2^Width_P bit varaible to hold offset value 
    variable d2         : Integer range 0 to ((2**Width_P)-1) := 0;     -- 2^Width_P bit varaible to hold duty value 
    variable d12        : Integer range 0 to ((2**Width_P)-1) := 0;     -- 2^Width_P bit varaible to hold sum of  offest and duty value 
    variable count      : Integer range 0 to ((2**Width_P)-1) := 0;     -- what is the purpose of count?
    constant boundary   : Integer := ((2**Width_P)-1);                     -- prescalar fr 
    --uncomment this for activate DVSR
    --constant boundary   : Integer := (DVSR-1);                             -- prescalar for 
    
    variable toggle     : STD_LOGIC := '0';                             -- ??
    
    begin                                                               -- beguning of the state machine process
    
    if rising_edge(clk_in) then                                         -- on the rising edge of the clock make these change 
    
        -- starting of the case statement
        case state_of_machine is 
        
            -- load new duty case
            when load_new_duty =>
                d1 := conv_Integer(offset);     
                d2 := conv_Integer(duty);
                d12 := d1 + d2;             
                count := 0;
                --toggle := not toggle;
                
                if (d1 = 0 and d2 = 0) then
                    
                   -- if (toggle = '0') then
                    --    pwm_out <= '0';                      
                        
                    --else
                     --   pwm_out <= '0';
                    --end if;
                     pwm_out <='0';
                    
                    state_of_machine <= pwm_low;
                    
                elsif (d1 = 0 and d2 > 0) then
                    pwm_out <= '1';
                    state_of_machine <= pwm_high;
                    
                elsif (d1 > 0) then
                    pwm_out <= '0';
                    state_of_machine <= pwm_low;
                    
                end if;
            
            when pwm_low =>
                count := count + 1;
                if (count < boundary and count < d1) then
                    pwm_out <= '0';
                    state_of_machine <= pwm_low;
                elsif (count = d1 and d2 = 0 and count < boundary) then
                    if (toggle = '0') then
                        pwm_out <= '0';             -- why if and else are having the same pwm out assignmentent
                    else
                        pwm_out <= '0';             -- why if and else are having the same pwm out assignmentent
                    end if;
                    state_of_machine <= pwm_low;
                elsif (count = d1 and d2 > 0 and count < boundary) then
                    pwm_out <= '1';
                    state_of_machine <= pwm_high;
                elsif (count = boundary) then
                    if (toggle = '0') then
                        pwm_out <= '0';
                    else
                        pwm_out <= '0';
                    end if;
                    state_of_machine <= load_new_duty;
                elsif (count > d12 and count < boundary) then
                    if (toggle = '0') then
                        pwm_out <= '0';
                    else
                        pwm_out <= '0';
                    end if;
                    state_of_machine <= pwm_low;
                elsif (d1 = 0 and d2 = 0 and count < boundary) then
                    if (toggle = '0') then
                        pwm_out <= '0';
                    else
                        pwm_out <= '0';
                    end if;
                    state_of_machine <= pwm_low;
                end if;
            
            when pwm_high =>
                count := count + 1;
                if (count < boundary and count < d12) then
                    pwm_out <= '1';
                    state_of_machine <= pwm_high;
                elsif (count = d12) then
                    if (toggle = '0') then
                        pwm_out <= '0';
                    else
                        pwm_out <= '0';
                    end if;
                    state_of_machine <= pwm_low;
                elsif (count >= boundary) then
                    if (toggle = '0') then
                        pwm_out <= '0';
                    else
                        pwm_out <= '0';
                    end if;
                    state_of_machine <= load_new_duty;
                end if;
        
        end case;
        
    end if;
    
    end process;

end Behavioral;

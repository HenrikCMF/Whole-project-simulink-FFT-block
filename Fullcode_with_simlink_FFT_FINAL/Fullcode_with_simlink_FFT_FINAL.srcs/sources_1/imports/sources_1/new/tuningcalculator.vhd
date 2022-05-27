----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2022 02:20:20 PM
-- Design Name: 
-- Module Name: tuningcalculator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tuningcalculator is
    Port ( clk : in STD_LOGIC;
    leds: inout STD_logic_vector(7 downto 0);
    note: in unsigned(10 downto 0)
    );
    
end tuningcalculator;

architecture Behavioral of tuningcalculator is
signal s: std_logic_vector(7 downto 0) := "00000000";
signal freq, t, q, r: integer;



begin

process(clk)
begin

if rising_edge(clk) then
freq <= to_integer(note);
leds <= s;
 --LED indicator for accuracy first low e-string
    if (freq>41) and (freq<96) then --determening in which range the found frequency is
         if freq>82 then --different percentage calculation have to be done to depending on if the note is above
         -- or below the fundamental frequency.
         t<=freq-82; --t,q and r are used as intermediat steps for percentage calculation
         q <= (t*312195); -- this number is the range from the fundamental frequency to the edge of the range multiplyed by 128
         --to be displayed as a signed values using the LEDs (It is so large to have as much accuracy as possible, 
         --even when dealing with floating point numbers.
         r <= q/100000; -- division to reduce the scale and make it fit into 8 bits.
         s<= std_logic_vector(to_signed(r, 8)) ;
        
         else
         t<=freq-82;
         q <= (t*914286);
         r <= q/100000;
         s<= std_logic_vector(to_signed(r, 8)) ;
         end if;
    end if;
    -- second string A, mathermaticl calculations are of the same basic idea. The numbers have been adjusted for the new frequency and it range.
    if (freq>=96) and (freq<128) then
         if freq>110 then
         t<=freq-110;
         q <= (t*8);
         r <= q;
         s<= std_logic_vector(to_signed(r, 8)) ;
        
         else
         t<=freq-110;
         q <= (t*711111);
         r <= q/100000;
         s<= std_logic_vector(to_signed(r, 8)) ;
         end if;
    end if;
    -- thirs string D
    if (freq>=128) and (freq<171) then
         if freq>146 then
         t<=freq-146;
         q <= (t*711111);
         r <= q/100000;
         s<= std_logic_vector(to_signed(r, 8)) ;
        
         else
         t<=freq-146;
         q <= (t*512);
         r <= q/100;
         s<= std_logic_vector(to_signed(r, 8)) ;
         end if;
    end if;
    --fourth string G
    if (freq>=171) and (freq<221) then
         if freq>196 then
         t<=freq-196;
         q <= (t*512);
         r <= q/100;
         s<= std_logic_vector(to_signed(r, 8)) ;
        
         else
         t<=freq-196;
         q <= (t*512);
         r <= q/100;
         s<= std_logic_vector(to_signed(r, 8)) ;
         end if;
    end if;
    -- Fith string B
    if (freq>=221) and (freq<288) then
         if freq>246 then
         t<=freq-246;
         q <= (t*512);
         r <= q/100;
         s<= std_logic_vector(to_signed(r, 8)) ;
        
         else
         t<=freq-246;
         q <= (t*304762);
         r <= q/100000;
         s<= std_logic_vector(to_signed(r, 8)) ;
         end if;
    end if;
    --Sixth string High E
    if (freq>=288) and (freq<350) then
         if freq>329 then
         t<=freq-329;
         q <= (t*312195);
         r <= q/100000;
         s<= std_logic_vector(to_signed(r, 8)) ;
        
         else
         t<=freq-329;
         q <= (t*609524);
         r <= q/100000;
         s<= std_logic_vector(to_signed(r, 8)) ;
         end if;
    end if;
end if;
end process;

end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2022 13:39:56
-- Design Name: 
-- Module Name: peakfinder - Behavioral
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
package un512 is
type unsigned_512 is array (1 to 512) of unsigned(32 downto 0);
end package un512;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.un512.all;
--Component to find the highest value and that values lowest frequency harmonic.
entity peakfinder is
    Port ( clk : in STD_LOGIC;
           en  : in STD_LOGIC;
           out512: in unsigned_512;
           result : out unsigned(10 downto 0));
end peakfinder;

architecture Behavioral of peakfinder is
type PF_states is (findpeak, findharmonic, pushresult, idle);
type samples_512 is array (1 to 512) of std_logic_vector(32 downto 0);
type unsigned_8 is array (1 to 8) of unsigned(32 downto 0);
signal k: integer range 1 to 512;
signal res512: unsigned_512;
signal maxindex,finalindex,ll: integer range 1 to 512;
signal FFTmax: unsigned(32 downto 0):=(others => '0');
signal FFTtracker: integer range 1 to 512:=1;
signal harmonics: unsigned_8;
signal checkflag: bit:='0';
signal increment,decrement: integer range 1 to 8;
signal peakfinder: PF_states:=idle;
signal tempres: unsigned(10 downto 0);
begin

-- Component is divided into 2 state machines:
--1: state machine control which contains state change conditions.
process(clk)
begin
if rising_edge(clk) then
case peakfinder is
    when idle =>
        if en='1' then --If component enable is sent in,  go to find highest value
            peakfinder<=findpeak;
        else
            peakfinder<=idle;
        end if;
    when findpeak =>
        if k=512 then --if all values have been scanned go to find lowest frequency harmonic
            peakfinder<=findharmonic;
        else
            peakfinder<=findpeak;
        end if;
    when findharmonic =>
        if increment=8 then --If all 8 possible harmonics have been searched for, go to find lowest one
            peakfinder<=pushresult;
        else
            peakfinder<=findharmonic;
        end if;
    when pushresult =>
        if checkflag='1' or decrement=1 then --when lowest frequency has been selected go output and wait for new samples
            peakfinder<=idle;
        else
            peakfinder<=pushresult;
        end if;
end case;
end if;
end process;

-- 2nd part of state machine, which does all the functions
process(clk)
begin
if rising_edge(clk) then
case peakfinder is
    when idle => --input new samples, output results and reset parameters.
        res512<=out512;
        result<=tempres;
        k<=1;
        FFTmax<=(others => '0');
        increment<=1;
        harmonics(1)<=(others => '0');
        harmonics(2)<=(others => '0');
        harmonics(3)<=(others => '0');
        harmonics(4)<=(others => '0');
        harmonics(5)<=(others => '0');
        harmonics(6)<=(others => '0');
        harmonics(7)<=(others => '0');
        harmonics(8)<=(others => '0');
        checkflag<='0';
        decrement<=8;
        ll<=1;
    when findpeak => --Scans through every value looking for the largest one.
        if res512(k)>FFTmax then
            maxindex<=k;
            FFTmax<=res512(k);
            ll<=k; --bugfix
        end if;
        k<=k+1;
    when findharmonic => --Looks for harmonics at lower frequencies that have an amplitude above a certain value
    -- more detailed description in report
        if res512(ll)>"001000000000000000000000000000000" and ll>1 then--1073741824 then
            harmonics(increment)<=to_unsigned(Maxindex/increment,33);
        elsif maxindex=1 then
            harmonics(increment)<="000000000000000000000000000000001";
        else
            harmonics(increment)<=(others => '0');
        end if;
        if (Maxindex/(increment+1))<1 then
            ll<=1;
        else
            ll<=(Maxindex/(increment+1));
        end if;
        increment<=increment+1;
    when pushresult => -- Find the lowest frequency value, this is done by assuming that the
    --highest index which is nonzero is the lowest frequency, which was defined in findharmonic
        if harmonics(decrement)>0 then
            finalindex<=to_integer(harmonics(decrement));
            checkflag<='1';
            tempres<=harmonics(decrement)(10 downto 0);
        else
            decrement<=decrement-1;
        end if;
end case;
end if;
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2022 11:23:22
-- Design Name: 
-- Module Name: sawtooth_gen - Behavioral
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

use IEEE.NUMERIC_STD.ALL;
entity sawtooth_gen is
    Port ( 
    clk : in STD_LOGIC;
    sawtooth : out STD_LOGIC_vector(23 downto 0));
end sawtooth_gen;
--Adjusts frequency of sine wave generator
architecture Behavioral of sawtooth_gen is
signal tempres: unsigned(23 downto 0):=(others=> '0');
begin
sawtooth<=STD_LOGIC_VECTOR(tempres);

process(clk)
begin
if rising_edge(clk) then
    if tempres>=8388507 then
        tempres<=(others=> '0');
    else
    --adjusting is done by changing how much it increments, system can be seen here
        tempres<=tempres+8; --94hz=+8, 192Hz=+16 384HZ=+32 143Hz=+12
    end if;
end if;
end process;
end Behavioral;

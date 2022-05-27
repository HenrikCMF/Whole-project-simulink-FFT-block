library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity upper is
    Port ( clk : in STD_LOGIC;
           sinres : inout STD_LOGIC_vector(23 downto 0);
           NWS    :   OUT   std_logic);
end upper;

-- Top layer function of sine wave generator, basically just puts the sine lookup table together with a ramp function
--and throttles how often an output is given to make it more like the frequency of the audio codec.
architecture Behavioral of upper is
component sawtooth_gen is
    Port ( 
    clk : in STD_LOGIC;
    sawtooth : out STD_LOGIC_vector(23 downto 0));
end component;

component singen IS
  PORT( clk                               :   IN    std_logic;
        reset_x                           :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        rampin                            :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        ce_out                            :   OUT   std_logic;
        sinout                            :   OUT   std_logic_vector(23 DOWNTO 0)  -- ufix24
        );
END component;

signal sawout: STD_LOGIC_vector(23 downto 0);
signal reset, clken, ceo: std_logic;
signal counter: unsigned(17 downto 0):="000000000000000001";
signal openflag: std_logic:='0';
begin
clken<='1';
ramp: sawtooth_gen port map(clk,sawout);
sine: singen port map(clk, reset, clken, sawout,ceo,sinres);

process (clk)

begin
if rising_edge(clk) then
if counter=2273 then --every 200083 clock cycles a sample will go out, meaning the 512 samples take ~1sec
    counter<="000000000000000001";
    NWS<='1';
else
    counter<=counter+1;
    NWS<='0';
end if;
end if;
end process;
end Behavioral;

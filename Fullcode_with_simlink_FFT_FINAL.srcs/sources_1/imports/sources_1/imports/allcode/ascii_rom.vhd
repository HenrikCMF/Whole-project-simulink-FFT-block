--
-- Written by Michael Mattioli
--
-- Description: ROM containing ASCII character data.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ascii_rom is
    port (  clk     : in std_logic; -- System clock
            addr    : in std_logic_vector (10 downto 0); -- Memory address
            dout    : out std_logic_vector (7 downto 0)); -- Data from memory
end ascii_rom;

architecture behavioral of ascii_rom is

    -- 1024 elements, 8 bits each
    type memory is array (0 to 1023) of std_logic_vector (7 downto 0);

    -- ASCII character data
    constant rom_data : memory := ( x"00", x"00", x"00", x"7f", x"7f", x"7f", x"70", x"70", --char 00 topleft corner of E
                                    x"00", x"00", x"00", x"ff", x"ff", x"ff", x"03", x"03", --char 01
                                    x"00", x"00", x"00", x"ff", x"ff", x"ff", x"80", x"80", --char 02
                                    x"00", x"00", x"00", x"fe", x"fe", x"fe", x"0e", x"0e", -- char 03
                                    x"70", x"70", x"70", x"70", x"70", x"70", x"70", x"70", -- char 04
                                    x"03", x"03", x"03", x"03", x"03", x"03", x"03", x"03", -- char 05
                                    x"80", x"80", x"80", x"80", x"80", x"80", x"80", x"80", -- char 06
                                    x"0e", x"0e", x"0e", x"0e", x"0e", x"0e", x"0e", x"0e", -- char 07
                                    x"03", x"03", x"03", x"03", x"03", x"00", x"00", x"00", -- char 08
                                    x"80", x"80", x"80", x"80", x"80", x"00", x"00", x"00", -- char 09
                                    x"70", x"70", x"00", x"00", x"00", x"00", x"00", x"00", -- char 0a
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", -- char 0b used for everything empty
                                    x"0e", x"0e", x"00", x"00", x"00", x"00", x"00", x"00", --char 0c
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"78", -- 0d
                                    x"48", x"47", x"40", x"40", x"40", x"4e", x"79", x"00", --0e
                                    x"00", x"00", x"e0", x"1e", x"01", x"00", x"ce", x"49", --0f
                                    x"00", x"00", x"00", x"00", x"bf", x"39", x"01", x"01", --10
                                    x"00", x"79", x"4e", x"40", x"40", x"40", x"47", x"48", --11
                                    x"49", x"ce", x"00", x"01", x"1e", x"e0", x"00", x"00", --12
                                    x"01", x"01", x"39", x"bf", x"00", x"00", x"00", x"00", --13
                                    x"78", x"00", x"00", x"00", x"00", x"00", x"00", x"00", --14
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"01", x"03", --15
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"ff", x"ff", --16
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"fc", x"fe", --17
                                    x"07", x"07", x"1f", x"3f", x"7c", x"70", x"70", x"70", --18
                                    x"ff", x"ff", x"c0", x"00", x"00", x"00", x"00", x"00", --19
                                    x"ff", x"ff", x"1f", x"07", x"01", x"00", x"00", x"00", --1a
                                    x"00", x"00", x"c0", x"e0", x"f0", x"70", x"70", x"70", --1b
                                    x"70", x"70", x"70", x"70", x"70", x"70", x"7c", x"3e", --1c
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"01", x"03",--1d
                                    x"70", x"70", x"70", x"70", x"70", x"70", x"f0", x"e0", --1e
                                    x"1f", x"07", x"07", x"03", x"01", x"00", x"00", x"00", --1f
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", --20
                                    x"07", x"07", x"07", x"06", x"04", x"00", x"00", x"00",--21
                                    x"c0", x"00", x"00", x"00", x"00", x"00", x"00", x"00", --22
                                    x"ff", x"ff", x"c0", x"00", x"00", x"00", x"00", x"00", --23
                                    x"38", x"38", x"38", x"38", x"38", x"38", x"38", x"38", --24
                                    x"38", x"38", x"f8", x"f8", x"f8", x"c0", x"00", x"00", --25
                                    x"00", x"00", x"00", x"00", x"7f", x"7f", x"7f", x"70", --26
                                    x"00", x"00", x"00", x"00", x"ff", x"ff", x"ff", x"00", --27
                                    x"00", x"00", x"00", x"00", x"f0", x"f0", x"f0", x"70", --28
                                    x"7c", x"3c", x"1f", x"07", x"07", x"03", x"01", x"00", --29
                                    x"00", x"00", x"00", x"00", x"00", x"ff", x"ff", x"7f", --2a
                                    x"01", x"01", x"07", x"07", x"07", x"fe", x"fc", x"00", --2b
                                    x"f0", x"e0", x"c0", x"00", x"00", x"00", x"00", x"00",--2c
                                    x"70", x"70", x"70", x"70", x"70", x"70", x"78", x"7c", --2d
                                    x"03", x"03", x"03", x"03", x"03", x"03", x"07", x"0f", --2e
                                    x"80", x"80", x"80", x"80", x"80", x"80", x"c0", x"e0", --2f
                                    x"0e", x"0e", x"0e", x"0e", x"0e", x"0e", x"1e", x"3e", --30
                                    x"7f", x"7f", x"07", x"03", x"01", x"00", x"00", x"00", --31
                                    x"ff", x"fc", x"fc", x"f8", x"f0", x"00", x"00", x"00", --32
                                    x"ff", x"7f", x"3f", x"1f", x"0f", x"00", x"00", x"00", --33
                                    x"fe", x"fe", x"f0", x"e0", x"c0", x"00", x"00", x"00", --34
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"1f", x"00", --35
                                    x"00", x"00", x"00", x"00", x"00", x"00", x"fe", x"80", --36
                                    x"00", x"00", x"00", x"1f", x"00", x"00", x"00", x"00", --37
                                    x"80", x"80", x"80", x"fe", x"00", x"00", x"00", x"00", --38
                                    x"00", x"06", x"09", x"49", x"29", x"1e", x"00", x"00",
                                    x"00", x"00", x"00", x"12", x"00", x"00", x"00", x"00",
                                    x"00", x"00", x"00", x"52", x"30", x"00", x"00", x"00",
                                    x"00", x"00", x"08", x"14", x"14", x"22", x"00", x"00",
                                    x"00", x"14", x"14", x"14", x"14", x"14", x"14", x"00",
                                    x"00", x"00", x"22", x"14", x"14", x"08", x"00", x"00",
                                    x"00", x"02", x"01", x"59", x"05", x"02", x"00", x"00",
                                    x"3e", x"41", x"5d", x"55", x"4d", x"51", x"2e", x"00",
                                    x"40", x"7c", x"4a", x"09", x"4a", x"7c", x"40", x"00",
                                    x"41", x"7f", x"49", x"49", x"49", x"49", x"36", x"00",
                                    x"1c", x"22", x"41", x"41", x"41", x"41", x"22", x"00",
                                    x"41", x"7f", x"41", x"41", x"41", x"22", x"1c", x"00",
                                    x"41", x"7f", x"49", x"49", x"5d", x"41", x"63", x"00",
                                    x"41", x"7f", x"49", x"09", x"1d", x"01", x"03", x"00",
                                    x"1c", x"22", x"41", x"49", x"49", x"3a", x"08", x"00",
                                    x"41", x"7f", x"08", x"08", x"08", x"7f", x"41", x"00",
                                    x"00", x"41", x"41", x"7F", x"41", x"41", x"00", x"00",
                                    x"30", x"40", x"41", x"41", x"3F", x"01", x"01", x"00",
                                    x"41", x"7f", x"08", x"0c", x"12", x"61", x"41", x"00",
                                    x"41", x"7f", x"41", x"40", x"40", x"40", x"60", x"00",
                                    x"41", x"7f", x"42", x"0c", x"42", x"7f", x"41", x"00",
                                    x"41", x"7f", x"42", x"0c", x"11", x"7f", x"01", x"00",
                                    x"1c", x"22", x"41", x"41", x"41", x"22", x"1c", x"00",
                                    x"41", x"7f", x"49", x"09", x"09", x"09", x"06", x"00",
                                    x"0c", x"12", x"21", x"21", x"61", x"52", x"4c", x"00",
                                    x"41", x"7f", x"09", x"09", x"19", x"69", x"46", x"00",
                                    x"66", x"49", x"49", x"49", x"49", x"49", x"33", x"00",
                                    x"03", x"01", x"41", x"7f", x"41", x"01", x"03", x"00",
                                    x"01", x"3f", x"41", x"40", x"41", x"3f", x"01", x"00",
                                    x"01", x"0f", x"31", x"40", x"31", x"0f", x"01", x"00",
                                    x"01", x"1f", x"61", x"14", x"61", x"1f", x"01", x"00",
                                    x"41", x"41", x"36", x"08", x"36", x"41", x"41", x"00",
                                    x"01", x"03", x"44", x"78", x"44", x"03", x"01", x"00",
                                    x"43", x"61", x"51", x"49", x"45", x"43", x"61", x"00",
                                    x"00", x"00", x"7f", x"41", x"41", x"00", x"00", x"00",
                                    x"01", x"02", x"04", x"08", x"10", x"20", x"40", x"00",
                                    x"00", x"00", x"41", x"41", x"7f", x"00", x"00", x"00",
                                    x"00", x"04", x"02", x"01", x"01", x"02", x"04", x"00",
                                    x"00", x"40", x"40", x"40", x"40", x"40", x"40", x"00",
                                    x"00", x"01", x"02", x"00", x"00", x"00", x"00", x"00",
                                    x"00", x"34", x"4a", x"4a", x"4a", x"3c", x"40", x"00",
                                    x"00", x"41", x"3f", x"48", x"48", x"48", x"30", x"00",
                                    x"00", x"3c", x"42", x"42", x"42", x"24", x"00", x"00",
                                    x"00", x"30", x"48", x"48", x"49", x"3f", x"40", x"00",
                                    x"00", x"3c", x"4a", x"4a", x"4a", x"2c", x"00", x"00",
                                    x"00", x"00", x"48", x"7e", x"49", x"09", x"00", x"00",
                                    x"00", x"26", x"49", x"49", x"49", x"3f", x"01", x"00",
                                    x"41", x"7f", x"48", x"04", x"44", x"78", x"40", x"00",
                                    x"00", x"00", x"44", x"7d", x"40", x"00", x"00", x"00",
                                    x"00", x"00", x"40", x"44", x"3d", x"00", x"00", x"00",
                                    x"41", x"7f", x"10", x"18", x"24", x"42", x"42", x"00",
                                    x"00", x"40", x"41", x"7f", x"40", x"40", x"00", x"00",
                                    x"42", x"7e", x"02", x"7c", x"02", x"7e", x"40", x"00",
                                    x"42", x"7e", x"44", x"02", x"42", x"7c", x"40", x"00",
                                    x"00", x"3c", x"42", x"42", x"42", x"3c", x"00", x"00",
                                    x"00", x"41", x"7f", x"49", x"09", x"09", x"06", x"00",
                                    x"00", x"06", x"09", x"09", x"49", x"7f", x"41", x"00",
                                    x"00", x"42", x"7e", x"44", x"02", x"02", x"04", x"00",
                                    x"00", x"64", x"4a", x"4a", x"4a", x"36", x"00", x"00",
                                    x"00", x"04", x"3f", x"44", x"44", x"20", x"00", x"00",
                                    x"00", x"02", x"3e", x"40", x"40", x"22", x"7e", x"40",
                                    x"02", x"0e", x"32", x"40", x"32", x"0e", x"02", x"00",
                                    x"02", x"1e", x"62", x"18", x"62", x"1e", x"02", x"00",
                                    x"42", x"62", x"14", x"08", x"14", x"62", x"42", x"00",
                                    x"01", x"43", x"45", x"38", x"05", x"03", x"01", x"00",
                                    x"00", x"46", x"62", x"52", x"4a", x"46", x"62", x"00",
                                    x"00", x"00", x"08", x"36", x"41", x"00", x"00", x"00",
                                    x"00", x"00", x"00", x"7f", x"00", x"00", x"00", x"00",
                                    x"00", x"00", x"00", x"41", x"36", x"08", x"00", x"00",
                                    x"00", x"18", x"08", x"08", x"10", x"10", x"18", x"00",
                                    x"AA", x"55", x"AA", x"55", x"AA", x"55", x"AA", x"55");

begin

    process (clk)
    begin
        if rising_edge(clk) then
            dout <= rom_data(conv_integer(addr));
        end if;
    end process;

end behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity oled_ex is
    port (  button      : in std_logic_vector(3 downto 0);
            clk         : in std_logic; -- System clock
            rst         : in std_logic; -- Global synchronous reset
            en          : in std_logic; -- Block enable pin
            sdout       : out std_logic; -- SPI data out
            oled_sclk   : out std_logic; -- SPI clock
            oled_dc     : out std_logic; -- Data/Command controller
            fin         : out std_logic); -- Finish flag for block
end oled_ex;

architecture behavioral of oled_ex is

    -- SPI controller
    component spi_ctrl
        port (  clk         : in std_logic;
                rst         : in std_logic;
                en          : in std_logic;
                sdata       : in std_logic_vector (7 downto 0);
                sdout       : out std_logic;
                oled_sclk   : out std_logic;
                fin         : out std_logic);
    end component;

    -- delay controller
    component delay
        port (  clk         : in std_logic;
                rst         : in std_logic;
                delay_ms    : in std_logic_vector (11 downto 0);
                delay_en    : in std_logic;
                delay_fin   : out std_logic);
    end component;

    -- character library, latency = 1
    component ascii_rom
        port (  clk    : in std_logic; -- System clock
                addr   : in std_logic_vector (10 downto 0); -- First 8 bits is the ASCII value of the character, the last 3 bits are the parts of the char
                dout   : out std_logic_vector (7 downto 0)); -- Data byte out
    end component;

    -- States for state machine
    type states is (Idle,
                    ClearDC,
                    SetPage,
                    PageNum,
                    LeftColumn1,
                    LeftColumn2,
                    SetDC,
                    ClearScreen,
                    reset,
                    wait1,
                    Wait2,
                    selecter,
                    UpdateScreen,
                    SendChar1,
                    SendChar2,
                    SendChar3,
                    SendChar4,
                    SendChar5,
                    SendChar6,
                    SendChar7,
                    SendChar8,
                    ReadMem,
                    ReadMem2,
                    Done,
                    Transition1,
                    Transition2,
                    Transition3,
                    Transition4,
                    Transition5);

    type oled_mem is array (0 to 3, 0 to 15) of std_logic_vector (7 downto 0);

    -- Variable that contains what the screen will be after the next UpdateScreen state
    signal current_screen : oled_mem;


-- All the designed screens that are used, plus an added C, which was made accidentally
    constant clear_screen : oled_mem := (   (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"20"));

    constant E_screen : oled_mem := (         (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"03", x"07", x"07", x"0c", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"02", x"06", x"09", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"01", x"05", x"08", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"00", x"04", x"04", x"0a", x"20", x"20", x"20", x"20", x"20"));
                                            
 constant A_screen : oled_mem := (          (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"0b", x"0b", x"0b", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"0b", x"10", x"13", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"0b", x"0f", x"12", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"0d", x"0e", x"11", x"14", x"20", x"20", x"20", x"20", x"20"));
                                           
constant C_screen : oled_mem := (           (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"0b", x"1b", x"1e", x"22", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"17", x"1a", x"1d", x"21", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"16", x"19", x"0b", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"15", x"18", x"1c", x"1f", x"20", x"20", x"20", x"20", x"20"));
                                            
constant G_screen : oled_mem := (           (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"0b", x"1b", x"1e", x"22", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"17", x"1a", x"1d", x"21", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"16", x"23", x"24", x"25", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"15", x"18", x"1c", x"1f", x"20", x"20", x"20", x"20", x"20"));
                                            
constant D_screen : oled_mem := (           (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"28", x"04", x"2c", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"27", x"0b", x"2b", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"27", x"0b", x"2a", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"26", x"04", x"29", x"0b", x"20", x"20", x"20", x"20", x"20"));
                                          
constant B_screen : oled_mem := (           (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"03", x"07", x"30", x"34", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"02", x"06", x"2f", x"33", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"01", x"05", x"2e", x"32", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"00", x"04", x"2d", x"31", x"20", x"20", x"20", x"20", x"20"));
                                            
  constant EH_screen : oled_mem := (         (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"03", x"07", x"07", x"0c", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"02", x"06", x"09", x"0b", x"20", x"20", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"01", x"05", x"08", x"0b", x"36", x"38", x"20", x"20", x"20"),
                                            (x"20", x"20", x"20", x"20", x"20", x"20", x"20", x"00", x"04", x"04", x"0a", x"35", x"37", x"20", x"20", x"20"));

    -- Current overall state of the state machine
    signal current_state : states := Idle;

    -- State to go to after the SPI transmission is finished
    signal after_state : states;

    -- State to go to after the set page sequence
    signal after_page_state : states;

    -- State to go to after sending the character sequence
    signal after_char_state : states;

    -- State to go to after the UpdateScreen is finished
    signal after_update_state : states;

    -- Contains the value to be outputted to oled_dc
    signal temp_dc : std_logic := '0';

    -- Used in the Delay controller block
    signal temp_delay_ms : std_logic_vector (11 downto 0); -- Amount of ms to delay
    signal temp_delay_en : std_logic := '0'; -- Enable signal for the Delay block
    signal temp_delay_fin : std_logic; -- Finish signal for the Delay block

    -- Used in the SPI controller block
    signal temp_spi_en : std_logic := '0'; -- Enable signal for the SPI block
    signal temp_sdata : std_logic_vector (7 downto 0) := (others => '0'); -- Data to be sent out on SPI
    signal temp_spi_fin : std_logic; -- Finish signal for the SPI block

    signal temp_char : std_logic_vector (7 downto 0) := (others => '0'); -- Contains ASCII value for character
    signal temp_addr : std_logic_vector (10 downto 0) := (others => '0'); -- Contains address to byte needed in memory
    signal temp_dout : std_logic_vector (7 downto 0); -- Contains byte outputted from memory
    signal temp_page : std_logic_vector (1 downto 0) := (others => '0'); -- Current page
    signal temp_index : integer range 0 to 15 := 0; -- Current character on page

begin

    oled_dc <= temp_dc;

    -- "Example" finish flag only high when in done state
    fin <= '1' when current_state = Done else '0';

    -- Instantiate SPI controller
    spi_comp: spi_ctrl port map (   clk => clk,
                                    rst => rst,
                                    en => temp_spi_en,
                                    sdata => temp_sdata,
                                    sdout => sdout,
                                    oled_sclk => oled_sclk,
                                    fin => temp_spi_fin);

    -- Instantiate delay
    delay_comp: delay port map (clk => clk,
                                rst => rst,
                                delay_ms => temp_delay_ms,
                                delay_en => temp_delay_en,
                                delay_fin => temp_delay_fin);

    -- Instantiate ASCII character library
    char_lib_comp : ascii_rom port map (clk => clk,
                                        addr => temp_addr,
                                        dout => temp_dout);

    process (clk)
    begin
        if rising_edge(clk) then
            case current_state is
                -- Idle until en pulled high than intialize Page to 0 and go to state clearscreen after
                when Idle =>
                    if en = '1' then
                        current_state <= ClearDC;
                        after_page_state <= clearscreen;
                        temp_page <= "00";
                    end if;
 
--When cleared go to the screen selecter
                when ClearScreen =>
                    current_screen <= clear_screen;
                    after_update_state <= Wait1;
                    current_state <= UpdateScreen;
                when Wait1 =>
                    temp_delay_ms <= "000011101000";
                    after_state <= reset;
                    current_state <= Transition3; 
                when reset =>
                    current_screen <= clear_screen;
                    after_update_state <= Wait2;
                    current_state <= UpdateScreen;
                when Wait2 =>
                temp_delay_ms <= "000001101000";
                after_state <= selecter;
                current_state <= Transition3; 
                when selecter =>
                    if button="0000" then
                        current_screen <= E_screen;
                    elsif button="0001" then   
                        current_screen <= A_screen;
                    elsif button="0010" then   
                        current_screen <= D_screen;
                    elsif button="0011" then   
                        current_screen <= G_screen;
                    elsif button="0100" then   
                        current_screen <= B_screen;
                    elsif button="0101" then   
                        current_screen <= EH_screen; 
                    elsif button="0110" then   
                        current_screen <= clear_screen;     
                    end if;
                    after_update_state <= Wait2;
                    current_state <= UpdateScreen;
                -- Do nothing until en is deassertted and then current_state is Idle
                when Done            =>
                    if en = '0' then
                        current_state <= Idle;
                    end if;

                -- UpdateScreen State
                -- 1. Gets ASCII value from current_screen at the current page and the current spot
                --    of the page
                -- 2. If on the last character of the page transition update the page number, if on
                --    the last page(3) then the updateScreen go to "after_update_state" after
                when UpdateScreen =>
                    temp_char <= current_screen(conv_integer(temp_page), temp_index);
                    if temp_index = 15 then
                        temp_index <= 0;
                        temp_page <= temp_page + 1;
                        after_char_state <= ClearDC;
                        if temp_page = "11" then
                            after_page_state <= after_update_state;
                        else
                            after_page_state <= UpdateScreen;
                        end if;
                    else
                        temp_index <= temp_index + 1;
                        after_char_state <= UpdateScreen;
                    end if;
                    current_state <= SendChar1;

                -- Update Page states
                -- 1. Sets oled_dc to command mode
                -- 2. Sends the SetPage Command
                -- 3. Sends the Page to be set to
                -- 4. Sets the start pixel to the left column
                -- 5. Sets oled_dc to data mode
                when ClearDC =>
                    temp_dc <= '0';
                    current_state <= SetPage;
                when SetPage =>
                    temp_sdata <= "00100010";
                    after_state <= PageNum;
                    current_state <= Transition1;
                when PageNum =>
                    temp_sdata <= "000000" & temp_page;
                    after_state <= LeftColumn1;
                    current_state <= Transition1;
                when LeftColumn1 =>
                    temp_sdata <= "00000000";
                    after_state <= LeftColumn2;
                    current_state <= Transition1;
                when LeftColumn2 =>
                    temp_sdata <= "00010000";
                    after_state <= SetDC;
                    current_state <= Transition1;
                when SetDC =>
                    temp_dc <= '1';
                    current_state <= after_page_state;
                -- End update Page states

                -- Send character states
                -- 1. Sets the address to ASCII value of character with the counter appended to the
                --    end
                -- 2. Waits a clock cycle for the data to get ready by going to ReadMem and ReadMem2
                --    states
                -- 3. Send the byte of data given by the ROM
                -- 4. Repeat 7 more times for the rest of the character bytes
                when SendChar1 =>
                    temp_addr <= temp_char & "000";
                    after_state <= SendChar2;
                    current_state <= ReadMem;
                when SendChar2 =>
                    temp_addr <= temp_char & "001";
                    after_state <= SendChar3;
                    current_state <= ReadMem;
                when SendChar3 =>
                    temp_addr <= temp_char & "010";
                    after_state <= SendChar4;
                    current_state <= ReadMem;
                when SendChar4 =>
                    temp_addr <= temp_char & "011";
                    after_state <= SendChar5;
                    current_state <= ReadMem;
                when SendChar5 =>
                    temp_addr <= temp_char & "100";
                    after_state <= SendChar6;
                    current_state <= ReadMem;
                when SendChar6 =>
                    temp_addr <= temp_char & "101";
                    after_state <= SendChar7;
                    current_state <= ReadMem;
                when SendChar7 =>
                    temp_addr <= temp_char & "110";
                    after_state <= SendChar8;
                    current_state <= ReadMem;
                when SendChar8 =>
                    temp_addr <= temp_char & "111";
                    after_state <= after_char_state;
                    current_state <= ReadMem;
                when ReadMem =>
                    current_state <= ReadMem2;
                when ReadMem2 =>
                    temp_sdata <= temp_dout;
                    current_state <= Transition1;
                -- End send character states

                -- SPI transitions
                -- 1. Set en to 1
                -- 2. Waits for spi_ctrl to finish
                -- 3. Goes to clear state (Transition5)
                when Transition1 =>
                    temp_spi_en <= '1';
                    current_state <= Transition2;
                when Transition2 =>
                    if temp_spi_fin = '1' then
                        current_state <= Transition5;
                    end if;
                -- End SPI transitions

                -- Delay transitions
                -- 1. Set delay_en to 1
                -- 2. Waits for delay to finish
                -- 3. Goes to Clear state (Transition5)
                when Transition3 =>
                    temp_delay_en <= '1';
                    current_state <= Transition4;
                when Transition4 =>
                    if temp_delay_fin = '1' then
                        current_state <= Transition5;
                    end if;
                -- End Delay transitions

                -- Clear transition
                -- 1. Sets both delay_en and en to 0
                -- 2. Go to after state
                when Transition5 =>
                    temp_spi_en <= '0';
                    temp_delay_en <= '0';
                    current_state <= after_state;
                -- End Clear transition

                when others =>
                    current_state <= Idle;
            end case;
        end if;
    end process;

end behavioral;

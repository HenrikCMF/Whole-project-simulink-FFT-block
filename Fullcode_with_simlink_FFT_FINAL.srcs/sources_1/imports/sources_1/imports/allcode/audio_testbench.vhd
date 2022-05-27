----------------------------------------------------------------------------------
--Test code made by Henrik
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

--self defined package so arrays can be used between components
package un512 is
type unsigned_512 is array (1 to 512) of unsigned(32 downto 0); 
end package un512;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.un512.all;

--Libraries so results can be printed to notepads
use STD.textio.all;
use ieee.std_logic_textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity audio_testbench is
Port ( clk_100  : in    STD_LOGIC; -- 100 mhz master takt 
       rst  : in    std_logic; --RST button for OLED
       AC_ADR0  : out   STD_LOGIC;  -- control signals to ADAU chip
       AC_ADR1  : out   STD_LOGIC;
       AC_GPIO0 : out   STD_LOGIC;  -- I2S MISO
       AC_GPIO1 : in    STD_LOGIC;  -- I2S MOSI
       AC_GPIO2 : in    STD_LOGIC;  -- I2S_bclk
       AC_GPIO3 : in    STD_LOGIC;  -- I2S_LR
       buttons  : in    STD_LOGIC_VECTOR(7 downto 0);--Test bttons, should be removed in final iteration
       AC_MCLK  : out   STD_LOGIC;
       AC_SCK   : out   STD_LOGIC;
       LEDs     : out std_logic_vector(7 downto 0);-- currently just connected to buttons.
       AC_SDA   : inout STD_LOGIC;
       oled_sdin   : out std_logic; --OLED control pins
       oled_sclk   : out std_logic;
       oled_dc     : out std_logic;
       oled_res    : out std_logic;
       oled_vbat   : out std_logic;
       oled_vdd    : out std_logic
       );
end audio_testbench;

architecture Behavioral of audio_testbench is
component oled_ctrl is
    port (  clk         : in std_logic;
            rst         : in std_logic; --Sometimes RST should be pressed when loading the OLED screen, no idea why
            button      : in std_logic_vector(3 downto 0); --Lower 4 buttons used at the moment to control OLED screens
            oled_sdin   : out std_logic;
            oled_sclk   : out std_logic;
            oled_dc     : out std_logic;
            oled_res    : out std_logic;
            oled_vbat   : out std_logic;
            oled_vdd    : out std_logic);
end component;

component peakfinder is --Component to find highest peak and lowest frequency harmonic of peak
    Port ( clk : in STD_LOGIC;
           en  : in STD_LOGIC;
           out512: in unsigned_512;
           result : out unsigned(10 downto 0));
end component;
--the not working well FFT block, can be replaced, just replace FIFOfull with validout
-- and FFTout with output of your FFT.
component FFT_block IS 
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        line_in                           :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24
        new_sample                        :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        fifofull                          :   OUT   std_logic;
        fftout                            :   OUT   std_logic_vector(32 DOWNTO 0)  -- sfix33
        );
END component;

--Sine wave generator, currently connected to FFT block
--NWS is to control samples at a correct rate
component upper is
    Port ( clk : in STD_LOGIC;
           sinres : inout STD_LOGIC_vector(23 downto 0);
           NWS    : out std_logic);
end component;


--Audio codec, many things could be simplified, but I just have not touched it
COMPONENT audio_top
Port ( clk_100  : in    STD_LOGIC; -- 100 mhz input clock 
       AC_ADR0  : out   STD_LOGIC; -- contol signals to audio chip
       AC_ADR1  : out   STD_LOGIC;
       AC_GPIO0 : out   STD_LOGIC;  -- I2S MISO
       AC_GPIO1 : in    STD_LOGIC;  -- I2S MOSI
       AC_GPIO2 : in    STD_LOGIC;  -- I2S_bclk
       AC_GPIO3 : in    STD_LOGIC;  -- I2S_LR
       AC_MCLK  : out   STD_LOGIC;
       AC_SCK   : out   STD_LOGIC;
       AC_SDA   : inout STD_LOGIC;

       hphone_l  : in STD_LOGIC_VECTOR(23 downto 0);
       hphone_l_valid : in std_logic;
       hphone_r  : in STD_LOGIC_VECTOR(23 downto 0);
       hphone_r_valid_dummy : in std_logic;
       
       line_in_l    : out STD_LOGIC_VECTOR(23 downto 0); --primary output
       line_in_r    : out STD_LOGIC_VECTOR(23 downto 0);
       
       new_sample : out STD_LOGIC;     -- goes up for 1 clk cycle if new sample is transmitted received
       sample_clk_48k : out std_logic  -- sample clock 
       );
END COMPONENT;

    signal clk_100_buffered: std_logic;

    signal counter : unsigned (5 downto 0);
    signal screen  : std_logic_vector(3 downto 0);
    signal hphone_l, hphone_r : std_logic_vector (23 downto 0);
    signal hphone_valid: std_logic;
    signal new_sample,sampleflag, PFEN : std_logic;
    signal sample_clk_48k: std_logic;
    signal line_in_l, line_in_r, test_line_in : std_logic_vector (23 downto 0);
    signal FFTres, CLKEN, FFTceout, FIFOfull, NWS: std_logic;
    signal FFTout: std_logic_vector(32 downto 0):=(others => '0');
    signal FFTtracker: integer range 1 to 512:=1;
    signal finalindex: unsigned(10 downto 0);

    signal slowsample: integer range 1 to 2048;
    signal out512: unsigned_512;
    signal RAflag: std_logic:='0';
    signal result: unsigned(32 downto 0);
    
    --Stuff for printing to notepad
    file file_RESULTS : text;
    constant c_WIDTH : natural := 4;
    attribute keep : string;
    attribute keep of sample_clk_48k : signal is "true";
    attribute keep of hphone_l : signal is "true";
    attribute keep of hphone_r : signal is "true";
    
    attribute keep of line_in_l : signal is "true";
    attribute keep of line_in_r : signal is "true";

begin
--portmap for sinwave generator
singene: upper port map(clk_100, test_line_in, NWS);
-- port map for audio codec
i_audio : audio_top port map (
      clk_100  => clk_100_buffered, 
      AC_ADR0  => AC_ADR0,
      AC_ADR1  => AC_ADR1,
      AC_GPIO0 => AC_GPIO0,
      AC_GPIO1 => AC_GPIO1,
      AC_GPIO2 => AC_GPIO2,
      AC_GPIO3 => AC_GPIO3,
      AC_MCLK  => AC_MCLK,
      AC_SCK   => AC_SCK,
      AC_SDA   => AC_SDA,
      
      hphone_l  => hphone_l,
      hphone_l_valid => hphone_valid,
      hphone_r  => hphone_r,
      hphone_r_valid_dummy => hphone_valid,   --  this valid will be discarded later
      
      line_in_l => line_in_l,  
      line_in_r => line_in_r,

      new_sample => new_sample,
      sample_clk_48k => sample_clk_48k
     
   );

--Peak and harmonic finder port map
Maxindex: peakfinder port map(
                 clk=>clk_100, 
                 en=> PFEN,
                 out512=>out512,
                 result=>finalindex);
--Oled  port map
OLED: oled_ctrl port map(
            clk=>clk_100,
            rst=>rst,
            button=>screen,
            oled_sdin=>oled_sdin,
            oled_sclk=>oled_sclk,
            oled_dc=>oled_dc,
            oled_res=>oled_res,
            oled_vbat=>oled_vbat,
            oled_vdd=>oled_vdd);

-- Test stuff
LEDs<=std_logic_vector(finalindex(7 downto 0));
--screen<=buttons(3 downto 0); 
   
-- FFT block port map, inputs explained at component definition
FFT1: FFT_block port map(
        clk => clk_100,                              
        reset=> FFTres,                        
        clk_enable => CLKEN,                       
        line_in => line_in_l,                            
        new_sample => sampleflag,                  
        ce_out => FFTceout,                       
        FIFOfull => FIFOfull,                         
       fftout => FFTout
  );

CLKEN<='1';
--If there is a wish to slow down the rate of samples going into FFT, this process can be used
process (clk_100)
begin
if rising_edge(clk_100) then
    if new_sample='1' then
        if slowsample=93 then
            sampleflag<='1';
            slowsample<=slowsample+1;
        elsif slowsample=94 then
            sampleflag<='0';
            slowsample<=1;
        else
            slowsample<=slowsample+1;
        end if;
    end if;
end if;     
end process;


--Process to put 512 samples going from FFT block into an array , also prints the array into a notepad
process (clk_100)
--variable v_ILINE     : line;
--variable v_OLINE     : line;
--variable v_ADD_TERM1 : std_logic_vector(c_WIDTH-1 downto 0);
--variable v_ADD_TERM2 : std_logic_vector(c_WIDTH-1 downto 0);
--variable v_SPACE     : character;
begin
if rising_edge(clk_100) then
      
    if FIFOfull='1'  then
    
        if RAflag='0' then
            --file_open(file_RESULTS, "C:\Users\henri\Downloads\audioport_test3-20220502T155237Z-001\test.txt", write_mode);
            RAflag<='1';
        end if;
            --write(v_OLINE, to_integer(unsigned(FFTout)));
         --   write(v_OLINE, FFTout);
           -- writeline(file_RESULTS, v_OLINE);
            out512(FFTtracker)<=unsigned(FFTout);
            if FFTtracker=512 then
                FFTtracker<=1;
                PFEN<='1';
            else
                FFTtracker<=FFTtracker+1;
                
            end if;
     else
            FFTtracker<=1;
            PFEN<='0';
    end if;
end if;
end process;

--If there is a wish to directly catch samples coming from whatever input, this function can be used
--process(clk_100)
--begin
--if rising_edge(clk_100) then
--    if new_sample='1' then
--        out512(FFTtracker)<="000000000" & unsigned(test_line_in);
--        if FFTtracker=512 then
--           -- res512<=out512;
--            PFEN<='1';
--            FFTtracker<=1;
--         else
--            PFEN<='0';
--            FFTtracker<=FFTtracker+1;
--        end if;
--    end if;
--end if;
--end process;


--Process with not yet setup correct values to select the correct screen.
process(clk_100)
begin
if rising_edge(clk_100)then
    if finalindex>50 and finalINDEX<100 then
        screen<="0000";
        --LEDs<="00000001";
    elsif finalindex<100 and finalindex>50 then
        screen<="0001";
        --LEDs<="00000010";
    elsif finalindex<150 and finalindex>100 then
        screen<="0010";
        --LEDs<="00000100";
    elsif finalindex<200 and  finalindex>150 then
        screen<="0011";
        --LEDs<="00001000";
    elsif finalindex<250 and finalindex>200 then
        screen<="0100";
       -- LEDs<="00010000";
    elsif finalindex>250 and finalindex<300 then
        screen<="0101";
       -- LEDs<="00100000";
    elsif finalindex>350 then
        screen<="0110";
        --LEDs<="01000000";
    end if;
end if;
end process;

-- If there is a wish to loop back audio coming in to headphone jack, this process can be used
    -----------------------------------------------------
    -- TEST 2: loopback "line in" data to headphone output
--    process (clk_100)
--    begin
--        if (clk_100'event and clk_100 = '1') then
            
--            hphone_valid <= '0';
--            hphone_l <= (others => '0');
--            hphone_r <= (others => '0');
            
--            if new_sample = '1' then
--                counter <= counter + 1;
--                hphone_valid <= '1';
--               hphone_l <= line_in_l ;
--               hphone_r <= line_in_r;
--            end if;
            
--        end if;
--    end process;


    -- global clock buffer for the clock signal
    BUFG_inst : BUFG
    port map (
       O => clk_100_buffered,   -- 1-bit output: Clock output
       I => clk_100             -- 1-bit input: Clock input
    );  

end Behavioral;
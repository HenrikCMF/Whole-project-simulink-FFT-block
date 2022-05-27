-- -------------------------------------------------------------
-- 
-- File Name: C:\dokumenter\FFTblock\simulinktest\Complex4Multiply.vhd
-- Created: 2022-05-03 14:26:35
-- 
-- Generated by MATLAB 9.11 and HDL Coder 3.19
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Complex4Multiply
-- Source Path: simulinktest/FFT_block/FFT HDL Optimized/RADIX22FFT_SDF1_3/Complex4Multiply
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Complex4Multiply IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        din_re                            :   IN    std_logic_vector(26 DOWNTO 0);  -- sfix27
        din_im                            :   IN    std_logic_vector(26 DOWNTO 0);  -- sfix27
        din_3_vld_dly                     :   IN    std_logic;
        twdl_3_1_re                       :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En22
        twdl_3_1_im                       :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En22
        dinXTwdl_re                       :   OUT   std_logic_vector(26 DOWNTO 0);  -- sfix27
        dinXTwdl_im                       :   OUT   std_logic_vector(26 DOWNTO 0);  -- sfix27
        dinXTwdl_3_1_vld                  :   OUT   std_logic
        );
END Complex4Multiply;


ARCHITECTURE rtl OF Complex4Multiply IS

  -- Signals
  SIGNAL din_re_signed                    : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL din_re_reg                       : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL din_im_signed                    : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL din_im_reg                       : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL twdl_3_1_re_signed               : signed(23 DOWNTO 0);  -- sfix24_En22
  SIGNAL twdl_re_reg                      : signed(23 DOWNTO 0);  -- sfix24_En22
  SIGNAL twdl_3_1_im_signed               : signed(23 DOWNTO 0);  -- sfix24_En22
  SIGNAL twdl_im_reg                      : signed(23 DOWNTO 0);  -- sfix24_En22
  SIGNAL Complex4Multiply_din1_re_pipe1   : signed(26 DOWNTO 0) := to_signed(16#0000000#, 27);  -- sfix27
  SIGNAL Complex4Multiply_din1_im_pipe1   : signed(26 DOWNTO 0) := to_signed(16#0000000#, 27);  -- sfix27
  SIGNAL Complex4Multiply_mult1_re_pipe1  : signed(50 DOWNTO 0) := to_signed(0, 51);  -- sfix51
  SIGNAL Complex4Multiply_mult2_re_pipe1  : signed(50 DOWNTO 0) := to_signed(0, 51);  -- sfix51
  SIGNAL Complex4Multiply_mult1_im_pipe1  : signed(50 DOWNTO 0) := to_signed(0, 51);  -- sfix51
  SIGNAL Complex4Multiply_mult2_im_pipe1  : signed(50 DOWNTO 0) := to_signed(0, 51);  -- sfix51
  SIGNAL Complex4Multiply_twiddle_re_pipe1 : signed(23 DOWNTO 0) := to_signed(16#000000#, 24);  -- sfix24
  SIGNAL Complex4Multiply_twiddle_im_pipe1 : signed(23 DOWNTO 0) := to_signed(16#000000#, 24);  -- sfix24
  SIGNAL prod1_re                         : signed(50 DOWNTO 0) := to_signed(0, 51);  -- sfix51_En22
  SIGNAL prod1_im                         : signed(50 DOWNTO 0) := to_signed(0, 51);  -- sfix51_En22
  SIGNAL prod2_re                         : signed(50 DOWNTO 0) := to_signed(0, 51);  -- sfix51_En22
  SIGNAL prod2_im                         : signed(50 DOWNTO 0) := to_signed(0, 51);  -- sfix51_En22
  SIGNAL din_vld_dly1                     : std_logic;
  SIGNAL din_vld_dly2                     : std_logic;
  SIGNAL din_vld_dly3                     : std_logic;
  SIGNAL prod_vld                         : std_logic;
  SIGNAL Complex4Add_multRes_re_reg       : signed(51 DOWNTO 0);  -- sfix52
  SIGNAL Complex4Add_multRes_im_reg       : signed(51 DOWNTO 0);  -- sfix52
  SIGNAL Complex4Add_prod_vld_reg1        : std_logic;
  SIGNAL Complex4Add_prod1_re_reg         : signed(50 DOWNTO 0);  -- sfix51
  SIGNAL Complex4Add_prod1_im_reg         : signed(50 DOWNTO 0);  -- sfix51
  SIGNAL Complex4Add_prod2_re_reg         : signed(50 DOWNTO 0);  -- sfix51
  SIGNAL Complex4Add_prod2_im_reg         : signed(50 DOWNTO 0);  -- sfix51
  SIGNAL Complex4Add_multRes_re_reg_next  : signed(51 DOWNTO 0);  -- sfix52_En22
  SIGNAL Complex4Add_multRes_im_reg_next  : signed(51 DOWNTO 0);  -- sfix52_En22
  SIGNAL Complex4Add_sub_cast             : signed(51 DOWNTO 0);  -- sfix52_En22
  SIGNAL Complex4Add_sub_cast_1           : signed(51 DOWNTO 0);  -- sfix52_En22
  SIGNAL Complex4Add_add_cast             : signed(51 DOWNTO 0);  -- sfix52_En22
  SIGNAL Complex4Add_add_cast_1           : signed(51 DOWNTO 0);  -- sfix52_En22
  SIGNAL mulResFP_re                      : signed(51 DOWNTO 0);  -- sfix52_En22
  SIGNAL mulResFP_im                      : signed(51 DOWNTO 0);  -- sfix52_En22
  SIGNAL dinXTwdl_re_tmp                  : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL dinXTwdl_im_tmp                  : signed(26 DOWNTO 0);  -- sfix27

BEGIN
  din_re_signed <= signed(din_re);

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_re_reg <= to_signed(16#0000000#, 27);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        din_re_reg <= din_re_signed;
      END IF;
    END IF;
  END PROCESS intdelay_process;


  din_im_signed <= signed(din_im);

  intdelay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_im_reg <= to_signed(16#0000000#, 27);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        din_im_reg <= din_im_signed;
      END IF;
    END IF;
  END PROCESS intdelay_1_process;


  twdl_3_1_re_signed <= signed(twdl_3_1_re);

  intdelay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdl_re_reg <= to_signed(16#000000#, 24);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        twdl_re_reg <= twdl_3_1_re_signed;
      END IF;
    END IF;
  END PROCESS intdelay_2_process;


  twdl_3_1_im_signed <= signed(twdl_3_1_im);

  intdelay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdl_im_reg <= to_signed(16#000000#, 24);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        twdl_im_reg <= twdl_3_1_im_signed;
      END IF;
    END IF;
  END PROCESS intdelay_3_process;


  -- Complex4Multiply
  Complex4Multiply_1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        prod1_re <= Complex4Multiply_mult1_re_pipe1;
        prod2_re <= Complex4Multiply_mult2_re_pipe1;
        prod1_im <= Complex4Multiply_mult1_im_pipe1;
        prod2_im <= Complex4Multiply_mult2_im_pipe1;
        Complex4Multiply_mult1_re_pipe1 <= Complex4Multiply_din1_re_pipe1 * Complex4Multiply_twiddle_re_pipe1;
        Complex4Multiply_mult2_re_pipe1 <= Complex4Multiply_din1_im_pipe1 * Complex4Multiply_twiddle_im_pipe1;
        Complex4Multiply_mult1_im_pipe1 <= Complex4Multiply_din1_re_pipe1 * Complex4Multiply_twiddle_im_pipe1;
        Complex4Multiply_mult2_im_pipe1 <= Complex4Multiply_din1_im_pipe1 * Complex4Multiply_twiddle_re_pipe1;
        Complex4Multiply_twiddle_re_pipe1 <= twdl_re_reg;
        Complex4Multiply_twiddle_im_pipe1 <= twdl_im_reg;
        Complex4Multiply_din1_re_pipe1 <= din_re_reg;
        Complex4Multiply_din1_im_pipe1 <= din_im_reg;
      END IF;
    END IF;
  END PROCESS Complex4Multiply_1_process;


  intdelay_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        din_vld_dly1 <= din_3_vld_dly;
      END IF;
    END IF;
  END PROCESS intdelay_4_process;


  intdelay_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        din_vld_dly2 <= din_vld_dly1;
      END IF;
    END IF;
  END PROCESS intdelay_5_process;


  intdelay_6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly3 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        din_vld_dly3 <= din_vld_dly2;
      END IF;
    END IF;
  END PROCESS intdelay_6_process;


  intdelay_7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      prod_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        prod_vld <= din_vld_dly3;
      END IF;
    END IF;
  END PROCESS intdelay_7_process;


  -- Complex4Add
  Complex4Add_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Complex4Add_multRes_re_reg <= to_signed(0, 52);
      Complex4Add_multRes_im_reg <= to_signed(0, 52);
      Complex4Add_prod1_re_reg <= to_signed(0, 51);
      Complex4Add_prod1_im_reg <= to_signed(0, 51);
      Complex4Add_prod2_re_reg <= to_signed(0, 51);
      Complex4Add_prod2_im_reg <= to_signed(0, 51);
      Complex4Add_prod_vld_reg1 <= '0';
      dinXTwdl_3_1_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Complex4Add_multRes_re_reg <= Complex4Add_multRes_re_reg_next;
        Complex4Add_multRes_im_reg <= Complex4Add_multRes_im_reg_next;
        Complex4Add_prod1_re_reg <= prod1_re;
        Complex4Add_prod1_im_reg <= prod1_im;
        Complex4Add_prod2_re_reg <= prod2_re;
        Complex4Add_prod2_im_reg <= prod2_im;
        dinXTwdl_3_1_vld <= Complex4Add_prod_vld_reg1;
        Complex4Add_prod_vld_reg1 <= prod_vld;
      END IF;
    END IF;
  END PROCESS Complex4Add_process;

  Complex4Add_sub_cast <= resize(Complex4Add_prod1_re_reg, 52);
  Complex4Add_sub_cast_1 <= resize(Complex4Add_prod2_re_reg, 52);
  Complex4Add_multRes_re_reg_next <= Complex4Add_sub_cast - Complex4Add_sub_cast_1;
  Complex4Add_add_cast <= resize(Complex4Add_prod1_im_reg, 52);
  Complex4Add_add_cast_1 <= resize(Complex4Add_prod2_im_reg, 52);
  Complex4Add_multRes_im_reg_next <= Complex4Add_add_cast + Complex4Add_add_cast_1;
  mulResFP_re <= Complex4Add_multRes_re_reg;
  mulResFP_im <= Complex4Add_multRes_im_reg;

  dinXTwdl_re_tmp <= mulResFP_re(48 DOWNTO 22);

  dinXTwdl_re <= std_logic_vector(dinXTwdl_re_tmp);

  dinXTwdl_im_tmp <= mulResFP_im(48 DOWNTO 22);

  dinXTwdl_im <= std_logic_vector(dinXTwdl_im_tmp);

END rtl;


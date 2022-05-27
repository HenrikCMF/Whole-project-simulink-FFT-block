# timing constraints
create_clock -period 10.000 -name clk_100 [get_ports clk_100]

set_false_path -from [get_clocks zed_audio_clk_48M] -to [get_clocks clk_100]
set_false_path -from [get_clocks clk_100] -to [get_clocks zed_audio_clk_48M]


# 100 mhz clock
set_property PACKAGE_PIN Y9 [get_ports clk_100]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100]

# 24 mhz clock to audio chip
set_property PACKAGE_PIN AB2 [get_ports AC_MCLK]
set_property IOSTANDARD LVCMOS33 [get_ports AC_MCLK]


# I2S transfers audio samples
# i2s bit clock to ADAU1761
set_property PACKAGE_PIN Y8 [get_ports AC_GPIO0]
set_property IOSTANDARD LVCMOS33 [get_ports AC_GPIO0]

# i2s bit clock from ADAU1761
set_property PACKAGE_PIN AA7 [get_ports AC_GPIO1]
set_property IOSTANDARD LVCMOS33 [get_ports AC_GPIO1]

# i2s bit clock from ADAU1761
set_property PACKAGE_PIN AA6 [get_ports AC_GPIO2]
set_property IOSTANDARD LVCMOS33 [get_ports AC_GPIO2]

# i2s l/r 48 khz toggling signal from ADAU1761 (sample clock)
set_property PACKAGE_PIN Y6 [get_ports AC_GPIO3]
set_property IOSTANDARD LVCMOS33 [get_ports AC_GPIO3]


# I2C Data Interface to ADAU1761 (for configuration)
set_property PACKAGE_PIN AB4 [get_ports AC_SCK]
set_property IOSTANDARD LVCMOS33 [get_ports AC_SCK]

set_property PACKAGE_PIN AB5 [get_ports AC_SDA]
set_property IOSTANDARD LVCMOS33 [get_ports AC_SDA]

set_property PACKAGE_PIN AB1 [get_ports AC_ADR0]
set_property IOSTANDARD LVCMOS33 [get_ports AC_ADR0]

set_property PACKAGE_PIN Y5 [get_ports AC_ADR1]
set_property IOSTANDARD LVCMOS33 [get_ports AC_ADR1]

set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[0]}]
set_property PACKAGE_PIN T22 [get_ports {LEDs[0]}]
set_property PACKAGE_PIN T21 [get_ports {LEDs[1]}]
set_property PACKAGE_PIN U22 [get_ports {LEDs[2]}]
set_property PACKAGE_PIN U21 [get_ports {LEDs[3]}]
set_property PACKAGE_PIN V22 [get_ports {LEDs[4]}]
set_property PACKAGE_PIN W22 [get_ports {LEDs[5]}]
set_property PACKAGE_PIN U19 [get_ports {LEDs[6]}]
set_property PACKAGE_PIN U14 [get_ports {LEDs[7]}]

set_property PACKAGE_PIN P16 [get_ports rst]
set_property PACKAGE_PIN U10 [get_ports oled_dc]
set_property IOSTANDARD LVCMOS33 [get_ports oled_dc]
set_property PACKAGE_PIN U9 [get_ports oled_res]
set_property IOSTANDARD LVCMOS33 [get_ports oled_res]
set_property PACKAGE_PIN AB12 [get_ports oled_sclk]
set_property IOSTANDARD LVCMOS33 [get_ports oled_sclk]
set_property PACKAGE_PIN AA12 [get_ports oled_sdin]
set_property IOSTANDARD LVCMOS33 [get_ports oled_sdin]
set_property PACKAGE_PIN U11 [get_ports oled_vbat]
set_property IOSTANDARD LVCMOS33 [get_ports oled_vbat]
set_property PACKAGE_PIN U12 [get_ports oled_vdd]
set_property IOSTANDARD LVCMOS33 [get_ports oled_vdd]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property IOSTANDARD LVCMOS33 [get_ports {buttons[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {buttons[0]}]
set_property PACKAGE_PIN F22 [get_ports {buttons[0]}]
set_property PACKAGE_PIN G22 [get_ports {buttons[1]}]
set_property PACKAGE_PIN H22 [get_ports {buttons[2]}]
set_property PACKAGE_PIN F21 [get_ports {buttons[3]}]
set_property PACKAGE_PIN H19 [get_ports {buttons[4]}]
set_property PACKAGE_PIN H18 [get_ports {buttons[5]}]
set_property PACKAGE_PIN H17 [get_ports {buttons[6]}]
set_property PACKAGE_PIN M15 [get_ports {buttons[7]}]

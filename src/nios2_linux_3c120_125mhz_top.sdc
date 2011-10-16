#
# NOTE: this file is sourced by nios2_linux_3c120_125mhz_dev_top.sdc or nios2_linux_3c120_125mhz_qual_top.sdc
#
post_message -type info "Using SDC constriants for system type \"$system_type\""

#
# Start by getting all of the PLL related clocks declared
#
derive_pll_clocks -create_base_clocks

#
# these are the input clocks to the FPGA
#
set altera_reserved_tck {altera_reserved_tck}
set clkin_50            {clkin_50}
set clkin_125           {clkin_125}

#
# these are the generated clocks from jtag and plls that we care about
#
set ddrlo_sysclk_150    {nios2_linux_3c120_125mhz_sys_sopc_inst|the_ddr2_lo_latency_128m|ddr2_lo_latency_128m_controller_phy_inst|alt_mem_phy_inst|ddr2_lo_latency_128m_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}
set ddrlo_auxhalf_75    {nios2_linux_3c120_125mhz_sys_sopc_inst|the_ddr2_lo_latency_128m|ddr2_lo_latency_128m_controller_phy_inst|alt_mem_phy_inst|ddr2_lo_latency_128m_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}

if { $system_type == "DEVELOPMENT" } {
set ddrhi_auxhalf_75    {nios2_linux_3c120_125mhz_sys_sopc_inst|the_ddr2_hi_latency_128m|ddr2_hi_latency_128m_controller_phy_inst|alt_mem_phy_inst|ddr2_hi_latency_128m_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}
set ddrhi_auxfull_150   {nios2_linux_3c120_125mhz_sys_sopc_inst|the_ddr2_hi_latency_128m|ddr2_hi_latency_128m_controller_phy_inst|alt_mem_phy_inst|ddr2_hi_latency_128m_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}
}

set enet_pll_125    {nios2_linux_3c120_125mhz_sys_sopc_inst|the_enet_pll|the_pll|altpll_component|auto_generated|pll1|clk[0]}
set enet_pll_25     {nios2_linux_3c120_125mhz_sys_sopc_inst|the_enet_pll|the_pll|altpll_component|auto_generated|pll1|clk[1]}
set enet_pll_2p5    {nios2_linux_3c120_125mhz_sys_sopc_inst|the_enet_pll|the_pll|altpll_component|auto_generated|pll1|clk[2]}

#
# constrain the Ethernet RGMII interface, the order of these source statements is specific
#
post_message -type info "Executing constraints for the Ethernet RGMII interface, you can ignore future warnings from the file \"tse_mac_constraints.sdc\""
source rgmii_clocks.sdc
source rgmii_input.sdc
source rgmii_output.sdc

#
# some clock uncertainty is required
#
derive_clock_uncertainty

#
# Create false paths between clock domains that are not fully constrained by the IP that makes these paths.
# Ideally we should not have to do this, however, these paths must be cut to meet timing and in most cases
# the IP should be accounting for synchronization between these paths.
# The risk of a global cut like these is that if the IP is not synchronizing properly between the two domains
# then you have significant problems with the design.  Ideally the IP should synchronize it's clock crossing
# paths and create constraints to cut those paths so we don't have to perform a global cut like this.
#
set_clock_groups \
    -exclusive \
    -group [get_clocks {tx_clk_125 tx_clk_25 tx_clk_2p5}] \
    -group [get_clocks enet_rx_clk] \
    -group [get_clocks "$ddrlo_auxhalf_75 $clkin_50"]

set_clock_groups \
    -exclusive \
    -group [get_clocks $altera_reserved_tck] \
    -group [get_clocks "$ddrlo_auxhalf_75 $ddrlo_sysclk_150"]
    
#
# these are clock crossing paths from our global reset generator which should be cut
#
set_false_path  -from [get_keepers *reset_counter*resetn_out] -to *
set_false_path  -from * -to [get_keepers *bit_synchronizer*p1]

#
# this is the locked output from the Ethernet PLL in the design, it can be cut
#
set_false_path -from {nios2_linux_3c120_125mhz_sys_sopc:nios2_linux_3c120_125mhz_sys_sopc_inst|enet_pll:the_enet_pll|count_done} -to *

#
# this is for the IRQ signals that come from the slow peripheral clock domain to the linux cpu
#
set_false_path  -from * -to [get_keepers *irq_from_sa_clock_crossing_linux_cpu_data_master\|data_in_d1]

#
# The following constraints are for miscelaneous input and output pins in the
# design that are not constrained elsewhere.
#

# cpu_resetn
set_input_delay     -clock [ get_clocks $clkin_50 ]         10  [ get_ports {cpu_resetn} ]

# Ethernet MDIO interface
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {enet_mdc} ]
set_input_delay     -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {enet_mdio} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {enet_mdio} ]
set_output_delay    -clock [ get_clocks $clkin_50 ]         2   [ get_ports {enet_resetn} ]

# flash interface
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {fsa[*]} ]
set_input_delay     -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {fsd[*]} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {fsd[*]} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {flash_cen} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {flash_oen} ]
set_output_delay    -clock [ get_clocks $clkin_50 ]         2   [ get_ports {flash_resetn} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {flash_wen} ]

# uart interface
set_input_delay     -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {hsmb_tx_d_n[10]} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {hsmb_tx_d_p[11]} ]

# jtag interface
set_input_delay     -clock [ get_clocks $altera_reserved_tck ] 10 [ get_ports altera_reserved_tms ]
set_input_delay     -clock [ get_clocks $altera_reserved_tck ] 10 [ get_ports altera_reserved_tdi ]
set_output_delay    -clock [ get_clocks $altera_reserved_tck ] 10 [ get_ports altera_reserved_tdo ]

if { $system_type == "DEVELOPMENT" } {
# lcd interface
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {lcd_csn} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {lcd_d_cn} ]
set_input_delay     -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {lcd_data[*]} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {lcd_data[*]} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {lcd_e_rdn} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {lcd_en} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {lcd_rstn} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {lcd_wen} ]

# user buttons, switches and LEDs
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {seven_seg*} ]
set_output_delay    -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {user_led[*]} ]
set_input_delay     -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {user_dipsw[*]} ]
set_input_delay     -clock [ get_clocks $ddrlo_auxhalf_75 ] 2   [ get_ports {user_pb[*]} ]
}

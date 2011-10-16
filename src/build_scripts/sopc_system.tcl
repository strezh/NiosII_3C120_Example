create_system
set_system_name $project_name\_sys_sopc
## System Parameters
set_system_parameter deviceFamily "CYCLONEIII"
set_system_parameter generateLegacySim "false"
set_system_parameter hardcopyCompatible "false"
set_system_parameter hdlLanguage "VERILOG"

## Module Instantiation
add_module clock_source clkin_50
add_module clock_source clkin_125
add_module dummy_master pll_master
add_module altera_avalon_pll enet_pll
add_module altera_nios2 linux_cpu
add_module altera_avalon_onchip_memory2 fast_tlb_miss_ram_1k
add_module altera_avalon_pipeline_bridge pb_cpu_to_ddr2_lo_lat
add_module altmemddr2 ddr2_lo_latency_128m
add_module altera_avalon_pipeline_bridge pb_cpu_to_flash
add_module altera_avalon_clock_crossing ccb_cpu_to_flash
add_module altera_avalon_tri_state_bridge cfi_flash_atb
add_module altera_avalon_cfi_flash cfi_flash_64m

if { $system_type == "DEVELOPMENT" } {
	add_module altera_avalon_pipeline_bridge pb_cpu_to_hi_io
	add_module altera_avalon_clock_crossing ccb_cpu_to_hi_io
	add_module altera_avalon_onchip_memory2 xtra_hi_mem_ram_1k
	add_module altera_avalon_timer xtra_timer_2
	add_module altera_avalon_timer xtra_timer_3
	add_module altera_avalon_pipeline_bridge pb_cpu_to_ddr2_hi_lat
	add_module altera_avalon_clock_crossing ccb_cpu_to_ddr2_hi_lat
	add_module altmemddr2 ddr2_hi_latency_128m
}

add_module altera_avalon_pipeline_bridge pb_cpu_to_lo_io
add_module altera_avalon_timer linux_timer_1ms
add_module altera_avalon_clock_crossing ccb_cpu_to_lo_io
add_module altera_avalon_sysid sysid
add_module altera_avalon_jtag_uart jtag_uart
add_module altera_avalon_uart uart

if { $system_type == "DEVELOPMENT" } {
	add_module altera_avalon_onchip_memory2 cpu_config_rom_8k
	add_module altera_avalon_pio user_led_pio_8out
	add_module altera_avalon_pio user_dipsw_pio_8in
	add_module altera_avalon_pio user_pb_pio_4in
	add_module altera_avalon_timer xtra_timer_0
	add_module altera_avalon_timer xtra_timer_1
}

add_module triple_speed_ethernet tse_mac
add_module altera_avalon_sgdma sgdma_rx
add_module altera_avalon_sgdma sgdma_tx
add_module altera_avalon_pipeline_bridge pb_dma_to_descriptor_ram
add_module altera_avalon_onchip_memory2 descriptor_memory
add_module altera_avalon_clock_crossing ccb_dma_to_ddr2
add_module altera_avalon_pipeline_bridge pb_dma_to_ddr2

if { $system_type == "DEVELOPMENT" } {
	add_module altera_avalon_fifo display_fifo
	add_module altera_nios2 display_cpu
	add_module altera_avalon_onchip_memory2 display_program_ROM_8
	add_module altera_avalon_onchip_memory2 display_data_RAM_2
	add_module altera_avalon_tri_state_bridge display_atb
	add_module character_lcd_rd character_lcd_rd
	add_module character_lcd_wr character_lcd_wr
	add_module graphics_lcd graphics_lcd
	add_module altera_avalon_pio graphics_lcd_resetn_pio
	add_module altera_avalon_pio seven_seg_abcdefgdp
	add_module altera_avalon_pio seven_seg_sel_1234
	add_module altera_avalon_pio seven_seg_minus
	add_module altera_avalon_timer display_timer
	add_module altera_avalon_pipeline_bridge pb_display_cpu_to_io
}

## Module Parameterization

## Module clkin_50
set_parameter clkin_50 clockFrequency "50000000"
set_parameter clkin_50 clockFrequencyKnown "true"

## Module clkin_125
set_parameter clkin_125 clockFrequency "125000000"
set_parameter clkin_125 clockFrequencyKnown "true"

## Module pll_master
set_parameter pll_master MASTER_ADDRESS_WIDTH "8"

## Module enet_pll
set_parameter enet_pll c0 "tap c0 mult 1 div 1 phase 0 enabled true inputfreq 125000000 outputfreq 125000000 \n"
set_parameter enet_pll c1 "tap c1 mult 1 div 5 phase 0 enabled true inputfreq 125000000 outputfreq 25000000 \n"
set_parameter enet_pll c2 "tap c2 mult 1 div 50 phase 0 enabled true inputfreq 125000000 outputfreq 2500000 \n"
set_parameter enet_pll c3 "tap c3 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll c4 "tap c4 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll c5 "tap c5 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll c6 "tap c6 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll c7 "tap c7 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll c8 "tap c8 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll c9 "tap c9 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll deviceFamily "CYCLONEIII"
set_parameter enet_pll e0 "tap e0 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll e1 "tap e1 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll e2 "tap e2 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll e3 "tap e3 mult 1 div 1 phase 0 enabled false inputfreq 0 outputfreq 0 \n"
set_parameter enet_pll inputClockFrequency "125000000"
set_parameter enet_pll lockedOutputPortOption "Export"
set_parameter enet_pll pfdenaInputPortOption "Register"
set_parameter enet_pll pllHdl "//  megafunction wizard: %ALTPLL%\n//  GENERATION: STANDARD\n//  VERSION: WM1.0\n//  MODULE: altpll\n\n// ============================================================\n// CNX file retrieval info\n// ============================================================\n// Retrieval info: PRIVATE: ACTIVECLK_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: BANDWIDTH STRING \"1.000\"\n// Retrieval info: PRIVATE: BANDWIDTH_FEATURE_ENABLED STRING \"1\"\n// Retrieval info: PRIVATE: BANDWIDTH_FREQ_UNIT STRING \"MHz\"\n// Retrieval info: PRIVATE: BANDWIDTH_PRESET STRING \"Low\"\n// Retrieval info: PRIVATE: BANDWIDTH_USE_AUTO STRING \"1\"\n// Retrieval info: PRIVATE: BANDWIDTH_USE_PRESET STRING \"0\"\n// Retrieval info: PRIVATE: CLKBAD_SWITCHOVER_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: CLKLOSS_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: CLKSWITCH_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: CNX_NO_COMPENSATE_RADIO STRING \"0\"\n// Retrieval info: PRIVATE: CREATE_CLKBAD_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: CREATE_INCLK1_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: CUR_DEDICATED_CLK STRING \"c0\"\n// Retrieval info: PRIVATE: CUR_FBIN_CLK STRING \"e0\"\n// Retrieval info: PRIVATE: DEVICE_SPEED_GRADE STRING \"Any\"\n// Retrieval info: PRIVATE: DIV_FACTOR0 NUMERIC \"1\"\n// Retrieval info: PRIVATE: DIV_FACTOR1 NUMERIC \"1\"\n// Retrieval info: PRIVATE: DIV_FACTOR2 NUMERIC \"1\"\n// Retrieval info: PRIVATE: DUTY_CYCLE0 STRING \"50.00000000\"\n// Retrieval info: PRIVATE: DUTY_CYCLE1 STRING \"50.00000000\"\n// Retrieval info: PRIVATE: DUTY_CYCLE2 STRING \"50.00000000\"\n// Retrieval info: PRIVATE: EXPLICIT_SWITCHOVER_COUNTER STRING \"0\"\n// Retrieval info: PRIVATE: EXT_FEEDBACK_RADIO STRING \"0\"\n// Retrieval info: PRIVATE: GLOCKED_COUNTER_EDIT_CHANGED STRING \"1\"\n// Retrieval info: PRIVATE: GLOCKED_FEATURE_ENABLED STRING \"0\"\n// Retrieval info: PRIVATE: GLOCKED_MODE_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: GLOCK_COUNTER_EDIT NUMERIC \"1048575\"\n// Retrieval info: PRIVATE: HAS_MANUAL_SWITCHOVER STRING \"1\"\n// Retrieval info: PRIVATE: INCLK0_FREQ_EDIT STRING \"125.0\"\n// Retrieval info: PRIVATE: INCLK0_FREQ_UNIT_COMBO STRING \"MHz\"\n// Retrieval info: PRIVATE: INCLK1_FREQ_EDIT STRING \"100.000\"\n// Retrieval info: PRIVATE: INCLK1_FREQ_EDIT_CHANGED STRING \"1\"\n// Retrieval info: PRIVATE: INCLK1_FREQ_UNIT_CHANGED STRING \"1\"\n// Retrieval info: PRIVATE: INCLK1_FREQ_UNIT_COMBO STRING \"MHz\"\n// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING \"Cyclone III\"\n// Retrieval info: PRIVATE: INT_FEEDBACK__MODE_RADIO STRING \"1\"\n// Retrieval info: PRIVATE: LOCKED_OUTPUT_CHECK STRING \"1\"\n// Retrieval info: PRIVATE: LONG_SCAN_RADIO STRING \"1\"\n// Retrieval info: PRIVATE: LVDS_MODE_DATA_RATE STRING \"300.000\"\n// Retrieval info: PRIVATE: LVDS_MODE_DATA_RATE_DIRTY NUMERIC \"0\"\n// Retrieval info: PRIVATE: LVDS_PHASE_SHIFT_UNIT0 STRING \"ps\"\n// Retrieval info: PRIVATE: LVDS_PHASE_SHIFT_UNIT1 STRING \"ps\"\n// Retrieval info: PRIVATE: LVDS_PHASE_SHIFT_UNIT2 STRING \"ps\"\n// Retrieval info: PRIVATE: MIG_DEVICE_SPEED_GRADE STRING \"Any\"\n// Retrieval info: PRIVATE: MIRROR_CLK0 STRING \"0\"\n// Retrieval info: PRIVATE: MIRROR_CLK1 STRING \"0\"\n// Retrieval info: PRIVATE: MIRROR_CLK2 STRING \"0\"\n// Retrieval info: PRIVATE: MULT_FACTOR0 NUMERIC \"1\"\n// Retrieval info: PRIVATE: MULT_FACTOR1 NUMERIC \"1\"\n// Retrieval info: PRIVATE: MULT_FACTOR2 NUMERIC \"1\"\n// Retrieval info: PRIVATE: NORMAL_MODE_RADIO STRING \"1\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ0 STRING \"125.00000000\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ1 STRING \"25.00000000\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ2 STRING \"2.50000000\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ_MODE0 STRING \"1\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ_MODE1 STRING \"1\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ_MODE2 STRING \"1\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ_UNIT0 STRING \"MHz\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ_UNIT1 STRING \"MHz\"\n// Retrieval info: PRIVATE: OUTPUT_FREQ_UNIT2 STRING \"MHz\"\n// Retrieval info: PRIVATE: PHASE_RECONFIG_FEATURE_ENABLED STRING \"1\"\n// Retrieval info: PRIVATE: PHASE_RECONFIG_INPUTS_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: PHASE_SHIFT0 STRING \"0.00000000\"\n// Retrieval info: PRIVATE: PHASE_SHIFT1 STRING \"0.00000000\"\n// Retrieval info: PRIVATE: PHASE_SHIFT2 STRING \"0.00000000\"\n// Retrieval info: PRIVATE: PHASE_SHIFT_STEP_ENABLED_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: PHASE_SHIFT_UNIT0 STRING \"ps\"\n// Retrieval info: PRIVATE: PHASE_SHIFT_UNIT1 STRING \"ps\"\n// Retrieval info: PRIVATE: PHASE_SHIFT_UNIT2 STRING \"ps\"\n// Retrieval info: PRIVATE: PLL_ADVANCED_PARAM_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: PLL_ARESET_CHECK STRING \"1\"\n// Retrieval info: PRIVATE: PLL_AUTOPLL_CHECK NUMERIC \"1\"\n// Retrieval info: PRIVATE: PLL_ENHPLL_CHECK NUMERIC \"0\"\n// Retrieval info: PRIVATE: PLL_FASTPLL_CHECK NUMERIC \"0\"\n// Retrieval info: PRIVATE: PLL_FBMIMIC_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: PLL_LVDS_PLL_CHECK NUMERIC \"0\"\n// Retrieval info: PRIVATE: PLL_PFDENA_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: PLL_TARGET_HARCOPY_CHECK NUMERIC \"0\"\n// Retrieval info: PRIVATE: PRIMARY_CLK_COMBO STRING \"inclk0\"\n// Retrieval info: PRIVATE: RECONFIG_FILE STRING \"altpllpll_0.mif\"\n// Retrieval info: PRIVATE: SACN_INPUTS_CHECK STRING \"0\"\n// Retrieval info: PRIVATE: SCAN_FEATURE_ENABLED STRING \"1\"\n// Retrieval info: PRIVATE: SELF_RESET_LOCK_LOSS STRING \"1\"\n// Retrieval info: PRIVATE: SHORT_SCAN_RADIO STRING \"0\"\n// Retrieval info: PRIVATE: SPREAD_FEATURE_ENABLED STRING \"0\"\n// Retrieval info: PRIVATE: SPREAD_FREQ STRING \"50.000\"\n// Retrieval info: PRIVATE: SPREAD_FREQ_UNIT STRING \"KHz\"\n// Retrieval info: PRIVATE: SPREAD_PERCENT STRING \"0.500\"\n// Retrieval info: PRIVATE: SPREAD_USE STRING \"0\"\n// Retrieval info: PRIVATE: SRC_SYNCH_COMP_RADIO STRING \"0\"\n// Retrieval info: PRIVATE: STICKY_CLK0 STRING \"1\"\n// Retrieval info: PRIVATE: STICKY_CLK1 STRING \"1\"\n// Retrieval info: PRIVATE: STICKY_CLK2 STRING \"1\"\n// Retrieval info: PRIVATE: SWITCHOVER_COUNT_EDIT NUMERIC \"1\"\n// Retrieval info: PRIVATE: SWITCHOVER_FEATURE_ENABLED STRING \"1\"\n// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING \"0\"\n// Retrieval info: PRIVATE: USE_CLK0 STRING \"1\"\n// Retrieval info: PRIVATE: USE_CLK1 STRING \"1\"\n// Retrieval info: PRIVATE: USE_CLK2 STRING \"1\"\n// Retrieval info: PRIVATE: USE_CLKENA0 STRING \"0\"\n// Retrieval info: PRIVATE: USE_CLKENA1 STRING \"0\"\n// Retrieval info: PRIVATE: USE_CLKENA2 STRING \"0\"\n// Retrieval info: PRIVATE: USE_MIL_SPEED_GRADE NUMERIC \"0\"\n// Retrieval info: PRIVATE: ZERO_DELAY_RADIO STRING \"0\"\n// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all\n// Retrieval info: CONSTANT: BANDWIDTH_TYPE STRING \"AUTO\"\n// Retrieval info: CONSTANT: CLK0_DIVIDE_BY NUMERIC \"1\"\n// Retrieval info: CONSTANT: CLK0_DUTY_CYCLE NUMERIC \"50\"\n// Retrieval info: CONSTANT: CLK0_MULTIPLY_BY NUMERIC \"1\"\n// Retrieval info: CONSTANT: CLK0_PHASE_SHIFT STRING \"0\"\n// Retrieval info: CONSTANT: CLK1_DIVIDE_BY NUMERIC \"5\"\n// Retrieval info: CONSTANT: CLK1_DUTY_CYCLE NUMERIC \"50\"\n// Retrieval info: CONSTANT: CLK1_MULTIPLY_BY NUMERIC \"1\"\n// Retrieval info: CONSTANT: CLK1_PHASE_SHIFT STRING \"0\"\n// Retrieval info: CONSTANT: CLK2_DIVIDE_BY NUMERIC \"50\"\n// Retrieval info: CONSTANT: CLK2_DUTY_CYCLE NUMERIC \"50\"\n// Retrieval info: CONSTANT: CLK2_MULTIPLY_BY NUMERIC \"1\"\n// Retrieval info: CONSTANT: CLK2_PHASE_SHIFT STRING \"0\"\n// Retrieval info: CONSTANT: COMPENSATE_CLOCK STRING \"CLK0\"\n// Retrieval info: CONSTANT: INCLK0_INPUT_FREQUENCY NUMERIC \"8000\"\n// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING \"CYCLONEIII\"\n// Retrieval info: CONSTANT: LPM_TYPE STRING \"altpll\"\n// Retrieval info: CONSTANT: OPERATION_MODE STRING \"NORMAL\"\n// Retrieval info: CONSTANT: PLL_TYPE STRING \"AUTO\"\n// Retrieval info: CONSTANT: PORT_ACTIVECLOCK STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_ARESET STRING \"PORT_USED\"\n// Retrieval info: CONSTANT: PORT_CLKBAD0 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_CLKBAD1 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_CLKLOSS STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_CLKSWITCH STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_CONFIGUPDATE STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_FBIN STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_INCLK0 STRING \"PORT_USED\"\n// Retrieval info: CONSTANT: PORT_INCLK1 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_LOCKED STRING \"PORT_USED\"\n// Retrieval info: CONSTANT: PORT_PFDENA STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_PHASECOUNTERSELECT STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_PHASEDONE STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_PHASESTEP STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_PHASEUPDOWN STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_PLLENA STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_SCANACLR STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_SCANCLK STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_SCANCLKENA STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_SCANDATA STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_SCANDATAOUT STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_SCANDONE STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_SCANREAD STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_SCANWRITE STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clk0 STRING \"PORT_USED\"\n// Retrieval info: CONSTANT: PORT_clk1 STRING \"PORT_USED\"\n// Retrieval info: CONSTANT: PORT_clk2 STRING \"PORT_USED\"\n// Retrieval info: CONSTANT: PORT_clk3 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clk4 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clk5 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clkena0 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clkena1 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clkena2 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clkena3 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clkena4 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_clkena5 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_extclk0 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_extclk1 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_extclk2 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: PORT_extclk3 STRING \"PORT_UNUSED\"\n// Retrieval info: CONSTANT: SELF_RESET_ON_LOSS_LOCK STRING \"ON\"\n// Retrieval info: CONSTANT: WIDTH_CLOCK NUMERIC \"5\"\n// Retrieval info: USED_PORT: areset 0 0 0 0 INPUT GND \"areset\"\n// Retrieval info: USED_PORT: c0 0 0 0 0 OUTPUT_CLK_EXT VCC \"c0\"\n// Retrieval info: USED_PORT: c1 0 0 0 0 OUTPUT_CLK_EXT VCC \"c1\"\n// Retrieval info: USED_PORT: c2 0 0 0 0 OUTPUT_CLK_EXT VCC \"c2\"\n// Retrieval info: USED_PORT: inclk0 0 0 0 0 INPUT_CLK_EXT GND \"inclk0\"\n// Retrieval info: USED_PORT: locked 0 0 0 0 OUTPUT GND \"locked\"\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll.v TRUE FALSE\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll.ppf TRUE FALSE\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll.inc FALSE FALSE\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll.cmp FALSE FALSE\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll.bsf FALSE FALSE\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll_inst.v TRUE FALSE\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll_bb.v FALSE FALSE\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll_waveforms.html TRUE FALSE\n// Retrieval info: GEN_FILE: TYPE_NORMAL altpllenet_pll_wave*.jpg FALSE FALSE\n"
set_parameter enet_pll resetInputPortOption "Export"

if {$variant == "MAXIMUM_MMU"} {
## Module linux_cpu
set_parameter linux_cpu userDefinedSettings ""
set_parameter linux_cpu setting_showUnpublishedSettings "false"
set_parameter linux_cpu setting_showInternalSettings "false"
set_parameter linux_cpu setting_preciseSlaveAccessErrorException "false"
set_parameter linux_cpu setting_preciseIllegalMemAccessException "false"
set_parameter linux_cpu setting_preciseDivisionErrorException "false"
set_parameter linux_cpu setting_performanceCounter "false"
set_parameter linux_cpu setting_perfCounterWidth "_32"
set_parameter linux_cpu setting_illegalMemAccessDetection "false"
set_parameter linux_cpu setting_illegalInstructionsTrap "false"
set_parameter linux_cpu setting_fullWaveformSignals "false"
set_parameter linux_cpu setting_extraExceptionInfo "false"
set_parameter linux_cpu setting_exportPCB "false"
set_parameter linux_cpu setting_debugSimGen "false"
set_parameter linux_cpu setting_clearXBitsLDNonBypass "true"
set_parameter linux_cpu setting_branchPredictionType "Automatic"
set_parameter linux_cpu setting_bit31BypassDCache "true"
set_parameter linux_cpu setting_bhtPtrSz "_8"
set_parameter linux_cpu setting_bhtIndexPcOnly "false"
set_parameter linux_cpu setting_avalonDebugPortPresent "false"
set_parameter linux_cpu setting_alwaysEncrypt "true"
set_parameter linux_cpu setting_allowFullAddressRange "false"
set_parameter linux_cpu setting_activateTrace "true"
set_parameter linux_cpu setting_activateTestEndChecker "false"
set_parameter linux_cpu setting_activateMonitors "true"
set_parameter linux_cpu setting_activateModelChecker "false"
set_parameter linux_cpu setting_HDLSimCachesCleared "true"
set_parameter linux_cpu setting_HBreakTest "false"
set_parameter linux_cpu resetSlave "cfi_flash_64m.s1"
set_parameter linux_cpu resetOffset "41943040"
set_parameter linux_cpu muldiv_multiplierType "EmbeddedMulFast"
set_parameter linux_cpu muldiv_divider "true"
set_parameter linux_cpu mpu_useLimit "false"
set_parameter linux_cpu mpu_numOfInstRegion "8"
set_parameter linux_cpu mpu_numOfDataRegion "8"
set_parameter linux_cpu mpu_minInstRegionSize "_12"
set_parameter linux_cpu mpu_minDataRegionSize "_12"
set_parameter linux_cpu mpu_enabled "false"
set_parameter linux_cpu mmu_uitlbNumEntries "_8"
set_parameter linux_cpu mmu_udtlbNumEntries "_8"
set_parameter linux_cpu mmu_tlbPtrSz "_10"
set_parameter linux_cpu mmu_tlbNumWays "_16"
set_parameter linux_cpu mmu_processIDNumBits "_14"
set_parameter linux_cpu mmu_enabled "true"
set_parameter linux_cpu mmu_autoAssignTlbPtrSz "false"
set_parameter linux_cpu mmu_TLBMissExcSlave "fast_tlb_miss_ram_1k.s1"
set_parameter linux_cpu mmu_TLBMissExcOffset "0"
set_parameter linux_cpu manuallyAssignCpuID "false"
set_parameter linux_cpu impl "Fast"
set_parameter linux_cpu icache_size "_32768"
set_parameter linux_cpu icache_ramBlockType "Automatic"
set_parameter linux_cpu icache_numTCIM "_1"
set_parameter linux_cpu icache_burstType "None"
set_parameter linux_cpu exceptionSlave "ddr2_lo_latency_128m.s1"
set_parameter linux_cpu exceptionOffset "32"
set_parameter linux_cpu debug_triggerArming "true"
set_parameter linux_cpu debug_level "Level1"
set_parameter linux_cpu debug_jtagInstanceID "0"
set_parameter linux_cpu debug_embeddedPLL "true"
set_parameter linux_cpu debug_debugReqSignals "false"
set_parameter linux_cpu debug_assignJtagInstanceID "false"
set_parameter linux_cpu debug_OCIOnchipTrace "_128"
set_parameter linux_cpu dcache_size "_32768"
set_parameter linux_cpu dcache_ramBlockType "Automatic"
set_parameter linux_cpu dcache_omitDataMaster "false"
set_parameter linux_cpu dcache_numTCDM "_1"
set_parameter linux_cpu dcache_lineSize "_32"
set_parameter linux_cpu dcache_bursts "false"
set_parameter linux_cpu cpuReset "false"
set_parameter linux_cpu cpuID "0"
set_parameter linux_cpu breakSlave "linux_cpu.jtag_debug_module"
set_parameter linux_cpu breakOffset "32"
} elseif {$variant == "DEFAULT_MMU"} {
## Module linux_cpu
set_parameter linux_cpu userDefinedSettings ""
set_parameter linux_cpu setting_showUnpublishedSettings "false"
set_parameter linux_cpu setting_showInternalSettings "false"
set_parameter linux_cpu setting_preciseSlaveAccessErrorException "false"
set_parameter linux_cpu setting_preciseIllegalMemAccessException "false"
set_parameter linux_cpu setting_preciseDivisionErrorException "false"
set_parameter linux_cpu setting_performanceCounter "false"
set_parameter linux_cpu setting_perfCounterWidth "_32"
set_parameter linux_cpu setting_illegalMemAccessDetection "false"
set_parameter linux_cpu setting_illegalInstructionsTrap "false"
set_parameter linux_cpu setting_fullWaveformSignals "false"
set_parameter linux_cpu setting_extraExceptionInfo "false"
set_parameter linux_cpu setting_exportPCB "false"
set_parameter linux_cpu setting_debugSimGen "false"
set_parameter linux_cpu setting_clearXBitsLDNonBypass "true"
set_parameter linux_cpu setting_branchPredictionType "Automatic"
set_parameter linux_cpu setting_bit31BypassDCache "true"
set_parameter linux_cpu setting_bhtPtrSz "_8"
set_parameter linux_cpu setting_bhtIndexPcOnly "false"
set_parameter linux_cpu setting_avalonDebugPortPresent "false"
set_parameter linux_cpu setting_alwaysEncrypt "true"
set_parameter linux_cpu setting_allowFullAddressRange "false"
set_parameter linux_cpu setting_activateTrace "true"
set_parameter linux_cpu setting_activateTestEndChecker "false"
set_parameter linux_cpu setting_activateMonitors "true"
set_parameter linux_cpu setting_activateModelChecker "false"
set_parameter linux_cpu setting_HDLSimCachesCleared "true"
set_parameter linux_cpu setting_HBreakTest "false"
set_parameter linux_cpu resetSlave "cfi_flash_64m.s1"
set_parameter linux_cpu resetOffset "41943040"
set_parameter linux_cpu muldiv_multiplierType "EmbeddedMulFast"
set_parameter linux_cpu muldiv_divider "true"
set_parameter linux_cpu mpu_useLimit "false"
set_parameter linux_cpu mpu_numOfInstRegion "8"
set_parameter linux_cpu mpu_numOfDataRegion "8"
set_parameter linux_cpu mpu_minInstRegionSize "_12"
set_parameter linux_cpu mpu_minDataRegionSize "_12"
set_parameter linux_cpu mpu_enabled "false"
set_parameter linux_cpu mmu_uitlbNumEntries "_4"
set_parameter linux_cpu mmu_udtlbNumEntries "_6"
set_parameter linux_cpu mmu_tlbPtrSz "_7"
set_parameter linux_cpu mmu_tlbNumWays "_16"
set_parameter linux_cpu mmu_processIDNumBits "_8"
set_parameter linux_cpu mmu_enabled "true"
set_parameter linux_cpu mmu_autoAssignTlbPtrSz "false"
set_parameter linux_cpu mmu_TLBMissExcSlave "fast_tlb_miss_ram_1k.s1"
set_parameter linux_cpu mmu_TLBMissExcOffset "0"
set_parameter linux_cpu manuallyAssignCpuID "false"
set_parameter linux_cpu impl "Fast"
set_parameter linux_cpu icache_size "_32768"
set_parameter linux_cpu icache_ramBlockType "Automatic"
set_parameter linux_cpu icache_numTCIM "_1"
set_parameter linux_cpu icache_burstType "None"
set_parameter linux_cpu exceptionSlave "ddr2_lo_latency_128m.s1"
set_parameter linux_cpu exceptionOffset "32"
set_parameter linux_cpu debug_triggerArming "true"
set_parameter linux_cpu debug_level "Level1"
set_parameter linux_cpu debug_jtagInstanceID "0"
set_parameter linux_cpu debug_embeddedPLL "true"
set_parameter linux_cpu debug_debugReqSignals "false"
set_parameter linux_cpu debug_assignJtagInstanceID "false"
set_parameter linux_cpu debug_OCIOnchipTrace "_128"
set_parameter linux_cpu dcache_size "_32768"
set_parameter linux_cpu dcache_ramBlockType "Automatic"
set_parameter linux_cpu dcache_omitDataMaster "false"
set_parameter linux_cpu dcache_numTCDM "_1"
set_parameter linux_cpu dcache_lineSize "_32"
set_parameter linux_cpu dcache_bursts "false"
set_parameter linux_cpu cpuReset "false"
set_parameter linux_cpu cpuID "0"
set_parameter linux_cpu breakSlave "linux_cpu.jtag_debug_module"
set_parameter linux_cpu breakOffset "32"
} else {
## Module linux_cpu
set_parameter linux_cpu userDefinedSettings ""
set_parameter linux_cpu setting_showUnpublishedSettings "false"
set_parameter linux_cpu setting_showInternalSettings "false"
set_parameter linux_cpu setting_preciseSlaveAccessErrorException "false"
set_parameter linux_cpu setting_preciseIllegalMemAccessException "false"
set_parameter linux_cpu setting_preciseDivisionErrorException "false"
set_parameter linux_cpu setting_performanceCounter "false"
set_parameter linux_cpu setting_perfCounterWidth "_32"
set_parameter linux_cpu setting_illegalMemAccessDetection "false"
set_parameter linux_cpu setting_illegalInstructionsTrap "false"
set_parameter linux_cpu setting_fullWaveformSignals "false"
set_parameter linux_cpu setting_extraExceptionInfo "false"
set_parameter linux_cpu setting_exportPCB "false"
set_parameter linux_cpu setting_debugSimGen "false"
set_parameter linux_cpu setting_clearXBitsLDNonBypass "true"
set_parameter linux_cpu setting_branchPredictionType "Automatic"
set_parameter linux_cpu setting_bit31BypassDCache "true"
set_parameter linux_cpu setting_bhtPtrSz "_8"
set_parameter linux_cpu setting_bhtIndexPcOnly "false"
set_parameter linux_cpu setting_avalonDebugPortPresent "false"
set_parameter linux_cpu setting_alwaysEncrypt "true"
set_parameter linux_cpu setting_allowFullAddressRange "false"
set_parameter linux_cpu setting_activateTrace "true"
set_parameter linux_cpu setting_activateTestEndChecker "false"
set_parameter linux_cpu setting_activateMonitors "true"
set_parameter linux_cpu setting_activateModelChecker "false"
set_parameter linux_cpu setting_HDLSimCachesCleared "true"
set_parameter linux_cpu setting_HBreakTest "false"
set_parameter linux_cpu resetSlave "cfi_flash_64m.s1"
set_parameter linux_cpu resetOffset "41943040"
set_parameter linux_cpu muldiv_multiplierType "EmbeddedMulFast"
set_parameter linux_cpu muldiv_divider "true"
set_parameter linux_cpu mpu_useLimit "false"
set_parameter linux_cpu mpu_numOfInstRegion "8"
set_parameter linux_cpu mpu_numOfDataRegion "8"
set_parameter linux_cpu mpu_minInstRegionSize "_12"
set_parameter linux_cpu mpu_minDataRegionSize "_12"
set_parameter linux_cpu mpu_enabled "false"
set_parameter linux_cpu mmu_uitlbNumEntries "_4"
set_parameter linux_cpu mmu_udtlbNumEntries "_6"
set_parameter linux_cpu mmu_tlbPtrSz "_7"
set_parameter linux_cpu mmu_tlbNumWays "_16"
set_parameter linux_cpu mmu_processIDNumBits "_8"
set_parameter linux_cpu mmu_enabled "false"
set_parameter linux_cpu mmu_autoAssignTlbPtrSz "true"
set_parameter linux_cpu mmu_TLBMissExcSlave ""
set_parameter linux_cpu mmu_TLBMissExcOffset "0"
set_parameter linux_cpu manuallyAssignCpuID "false"
set_parameter linux_cpu impl "Fast"
set_parameter linux_cpu icache_size "_32768"
set_parameter linux_cpu icache_ramBlockType "Automatic"
set_parameter linux_cpu icache_numTCIM "_1"
set_parameter linux_cpu icache_burstType "None"
set_parameter linux_cpu exceptionSlave "ddr2_lo_latency_128m.s1"
set_parameter linux_cpu exceptionOffset "32"
set_parameter linux_cpu debug_triggerArming "true"
set_parameter linux_cpu debug_level "Level1"
set_parameter linux_cpu debug_jtagInstanceID "0"
set_parameter linux_cpu debug_embeddedPLL "true"
set_parameter linux_cpu debug_debugReqSignals "false"
set_parameter linux_cpu debug_assignJtagInstanceID "false"
set_parameter linux_cpu debug_OCIOnchipTrace "_128"
set_parameter linux_cpu dcache_size "_32768"
set_parameter linux_cpu dcache_ramBlockType "Automatic"
set_parameter linux_cpu dcache_omitDataMaster "false"
set_parameter linux_cpu dcache_numTCDM "_1"
set_parameter linux_cpu dcache_lineSize "_32"
set_parameter linux_cpu dcache_bursts "false"
set_parameter linux_cpu cpuReset "false"
set_parameter linux_cpu cpuID "0"
set_parameter linux_cpu breakSlave "linux_cpu.jtag_debug_module"
set_parameter linux_cpu breakOffset "32"
}

## Module fast_tlb_miss_ram_1k
set_parameter fast_tlb_miss_ram_1k allowInSystemMemoryContentEditor "false"
set_parameter fast_tlb_miss_ram_1k blockType "AUTO"
set_parameter fast_tlb_miss_ram_1k dataWidth "32"
set_parameter fast_tlb_miss_ram_1k dualPort "true"
set_parameter fast_tlb_miss_ram_1k initMemContent "true"
set_parameter fast_tlb_miss_ram_1k initializationFileName "fast_tlb_miss_ram_1k"
set_parameter fast_tlb_miss_ram_1k instanceID "NONE"
set_parameter fast_tlb_miss_ram_1k memorySize "1024"
set_parameter fast_tlb_miss_ram_1k readDuringWriteMode "DONT_CARE"
set_parameter fast_tlb_miss_ram_1k simAllowMRAMContentsFile "false"
set_parameter fast_tlb_miss_ram_1k slave1Latency "1"
set_parameter fast_tlb_miss_ram_1k slave2Latency "1"
set_parameter fast_tlb_miss_ram_1k useNonDefaultInitFile "false"
set_parameter fast_tlb_miss_ram_1k useShallowMemBlocks "false"
set_parameter fast_tlb_miss_ram_1k writable "true"

## Module pb_cpu_to_ddr2_lo_lat
set_parameter pb_cpu_to_ddr2_lo_lat burstEnable "false"
set_parameter pb_cpu_to_ddr2_lo_lat dataWidth "32"
set_parameter pb_cpu_to_ddr2_lo_lat downstreamPipeline "true"
set_parameter pb_cpu_to_ddr2_lo_lat enableArbiterlock "false"
set_parameter pb_cpu_to_ddr2_lo_lat maxBurstSize "2"
set_parameter pb_cpu_to_ddr2_lo_lat upstreamPipeline "true"
set_parameter pb_cpu_to_ddr2_lo_lat waitrequestPipeline "false"

## Module ddr2_lo_latency_128m
set_parameter ddr2_lo_latency_128m pipeline_commands "false"
set_parameter ddr2_lo_latency_128m debug_en "false"
set_parameter ddr2_lo_latency_128m export_debug_port "false"
set_parameter ddr2_lo_latency_128m use_generated_memory_model "true"
set_parameter ddr2_lo_latency_128m dedicated_memory_clk_phase_label "Dedicated memory clock phase:"
set_parameter ddr2_lo_latency_128m mem_if_clk_mhz "125.0"
set_parameter ddr2_lo_latency_128m quartus_project_exists "false"
set_parameter ddr2_lo_latency_128m local_if_drate "Full"
set_parameter ddr2_lo_latency_128m enable_v72_rsu "false"
set_parameter ddr2_lo_latency_128m local_if_clk_mhz_label "(125.0 MHz)"
set_parameter ddr2_lo_latency_128m new_variant "true"
set_parameter ddr2_lo_latency_128m mem_if_memtype "DDR2 SDRAM"
set_parameter ddr2_lo_latency_128m pll_ref_clk_mhz "50.0"
set_parameter ddr2_lo_latency_128m mem_if_clk_ps_label "(8000 ps)"
set_parameter ddr2_lo_latency_128m family "Cyclone III"
set_parameter ddr2_lo_latency_128m project_family "Cyclone III"
set_parameter ddr2_lo_latency_128m speed_grade "7"
set_parameter ddr2_lo_latency_128m dedicated_memory_clk_phase "0"
set_parameter ddr2_lo_latency_128m pll_ref_clk_ps_label "(20000 ps)"
set_parameter ddr2_lo_latency_128m avalon_burst_length "1"
set_parameter ddr2_lo_latency_128m WIDTH_RATIO "4"
set_parameter ddr2_lo_latency_128m mem_if_pchaddr_bit "10"
set_parameter ddr2_lo_latency_128m mem_if_clk_pair_count "1"
set_parameter ddr2_lo_latency_128m vendor "Micron"
set_parameter ddr2_lo_latency_128m chip_or_dimm "Discrete Device"
set_parameter ddr2_lo_latency_128m mem_fmax "333.333"
set_parameter ddr2_lo_latency_128m mem_if_cs_per_dimm "1"
set_parameter ddr2_lo_latency_128m pre_latency_label "Fix read latency at:"
set_parameter ddr2_lo_latency_128m dedicated_memory_clk_en "false"
set_parameter ddr2_lo_latency_128m mem_if_bankaddr_width "2"
set_parameter ddr2_lo_latency_128m mem_if_preset_rlat "0"
set_parameter ddr2_lo_latency_128m post_latency_label "cycles (0 cycles=minimum latency, non-deterministic)"
set_parameter ddr2_lo_latency_128m mem_dyn_deskew_en "false"
set_parameter ddr2_lo_latency_128m mem_if_cs_width "1"
set_parameter ddr2_lo_latency_128m mem_if_rowaddr_width "13"
set_parameter ddr2_lo_latency_128m local_if_dwidth_label "64"
set_parameter ddr2_lo_latency_128m mem_if_dm_pins_en "Yes"
set_parameter ddr2_lo_latency_128m mem_if_preset "Micron MT47H32M16CC-3"
set_parameter ddr2_lo_latency_128m fast_simulation_en "FAST"
set_parameter ddr2_lo_latency_128m mem_if_coladdr_width "10"
set_parameter ddr2_lo_latency_128m mem_if_dq_per_dqs "8"
set_parameter ddr2_lo_latency_128m mem_if_dwidth "32"
set_parameter ddr2_lo_latency_128m mem_tiha_ps "400"
set_parameter ddr2_lo_latency_128m mem_tdsh_ck "0.2"
set_parameter ddr2_lo_latency_128m mem_if_trfc_ns "105.0"
set_parameter ddr2_lo_latency_128m mem_tqh_ck "0.36"
set_parameter ddr2_lo_latency_128m mem_tisa_ps "400"
set_parameter ddr2_lo_latency_128m mem_tdss_ck "0.2"
set_parameter ddr2_lo_latency_128m mem_if_tinit_us "200.0"
set_parameter ddr2_lo_latency_128m mem_if_trcd_ns "15.0"
set_parameter ddr2_lo_latency_128m mem_if_twtr_ck "3"
set_parameter ddr2_lo_latency_128m mem_tdqss_ck "0.25"
set_parameter ddr2_lo_latency_128m mem_tqhs_ps "340"
set_parameter ddr2_lo_latency_128m mem_tdsa_ps "300"
set_parameter ddr2_lo_latency_128m mem_tac_ps "450"
set_parameter ddr2_lo_latency_128m mem_tdha_ps "300"
set_parameter ddr2_lo_latency_128m mem_if_tras_ns "40.0"
set_parameter ddr2_lo_latency_128m mem_if_twr_ns "15.0"
set_parameter ddr2_lo_latency_128m mem_tdqsck_ps "400"
set_parameter ddr2_lo_latency_128m mem_if_trp_ns "15.0"
set_parameter ddr2_lo_latency_128m mem_tdqsq_ps "240"
set_parameter ddr2_lo_latency_128m mem_if_tmrd_ns "6.0"
set_parameter ddr2_lo_latency_128m mem_if_trefi_us "7.8"
set_parameter ddr2_lo_latency_128m mem_tcl "3.0"
set_parameter ddr2_lo_latency_128m mem_tcl_40_fmax "266.667"
set_parameter ddr2_lo_latency_128m mem_odt "50"
set_parameter ddr2_lo_latency_128m mem_dll_en "Yes"
set_parameter ddr2_lo_latency_128m ac_phase "90"
set_parameter ddr2_lo_latency_128m mem_drv_str "Reduced"
set_parameter ddr2_lo_latency_128m mem_if_oct_en "false"
set_parameter ddr2_lo_latency_128m input_period "0"
set_parameter ddr2_lo_latency_128m mem_tcl_60_fmax "333.333"
set_parameter ddr2_lo_latency_128m board_skew_ps "20"
set_parameter ddr2_lo_latency_128m mem_if_dqsn_en "false"
set_parameter ddr2_lo_latency_128m dll_external "false"
set_parameter ddr2_lo_latency_128m mem_tcl_15_fmax "533.0"
set_parameter ddr2_lo_latency_128m mem_tcl_30_fmax "200.0"
set_parameter ddr2_lo_latency_128m mem_bl "4"
set_parameter ddr2_lo_latency_128m ac_clk_select "90"
set_parameter ddr2_lo_latency_128m mem_tcl_50_fmax "333.333"
set_parameter ddr2_lo_latency_128m mem_tcl_25_fmax "533.0"
set_parameter ddr2_lo_latency_128m mem_tcl_20_fmax "533.0"
set_parameter ddr2_lo_latency_128m pll_reconfig_ports_en "false"
set_parameter ddr2_lo_latency_128m mem_btype "Sequential"
set_parameter ddr2_lo_latency_128m ctl_ecc_en "false"
set_parameter ddr2_lo_latency_128m user_refresh_en "false"
set_parameter ddr2_lo_latency_128m local_if_type_avalon "true"
set_parameter ddr2_lo_latency_128m ctl_self_refresh_en "false"
set_parameter ddr2_lo_latency_128m clk_source_sharing_en "false"
set_parameter ddr2_lo_latency_128m phy_if_type_afi "false"
set_parameter ddr2_lo_latency_128m ctl_autopch_en "false"
set_parameter ddr2_lo_latency_128m shared_sys_clk_source ""
set_parameter ddr2_lo_latency_128m ref_clk_source "clkin_50"
set_parameter ddr2_lo_latency_128m ctl_powerdn_en "false"
set_parameter ddr2_lo_latency_128m tool_context "SOPC_BUILDER"
set_parameter ddr2_lo_latency_128m mem_srtr "Normal"
set_parameter ddr2_lo_latency_128m mem_mpr_loc "Predefined Pattern"
set_parameter ddr2_lo_latency_128m dss_tinit_rst_us "200.0"
set_parameter ddr2_lo_latency_128m mem_tcl_90_fmax "400.0"
set_parameter ddr2_lo_latency_128m mem_rtt_wr "Dynamic ODT off"
set_parameter ddr2_lo_latency_128m mem_tcl_100_fmax "400.0"
set_parameter ddr2_lo_latency_128m mem_pasr "Full Array"
set_parameter ddr2_lo_latency_128m mem_asrm "Manual SR Reference (SRT)"
set_parameter ddr2_lo_latency_128m mem_mpr_oper "Predefined Pattern"
set_parameter ddr2_lo_latency_128m mem_tcl_80_fmax "400.0"
set_parameter ddr2_lo_latency_128m mem_drv_impedance "RZQ/7"
set_parameter ddr2_lo_latency_128m mem_rtt_nom "ODT Disabled"
set_parameter ddr2_lo_latency_128m mem_tcl_70_fmax "400.0"
set_parameter ddr2_lo_latency_128m mem_wtcl "5.0"
set_parameter ddr2_lo_latency_128m mem_dll_pch "Fast Exit"
set_parameter ddr2_lo_latency_128m mem_atcl "Disabled"

## Module pb_cpu_to_flash
set_parameter pb_cpu_to_flash burstEnable "false"
set_parameter pb_cpu_to_flash dataWidth "32"
set_parameter pb_cpu_to_flash downstreamPipeline "true"
set_parameter pb_cpu_to_flash enableArbiterlock "false"
set_parameter pb_cpu_to_flash maxBurstSize "2"
set_parameter pb_cpu_to_flash upstreamPipeline "true"
set_parameter pb_cpu_to_flash waitrequestPipeline "false"

## Module ccb_cpu_to_flash
set_parameter ccb_cpu_to_flash dataWidth "32"
set_parameter ccb_cpu_to_flash downstreamFIFODepth "8"
set_parameter ccb_cpu_to_flash downstreamUseRegister "false"
set_parameter ccb_cpu_to_flash maxBurstSize "8"
set_parameter ccb_cpu_to_flash upstreamFIFODepth "16"
set_parameter ccb_cpu_to_flash upstreamUseRegister "false"
set_parameter ccb_cpu_to_flash useBurstCount "false"

## Module cfi_flash_atb
set_parameter cfi_flash_atb registerIncomingSignals "true"

## Module cfi_flash_64m
set_parameter cfi_flash_64m addressWidth "25"
set_parameter cfi_flash_64m corePreset "CUSTOM"
set_parameter cfi_flash_64m dataWidth "16"
set_parameter cfi_flash_64m holdTime "1"
set_parameter cfi_flash_64m setupTime "75"
set_parameter cfi_flash_64m sharedPorts ""
set_parameter cfi_flash_64m timingUnits "NS"
set_parameter cfi_flash_64m waitTime "35"

if { $system_type == "DEVELOPMENT" } {

	## Module pb_cpu_to_hi_io
	set_parameter pb_cpu_to_hi_io burstEnable "false"
	set_parameter pb_cpu_to_hi_io dataWidth "32"
	set_parameter pb_cpu_to_hi_io downstreamPipeline "true"
	set_parameter pb_cpu_to_hi_io enableArbiterlock "false"
	set_parameter pb_cpu_to_hi_io maxBurstSize "2"
	set_parameter pb_cpu_to_hi_io upstreamPipeline "true"
	set_parameter pb_cpu_to_hi_io waitrequestPipeline "false"

	## Module ccb_cpu_to_hi_io
	set_parameter ccb_cpu_to_hi_io dataWidth "32"
	set_parameter ccb_cpu_to_hi_io downstreamFIFODepth "8"
	set_parameter ccb_cpu_to_hi_io downstreamUseRegister "false"
	set_parameter ccb_cpu_to_hi_io maxBurstSize "8"
	set_parameter ccb_cpu_to_hi_io upstreamFIFODepth "16"
	set_parameter ccb_cpu_to_hi_io upstreamUseRegister "false"
	set_parameter ccb_cpu_to_hi_io useBurstCount "false"

	## Module xtra_hi_mem_ram_1k
	set_parameter xtra_hi_mem_ram_1k allowInSystemMemoryContentEditor "false"
	set_parameter xtra_hi_mem_ram_1k blockType "AUTO"
	set_parameter xtra_hi_mem_ram_1k dataWidth "32"
	set_parameter xtra_hi_mem_ram_1k dualPort "false"
	set_parameter xtra_hi_mem_ram_1k initMemContent "true"
	set_parameter xtra_hi_mem_ram_1k initializationFileName "xtra_hi_mem_ram_1k"
	set_parameter xtra_hi_mem_ram_1k instanceID "NONE"
	set_parameter xtra_hi_mem_ram_1k memorySize "1024"
	set_parameter xtra_hi_mem_ram_1k readDuringWriteMode "DONT_CARE"
	set_parameter xtra_hi_mem_ram_1k simAllowMRAMContentsFile "false"
	set_parameter xtra_hi_mem_ram_1k slave1Latency "1"
	set_parameter xtra_hi_mem_ram_1k slave2Latency "1"
	set_parameter xtra_hi_mem_ram_1k useNonDefaultInitFile "false"
	set_parameter xtra_hi_mem_ram_1k useShallowMemBlocks "false"
	set_parameter xtra_hi_mem_ram_1k writable "true"

	## Module xtra_timer_2
	set_parameter xtra_timer_2 alwaysRun "false"
	set_parameter xtra_timer_2 counterSize "32"
	set_parameter xtra_timer_2 fixedPeriod "false"
	set_parameter xtra_timer_2 period "1"
	set_parameter xtra_timer_2 periodUnits "MSEC"
	set_parameter xtra_timer_2 resetOutput "false"
	set_parameter xtra_timer_2 snapshot "true"
	set_parameter xtra_timer_2 timeoutPulseOutput "false"
	set_parameter xtra_timer_2 timerPreset "CUSTOM"

	## Module xtra_timer_3
	set_parameter xtra_timer_3 alwaysRun "false"
	set_parameter xtra_timer_3 counterSize "32"
	set_parameter xtra_timer_3 fixedPeriod "false"
	set_parameter xtra_timer_3 period "1"
	set_parameter xtra_timer_3 periodUnits "MSEC"
	set_parameter xtra_timer_3 resetOutput "false"
	set_parameter xtra_timer_3 snapshot "true"
	set_parameter xtra_timer_3 timeoutPulseOutput "false"
	set_parameter xtra_timer_3 timerPreset "CUSTOM"

	## Module pb_cpu_to_ddr2_hi_lat
	set_parameter pb_cpu_to_ddr2_hi_lat burstEnable "false"
	set_parameter pb_cpu_to_ddr2_hi_lat dataWidth "32"
	set_parameter pb_cpu_to_ddr2_hi_lat downstreamPipeline "true"
	set_parameter pb_cpu_to_ddr2_hi_lat enableArbiterlock "false"
	set_parameter pb_cpu_to_ddr2_hi_lat maxBurstSize "2"
	set_parameter pb_cpu_to_ddr2_hi_lat upstreamPipeline "true"
	set_parameter pb_cpu_to_ddr2_hi_lat waitrequestPipeline "false"

	## Module ccb_cpu_to_ddr2_hi_lat
	set_parameter ccb_cpu_to_ddr2_hi_lat dataWidth "32"
	set_parameter ccb_cpu_to_ddr2_hi_lat downstreamFIFODepth "8"
	set_parameter ccb_cpu_to_ddr2_hi_lat downstreamUseRegister "false"
	set_parameter ccb_cpu_to_ddr2_hi_lat maxBurstSize "8"
	set_parameter ccb_cpu_to_ddr2_hi_lat upstreamFIFODepth "64"
	set_parameter ccb_cpu_to_ddr2_hi_lat upstreamUseRegister "false"
	set_parameter ccb_cpu_to_ddr2_hi_lat useBurstCount "false"

	## Module ddr2_hi_latency_128m
	set_parameter ddr2_hi_latency_128m pipeline_commands "false"
	set_parameter ddr2_hi_latency_128m debug_en "false"
	set_parameter ddr2_hi_latency_128m export_debug_port "false"
	set_parameter ddr2_hi_latency_128m use_generated_memory_model "true"
	set_parameter ddr2_hi_latency_128m dedicated_memory_clk_phase_label "Dedicated memory clock phase:"
	set_parameter ddr2_hi_latency_128m mem_if_clk_mhz "125.0"
	set_parameter ddr2_hi_latency_128m quartus_project_exists "false"
	set_parameter ddr2_hi_latency_128m local_if_drate "Half"
	set_parameter ddr2_hi_latency_128m enable_v72_rsu "false"
	set_parameter ddr2_hi_latency_128m local_if_clk_mhz_label "(62.5 MHz)"
	set_parameter ddr2_hi_latency_128m new_variant "true"
	set_parameter ddr2_hi_latency_128m mem_if_memtype "DDR2 SDRAM"
	set_parameter ddr2_hi_latency_128m pll_ref_clk_mhz "50.0"
	set_parameter ddr2_hi_latency_128m mem_if_clk_ps_label "(8000 ps)"
	set_parameter ddr2_hi_latency_128m family "Cyclone III"
	set_parameter ddr2_hi_latency_128m project_family "Cyclone III"
	set_parameter ddr2_hi_latency_128m speed_grade "7"
	set_parameter ddr2_hi_latency_128m dedicated_memory_clk_phase "0"
	set_parameter ddr2_hi_latency_128m pll_ref_clk_ps_label "(20000 ps)"
	set_parameter ddr2_hi_latency_128m avalon_burst_length "1"
	set_parameter ddr2_hi_latency_128m WIDTH_RATIO "4"
	set_parameter ddr2_hi_latency_128m mem_if_pchaddr_bit "10"
	set_parameter ddr2_hi_latency_128m mem_if_clk_pair_count "1"
	set_parameter ddr2_hi_latency_128m vendor "Micron"
	set_parameter ddr2_hi_latency_128m chip_or_dimm "Discrete Device"
	set_parameter ddr2_hi_latency_128m mem_fmax "333.333"
	set_parameter ddr2_hi_latency_128m mem_if_cs_per_dimm "1"
	set_parameter ddr2_hi_latency_128m pre_latency_label "Fix read latency at:"
	set_parameter ddr2_hi_latency_128m dedicated_memory_clk_en "false"
	set_parameter ddr2_hi_latency_128m mem_if_bankaddr_width "2"
	set_parameter ddr2_hi_latency_128m mem_if_preset_rlat "0"
	set_parameter ddr2_hi_latency_128m post_latency_label "cycles (0 cycles=minimum latency, non-deterministic)"
	set_parameter ddr2_hi_latency_128m mem_dyn_deskew_en "false"
	set_parameter ddr2_hi_latency_128m mem_if_cs_width "1"
	set_parameter ddr2_hi_latency_128m mem_if_rowaddr_width "13"
	set_parameter ddr2_hi_latency_128m local_if_dwidth_label "128"
	set_parameter ddr2_hi_latency_128m mem_if_dm_pins_en "Yes"
	set_parameter ddr2_hi_latency_128m mem_if_preset "Micron MT47H32M16CC-3"
	set_parameter ddr2_hi_latency_128m fast_simulation_en "FAST"
	set_parameter ddr2_hi_latency_128m mem_if_coladdr_width "10"
	set_parameter ddr2_hi_latency_128m mem_if_dq_per_dqs "8"
	set_parameter ddr2_hi_latency_128m mem_if_dwidth "32"
	set_parameter ddr2_hi_latency_128m mem_tiha_ps "400"
	set_parameter ddr2_hi_latency_128m mem_tdsh_ck "0.2"
	set_parameter ddr2_hi_latency_128m mem_if_trfc_ns "105.0"
	set_parameter ddr2_hi_latency_128m mem_tqh_ck "0.36"
	set_parameter ddr2_hi_latency_128m mem_tisa_ps "400"
	set_parameter ddr2_hi_latency_128m mem_tdss_ck "0.2"
	set_parameter ddr2_hi_latency_128m mem_if_tinit_us "200.0"
	set_parameter ddr2_hi_latency_128m mem_if_trcd_ns "15.0"
	set_parameter ddr2_hi_latency_128m mem_if_twtr_ck "3"
	set_parameter ddr2_hi_latency_128m mem_tdqss_ck "0.25"
	set_parameter ddr2_hi_latency_128m mem_tqhs_ps "340"
	set_parameter ddr2_hi_latency_128m mem_tdsa_ps "300"
	set_parameter ddr2_hi_latency_128m mem_tac_ps "450"
	set_parameter ddr2_hi_latency_128m mem_tdha_ps "300"
	set_parameter ddr2_hi_latency_128m mem_if_tras_ns "40.0"
	set_parameter ddr2_hi_latency_128m mem_if_twr_ns "15.0"
	set_parameter ddr2_hi_latency_128m mem_tdqsck_ps "400"
	set_parameter ddr2_hi_latency_128m mem_if_trp_ns "15.0"
	set_parameter ddr2_hi_latency_128m mem_tdqsq_ps "240"
	set_parameter ddr2_hi_latency_128m mem_if_tmrd_ns "6.0"
	set_parameter ddr2_hi_latency_128m mem_if_trefi_us "7.8"
	set_parameter ddr2_hi_latency_128m mem_tcl "3.0"
	set_parameter ddr2_hi_latency_128m mem_tcl_40_fmax "266.667"
	set_parameter ddr2_hi_latency_128m mem_odt "50"
	set_parameter ddr2_hi_latency_128m mem_dll_en "Yes"
	set_parameter ddr2_hi_latency_128m ac_phase "90"
	set_parameter ddr2_hi_latency_128m mem_drv_str "Reduced"
	set_parameter ddr2_hi_latency_128m mem_if_oct_en "false"
	set_parameter ddr2_hi_latency_128m input_period "0"
	set_parameter ddr2_hi_latency_128m mem_tcl_60_fmax "333.333"
	set_parameter ddr2_hi_latency_128m board_skew_ps "20"
	set_parameter ddr2_hi_latency_128m mem_if_dqsn_en "false"
	set_parameter ddr2_hi_latency_128m dll_external "false"
	set_parameter ddr2_hi_latency_128m mem_tcl_15_fmax "533.0"
	set_parameter ddr2_hi_latency_128m mem_tcl_30_fmax "200.0"
	set_parameter ddr2_hi_latency_128m mem_bl "4"
	set_parameter ddr2_hi_latency_128m ac_clk_select "90"
	set_parameter ddr2_hi_latency_128m mem_tcl_50_fmax "333.333"
	set_parameter ddr2_hi_latency_128m mem_tcl_25_fmax "533.0"
	set_parameter ddr2_hi_latency_128m mem_tcl_20_fmax "533.0"
	set_parameter ddr2_hi_latency_128m pll_reconfig_ports_en "false"
	set_parameter ddr2_hi_latency_128m mem_btype "Sequential"
	set_parameter ddr2_hi_latency_128m ctl_ecc_en "false"
	set_parameter ddr2_hi_latency_128m user_refresh_en "false"
	set_parameter ddr2_hi_latency_128m local_if_type_avalon "true"
	set_parameter ddr2_hi_latency_128m ctl_self_refresh_en "false"
	set_parameter ddr2_hi_latency_128m clk_source_sharing_en "false"
	set_parameter ddr2_hi_latency_128m phy_if_type_afi "false"
	set_parameter ddr2_hi_latency_128m ctl_autopch_en "false"
	set_parameter ddr2_hi_latency_128m shared_sys_clk_source ""
	set_parameter ddr2_hi_latency_128m ref_clk_source "clkin_50"
	set_parameter ddr2_hi_latency_128m ctl_powerdn_en "false"
	set_parameter ddr2_hi_latency_128m tool_context "SOPC_BUILDER"
	set_parameter ddr2_hi_latency_128m mem_srtr "Normal"
	set_parameter ddr2_hi_latency_128m mem_mpr_loc "Predefined Pattern"
	set_parameter ddr2_hi_latency_128m dss_tinit_rst_us "200.0"
	set_parameter ddr2_hi_latency_128m mem_tcl_90_fmax "400.0"
	set_parameter ddr2_hi_latency_128m mem_rtt_wr "Dynamic ODT off"
	set_parameter ddr2_hi_latency_128m mem_tcl_100_fmax "400.0"
	set_parameter ddr2_hi_latency_128m mem_pasr "Full Array"
	set_parameter ddr2_hi_latency_128m mem_asrm "Manual SR Reference (SRT)"
	set_parameter ddr2_hi_latency_128m mem_mpr_oper "Predefined Pattern"
	set_parameter ddr2_hi_latency_128m mem_tcl_80_fmax "400.0"
	set_parameter ddr2_hi_latency_128m mem_drv_impedance "RZQ/7"
	set_parameter ddr2_hi_latency_128m mem_rtt_nom "ODT Disabled"
	set_parameter ddr2_hi_latency_128m mem_tcl_70_fmax "400.0"
	set_parameter ddr2_hi_latency_128m mem_wtcl "5.0"
	set_parameter ddr2_hi_latency_128m mem_dll_pch "Fast Exit"
	set_parameter ddr2_hi_latency_128m mem_atcl "Disabled"

}

## Module pb_cpu_to_lo_io
set_parameter pb_cpu_to_lo_io burstEnable "false"
set_parameter pb_cpu_to_lo_io dataWidth "32"
set_parameter pb_cpu_to_lo_io downstreamPipeline "true"
set_parameter pb_cpu_to_lo_io enableArbiterlock "false"
set_parameter pb_cpu_to_lo_io maxBurstSize "2"
set_parameter pb_cpu_to_lo_io upstreamPipeline "true"
set_parameter pb_cpu_to_lo_io waitrequestPipeline "false"

## Module linux_timer_1ms
set_parameter linux_timer_1ms alwaysRun "false"
set_parameter linux_timer_1ms counterSize "32"
set_parameter linux_timer_1ms fixedPeriod "false"
set_parameter linux_timer_1ms period "1"
set_parameter linux_timer_1ms periodUnits "MSEC"
set_parameter linux_timer_1ms resetOutput "false"
set_parameter linux_timer_1ms snapshot "true"
set_parameter linux_timer_1ms timeoutPulseOutput "false"
set_parameter linux_timer_1ms timerPreset "CUSTOM"

## Module ccb_cpu_to_lo_io
set_parameter ccb_cpu_to_lo_io dataWidth "32"
set_parameter ccb_cpu_to_lo_io downstreamFIFODepth "8"
set_parameter ccb_cpu_to_lo_io downstreamUseRegister "false"
set_parameter ccb_cpu_to_lo_io maxBurstSize "8"
set_parameter ccb_cpu_to_lo_io upstreamFIFODepth "16"
set_parameter ccb_cpu_to_lo_io upstreamUseRegister "false"
set_parameter ccb_cpu_to_lo_io useBurstCount "false"

## Module sysid

## Module jtag_uart
set_parameter jtag_uart allowMultipleConnections "false"
set_parameter jtag_uart hubInstanceID "0"
set_parameter jtag_uart readBufferDepth "64"
set_parameter jtag_uart readIRQThreshold "8"
set_parameter jtag_uart simInputCharacterStream ""
set_parameter jtag_uart simInteractiveOptions "INTERACTIVE_ASCII_OUTPUT"
set_parameter jtag_uart useRegistersForReadBuffer "false"
set_parameter jtag_uart useRegistersForWriteBuffer "false"
set_parameter jtag_uart writeBufferDepth "64"
set_parameter jtag_uart writeIRQThreshold "8"

## Module uart
set_parameter uart baud "115200"
set_parameter uart dataBits "8"
set_parameter uart fixedBaud "false"
set_parameter uart parity "NONE"
set_parameter uart simCharStream ""
set_parameter uart simInteractiveInputEnable "false"
set_parameter uart simInteractiveOutputEnable "false"
set_parameter uart simTrueBaud "false"
set_parameter uart stopBits "1"
set_parameter uart useCtsRts "false"
set_parameter uart useEopRegister "false"

if { $system_type == "DEVELOPMENT" } {

	## Module cpu_config_rom_8k
	set_parameter cpu_config_rom_8k allowInSystemMemoryContentEditor "false"
	set_parameter cpu_config_rom_8k blockType "AUTO"
	set_parameter cpu_config_rom_8k dataWidth "32"
	set_parameter cpu_config_rom_8k dualPort "false"
	set_parameter cpu_config_rom_8k initMemContent "true"
	set_parameter cpu_config_rom_8k initializationFileName "cpu_config_rom_8k"
	set_parameter cpu_config_rom_8k instanceID "NONE"
	set_parameter cpu_config_rom_8k memorySize "8192"
	set_parameter cpu_config_rom_8k readDuringWriteMode "DONT_CARE"
	set_parameter cpu_config_rom_8k simAllowMRAMContentsFile "false"
	set_parameter cpu_config_rom_8k slave1Latency "1"
	set_parameter cpu_config_rom_8k slave2Latency "1"
	set_parameter cpu_config_rom_8k useNonDefaultInitFile "false"
	set_parameter cpu_config_rom_8k useShallowMemBlocks "false"
	set_parameter cpu_config_rom_8k writable "false"

	## Module user_led_pio_8out
	set_parameter user_led_pio_8out bitClearingEdgeCapReg "false"
	set_parameter user_led_pio_8out captureEdge "false"
	set_parameter user_led_pio_8out direction "Output"
	set_parameter user_led_pio_8out edgeType "RISING"
	set_parameter user_led_pio_8out generateIRQ "false"
	set_parameter user_led_pio_8out irqType "LEVEL"
	set_parameter user_led_pio_8out resetValue "255"
	set_parameter user_led_pio_8out simDoTestBenchWiring "false"
	set_parameter user_led_pio_8out simDrivenValue "0"
	set_parameter user_led_pio_8out width "8"

	## Module user_dipsw_pio_8in
	set_parameter user_dipsw_pio_8in bitClearingEdgeCapReg "true"
	set_parameter user_dipsw_pio_8in captureEdge "true"
	set_parameter user_dipsw_pio_8in direction "Input"
	set_parameter user_dipsw_pio_8in edgeType "ANY"
	set_parameter user_dipsw_pio_8in generateIRQ "true"
	set_parameter user_dipsw_pio_8in irqType "EDGE"
	set_parameter user_dipsw_pio_8in resetValue "0"
	set_parameter user_dipsw_pio_8in simDoTestBenchWiring "false"
	set_parameter user_dipsw_pio_8in simDrivenValue "0"
	set_parameter user_dipsw_pio_8in width "8"

	## Module user_pb_pio_4in
	set_parameter user_pb_pio_4in bitClearingEdgeCapReg "true"
	set_parameter user_pb_pio_4in captureEdge "true"
	set_parameter user_pb_pio_4in direction "Input"
	set_parameter user_pb_pio_4in edgeType "ANY"
	set_parameter user_pb_pio_4in generateIRQ "true"
	set_parameter user_pb_pio_4in irqType "EDGE"
	set_parameter user_pb_pio_4in resetValue "0"
	set_parameter user_pb_pio_4in simDoTestBenchWiring "false"
	set_parameter user_pb_pio_4in simDrivenValue "0"
	set_parameter user_pb_pio_4in width "4"

	## Module xtra_timer_0
	set_parameter xtra_timer_0 alwaysRun "false"
	set_parameter xtra_timer_0 counterSize "32"
	set_parameter xtra_timer_0 fixedPeriod "false"
	set_parameter xtra_timer_0 period "1"
	set_parameter xtra_timer_0 periodUnits "MSEC"
	set_parameter xtra_timer_0 resetOutput "false"
	set_parameter xtra_timer_0 snapshot "true"
	set_parameter xtra_timer_0 timeoutPulseOutput "false"
	set_parameter xtra_timer_0 timerPreset "CUSTOM"

	## Module xtra_timer_1
	set_parameter xtra_timer_1 alwaysRun "false"
	set_parameter xtra_timer_1 counterSize "32"
	set_parameter xtra_timer_1 fixedPeriod "false"
	set_parameter xtra_timer_1 period "1"
	set_parameter xtra_timer_1 periodUnits "MSEC"
	set_parameter xtra_timer_1 resetOutput "false"
	set_parameter xtra_timer_1 snapshot "true"
	set_parameter xtra_timer_1 timeoutPulseOutput "false"
	set_parameter xtra_timer_1 timerPreset "CUSTOM"

}

## Module tse_mac
set_parameter tse_mac atlanticSinkClockRate "0"
set_parameter tse_mac atlanticSinkClockSource "unassigned"
set_parameter tse_mac atlanticSourceClockRate "0"
set_parameter tse_mac atlanticSourceClockSource "unassigned"
set_parameter tse_mac avalonSlaveClockRate "0"
set_parameter tse_mac avalonSlaveClockSource "unassigned"
set_parameter tse_mac avalonStNeighbours "\{TRANSMIT=sgdma_tx, RECEIVE=sgdma_rx\}"
set_parameter tse_mac channel_count "1"
set_parameter tse_mac core_variation "MAC_ONLY"
set_parameter tse_mac core_version "1794"
set_parameter tse_mac crc32check16bit "0"
set_parameter tse_mac crc32dwidth "8"
set_parameter tse_mac crc32gendelay "6"
set_parameter tse_mac crc32s1l2_extern "false"
set_parameter tse_mac cust_version "0"
set_parameter tse_mac dataBitsPerSymbol "8"
set_parameter tse_mac dev_version "2048"
set_parameter tse_mac deviceFamily "CYCLONEIII"
set_parameter tse_mac eg_addr "11"
set_parameter tse_mac ena_hash "false"
set_parameter tse_mac enable_alt_reconfig "false"
set_parameter tse_mac enable_clk_sharing "false"
set_parameter tse_mac enable_ena "32"
set_parameter tse_mac enable_fifoless "false"
set_parameter tse_mac enable_gmii_loopback "false"
set_parameter tse_mac enable_hd_logic "true"
set_parameter tse_mac enable_mac_flow_ctrl "true"
set_parameter tse_mac enable_mac_txaddr_set "true"
set_parameter tse_mac enable_mac_vlan "false"
set_parameter tse_mac enable_maclite "false"
set_parameter tse_mac enable_magic_detect "false"
set_parameter tse_mac enable_multi_channel "false"
set_parameter tse_mac enable_pkt_class "true"
set_parameter tse_mac enable_pma "false"
set_parameter tse_mac enable_reg_sharing "false"
set_parameter tse_mac enable_sgmii "false"
set_parameter tse_mac enable_shift16 "true"
set_parameter tse_mac enable_sup_addr "false"
set_parameter tse_mac enable_use_internal_fifo "true"
set_parameter tse_mac export_calblkclk "false"
set_parameter tse_mac export_pwrdn "false"
set_parameter tse_mac gigeAdvanceMode "true"
set_parameter tse_mac ifGMII "RGMII"
set_parameter tse_mac ifPCSuseEmbeddedSerdes "false"
set_parameter tse_mac ing_addr "11"
set_parameter tse_mac insert_ta "true"
set_parameter tse_mac maclite_gige "false"
set_parameter tse_mac max_channels "0"
set_parameter tse_mac mdio_clk_div "30"
set_parameter tse_mac phy_identifier "0"
set_parameter tse_mac ramType "AUTO"
set_parameter tse_mac reset_level "1"
set_parameter tse_mac stat_cnt_ena "true"
set_parameter tse_mac timingAdapterName "timingAdapter"
set_parameter tse_mac toolContext "SOPC_BUILDER"
set_parameter tse_mac transceiver_type "GXB"
set_parameter tse_mac uiHostClockFrequency "0"
set_parameter tse_mac uiMDIOFreq "0.0 MHz"
set_parameter tse_mac useLvds "false"
set_parameter tse_mac useMAC "true"
set_parameter tse_mac useMDIO "true"
set_parameter tse_mac usePCS "false"
set_parameter tse_mac use_sync_reset "false"

## Module sgdma_rx
set_parameter sgdma_rx addressWidth "32"
set_parameter sgdma_rx alwaysDoMaxBurst "true"
set_parameter sgdma_rx dataTransferFIFODepth "2"
set_parameter sgdma_rx enableBurstTransfers "false"
set_parameter sgdma_rx enableDescriptorReadMasterBurst "false"
set_parameter sgdma_rx enableUnalignedTransfers "false"
set_parameter sgdma_rx internalFIFODepth "2"
set_parameter sgdma_rx readBlockDataWidth "32"
set_parameter sgdma_rx readBurstcountWidth "4"
set_parameter sgdma_rx sinkErrorWidth "6"
set_parameter sgdma_rx sourceErrorWidth "0"
set_parameter sgdma_rx transferMode "STREAM_TO_MEMORY"
set_parameter sgdma_rx writeBurstcountWidth "4"

## Module sgdma_tx
set_parameter sgdma_tx addressWidth "32"
set_parameter sgdma_tx alwaysDoMaxBurst "true"
set_parameter sgdma_tx dataTransferFIFODepth "2"
set_parameter sgdma_tx enableBurstTransfers "false"
set_parameter sgdma_tx enableDescriptorReadMasterBurst "false"
set_parameter sgdma_tx enableUnalignedTransfers "false"
set_parameter sgdma_tx internalFIFODepth "2"
set_parameter sgdma_tx readBlockDataWidth "32"
set_parameter sgdma_tx readBurstcountWidth "4"
set_parameter sgdma_tx sinkErrorWidth "0"
set_parameter sgdma_tx sourceErrorWidth "1"
set_parameter sgdma_tx transferMode "MEMORY_TO_STREAM"
set_parameter sgdma_tx writeBurstcountWidth "4"

## Module pb_dma_to_descriptor_ram
set_parameter pb_dma_to_descriptor_ram burstEnable "false"
set_parameter pb_dma_to_descriptor_ram dataWidth "32"
set_parameter pb_dma_to_descriptor_ram downstreamPipeline "true"
set_parameter pb_dma_to_descriptor_ram enableArbiterlock "false"
set_parameter pb_dma_to_descriptor_ram maxBurstSize "2"
set_parameter pb_dma_to_descriptor_ram upstreamPipeline "false"
set_parameter pb_dma_to_descriptor_ram waitrequestPipeline "false"

## Module descriptor_memory
set_parameter descriptor_memory allowInSystemMemoryContentEditor "false"
set_parameter descriptor_memory blockType "AUTO"
set_parameter descriptor_memory dataWidth "32"
set_parameter descriptor_memory dualPort "false"
set_parameter descriptor_memory initMemContent "true"
set_parameter descriptor_memory initializationFileName "descriptor_memory"
set_parameter descriptor_memory instanceID "NONE"
set_parameter descriptor_memory memorySize "8192"
set_parameter descriptor_memory readDuringWriteMode "DONT_CARE"
set_parameter descriptor_memory simAllowMRAMContentsFile "false"
set_parameter descriptor_memory slave1Latency "1"
set_parameter descriptor_memory slave2Latency "1"
set_parameter descriptor_memory useNonDefaultInitFile "false"
set_parameter descriptor_memory useShallowMemBlocks "false"
set_parameter descriptor_memory writable "true"

## Module ccb_dma_to_ddr2
set_parameter ccb_dma_to_ddr2 dataWidth "32"
set_parameter ccb_dma_to_ddr2 downstreamFIFODepth "8"
set_parameter ccb_dma_to_ddr2 downstreamUseRegister "false"
set_parameter ccb_dma_to_ddr2 maxBurstSize "8"
set_parameter ccb_dma_to_ddr2 upstreamFIFODepth "64"
set_parameter ccb_dma_to_ddr2 upstreamUseRegister "false"
set_parameter ccb_dma_to_ddr2 useBurstCount "false"

## Module pb_dma_to_ddr2
set_parameter pb_dma_to_ddr2 burstEnable "false"
set_parameter pb_dma_to_ddr2 dataWidth "32"
set_parameter pb_dma_to_ddr2 downstreamPipeline "true"
set_parameter pb_dma_to_ddr2 enableArbiterlock "false"
set_parameter pb_dma_to_ddr2 maxBurstSize "2"
set_parameter pb_dma_to_ddr2 upstreamPipeline "true"
set_parameter pb_dma_to_ddr2 waitrequestPipeline "false"

if { $system_type == "DEVELOPMENT" } {

	## Module display_fifo
	set_parameter display_fifo avalonMMAvalonMMDataWidth "32"
	set_parameter display_fifo avalonMMAvalonSTDataWidth "32"
	set_parameter display_fifo bitsPerSymbol "16"
	set_parameter display_fifo channelWidth "8"
	set_parameter display_fifo errorWidth "8"
	set_parameter display_fifo fifoDepth "256"
	set_parameter display_fifo fifoInputInterfaceOptions "AVALONMM_WRITE"
	set_parameter display_fifo fifoOutputInterfaceOptions "AVALONMM_READ"
	set_parameter display_fifo showHiddenFeatures "false"
	set_parameter display_fifo singleClockMode "true"
	set_parameter display_fifo symbolsPerBeat "2"
	set_parameter display_fifo useBackpressure "false"
	set_parameter display_fifo useIRQ "false"
	set_parameter display_fifo usePacket "true"
	set_parameter display_fifo useReadControl "false"
	set_parameter display_fifo useRegister "false"
	set_parameter display_fifo useWriteControl "true"

	## Module display_cpu
	set_parameter display_cpu userDefinedSettings ""
	set_parameter display_cpu setting_showUnpublishedSettings "false"
	set_parameter display_cpu setting_showInternalSettings "false"
	set_parameter display_cpu setting_preciseSlaveAccessErrorException "false"
	set_parameter display_cpu setting_preciseIllegalMemAccessException "false"
	set_parameter display_cpu setting_preciseDivisionErrorException "false"
	set_parameter display_cpu setting_performanceCounter "false"
	set_parameter display_cpu setting_perfCounterWidth "_32"
	set_parameter display_cpu setting_illegalMemAccessDetection "false"
	set_parameter display_cpu setting_illegalInstructionsTrap "false"
	set_parameter display_cpu setting_fullWaveformSignals "false"
	set_parameter display_cpu setting_extraExceptionInfo "false"
	set_parameter display_cpu setting_exportPCB "false"
	set_parameter display_cpu setting_debugSimGen "false"
	set_parameter display_cpu setting_clearXBitsLDNonBypass "true"
	set_parameter display_cpu setting_branchPredictionType "Automatic"
	set_parameter display_cpu setting_bit31BypassDCache "true"
	set_parameter display_cpu setting_bhtPtrSz "_8"
	set_parameter display_cpu setting_bhtIndexPcOnly "false"
	set_parameter display_cpu setting_avalonDebugPortPresent "false"
	set_parameter display_cpu setting_alwaysEncrypt "true"
	set_parameter display_cpu setting_allowFullAddressRange "false"
	set_parameter display_cpu setting_activateTrace "true"
	set_parameter display_cpu setting_activateTestEndChecker "false"
	set_parameter display_cpu setting_activateMonitors "true"
	set_parameter display_cpu setting_activateModelChecker "false"
	set_parameter display_cpu setting_HDLSimCachesCleared "true"
	set_parameter display_cpu setting_HBreakTest "false"
	set_parameter display_cpu resetSlave "display_program_ROM_8.s1"
	set_parameter display_cpu resetOffset "0"
	set_parameter display_cpu muldiv_multiplierType "EmbeddedMulFast"
	set_parameter display_cpu muldiv_divider "false"
	set_parameter display_cpu mpu_useLimit "false"
	set_parameter display_cpu mpu_numOfInstRegion "8"
	set_parameter display_cpu mpu_numOfDataRegion "8"
	set_parameter display_cpu mpu_minInstRegionSize "_12"
	set_parameter display_cpu mpu_minDataRegionSize "_12"
	set_parameter display_cpu mpu_enabled "false"
	set_parameter display_cpu mmu_uitlbNumEntries "_4"
	set_parameter display_cpu mmu_udtlbNumEntries "_6"
	set_parameter display_cpu mmu_tlbPtrSz "_7"
	set_parameter display_cpu mmu_tlbNumWays "_16"
	set_parameter display_cpu mmu_processIDNumBits "_8"
	set_parameter display_cpu mmu_enabled "false"
	set_parameter display_cpu mmu_autoAssignTlbPtrSz "true"
	set_parameter display_cpu mmu_TLBMissExcSlave ""
	set_parameter display_cpu mmu_TLBMissExcOffset "0"
	set_parameter display_cpu manuallyAssignCpuID "false"
	set_parameter display_cpu impl "Tiny"
	set_parameter display_cpu icache_size "_4096"
	set_parameter display_cpu icache_ramBlockType "Automatic"
	set_parameter display_cpu icache_numTCIM "_0"
	set_parameter display_cpu icache_burstType "None"
	set_parameter display_cpu exceptionSlave "display_program_ROM_8.s1"
	set_parameter display_cpu exceptionOffset "32"
	set_parameter display_cpu debug_triggerArming "true"
	set_parameter display_cpu debug_level "NoDebug"
	set_parameter display_cpu debug_jtagInstanceID "0"
	set_parameter display_cpu debug_embeddedPLL "true"
	set_parameter display_cpu debug_debugReqSignals "false"
	set_parameter display_cpu debug_assignJtagInstanceID "false"
	set_parameter display_cpu debug_OCIOnchipTrace "_128"
	set_parameter display_cpu dcache_size "_2048"
	set_parameter display_cpu dcache_ramBlockType "Automatic"
	set_parameter display_cpu dcache_omitDataMaster "false"
	set_parameter display_cpu dcache_numTCDM "_0"
	set_parameter display_cpu dcache_lineSize "_32"
	set_parameter display_cpu dcache_bursts "false"
	set_parameter display_cpu cpuReset "false"
	set_parameter display_cpu cpuID "0"
	set_parameter display_cpu breakSlave "display_program_ROM_8.s1"
	set_parameter display_cpu breakOffset "0"

	## Module display_program_ROM_8
	set_parameter display_program_ROM_8 allowInSystemMemoryContentEditor "false"
	set_parameter display_program_ROM_8 blockType "AUTO"
	set_parameter display_program_ROM_8 dataWidth "32"
	set_parameter display_program_ROM_8 dualPort "false"
	set_parameter display_program_ROM_8 initMemContent "true"
	set_parameter display_program_ROM_8 initializationFileName "display_program_ROM_8"
	set_parameter display_program_ROM_8 instanceID "NONE"
	set_parameter display_program_ROM_8 memorySize "8192"
	set_parameter display_program_ROM_8 readDuringWriteMode "DONT_CARE"
	set_parameter display_program_ROM_8 simAllowMRAMContentsFile "false"
	set_parameter display_program_ROM_8 slave1Latency "1"
	set_parameter display_program_ROM_8 slave2Latency "1"
	set_parameter display_program_ROM_8 useNonDefaultInitFile "false"
	set_parameter display_program_ROM_8 useShallowMemBlocks "false"
	set_parameter display_program_ROM_8 writable "false"

	## Module display_data_RAM_2
	set_parameter display_data_RAM_2 allowInSystemMemoryContentEditor "false"
	set_parameter display_data_RAM_2 blockType "AUTO"
	set_parameter display_data_RAM_2 dataWidth "32"
	set_parameter display_data_RAM_2 dualPort "false"
	set_parameter display_data_RAM_2 initMemContent "true"
	set_parameter display_data_RAM_2 initializationFileName "display_data_RAM_2"
	set_parameter display_data_RAM_2 instanceID "NONE"
	set_parameter display_data_RAM_2 memorySize "2048"
	set_parameter display_data_RAM_2 readDuringWriteMode "DONT_CARE"
	set_parameter display_data_RAM_2 simAllowMRAMContentsFile "false"
	set_parameter display_data_RAM_2 slave1Latency "1"
	set_parameter display_data_RAM_2 slave2Latency "1"
	set_parameter display_data_RAM_2 useNonDefaultInitFile "false"
	set_parameter display_data_RAM_2 useShallowMemBlocks "false"
	set_parameter display_data_RAM_2 writable "true"

	## Module display_atb
	set_parameter display_atb registerIncomingSignals "true"

	## Module character_lcd_rd
	set_parameter character_lcd_rd sharedPorts "s0/ats_s0_address,s0/ats_s0_byteenable,s0/ats_s0_data"

	## Module character_lcd_wr
	set_parameter character_lcd_wr sharedPorts "s0/ats_s0_address,s0/ats_s0_byteenable,s0/ats_s0_data"

	## Module graphics_lcd
	set_parameter graphics_lcd sharedPorts "s0/ats_s0_address,s0/ats_s0_byteenable,s0/ats_s0_data"

	## Module graphics_lcd_resetn_pio
	set_parameter graphics_lcd_resetn_pio bitClearingEdgeCapReg "false"
	set_parameter graphics_lcd_resetn_pio captureEdge "false"
	set_parameter graphics_lcd_resetn_pio direction "Output"
	set_parameter graphics_lcd_resetn_pio edgeType "RISING"
	set_parameter graphics_lcd_resetn_pio generateIRQ "false"
	set_parameter graphics_lcd_resetn_pio irqType "LEVEL"
	set_parameter graphics_lcd_resetn_pio resetValue "1"
	set_parameter graphics_lcd_resetn_pio simDoTestBenchWiring "false"
	set_parameter graphics_lcd_resetn_pio simDrivenValue "0"
	set_parameter graphics_lcd_resetn_pio width "1"

	## Module seven_seg_abcdefgdp
	set_parameter seven_seg_abcdefgdp bitClearingEdgeCapReg "false"
	set_parameter seven_seg_abcdefgdp captureEdge "false"
	set_parameter seven_seg_abcdefgdp direction "Output"
	set_parameter seven_seg_abcdefgdp edgeType "RISING"
	set_parameter seven_seg_abcdefgdp generateIRQ "false"
	set_parameter seven_seg_abcdefgdp irqType "LEVEL"
	set_parameter seven_seg_abcdefgdp resetValue "255"
	set_parameter seven_seg_abcdefgdp simDoTestBenchWiring "false"
	set_parameter seven_seg_abcdefgdp simDrivenValue "0"
	set_parameter seven_seg_abcdefgdp width "8"

	## Module seven_seg_sel_1234
	set_parameter seven_seg_sel_1234 bitClearingEdgeCapReg "false"
	set_parameter seven_seg_sel_1234 captureEdge "false"
	set_parameter seven_seg_sel_1234 direction "Output"
	set_parameter seven_seg_sel_1234 edgeType "RISING"
	set_parameter seven_seg_sel_1234 generateIRQ "false"
	set_parameter seven_seg_sel_1234 irqType "LEVEL"
	set_parameter seven_seg_sel_1234 resetValue "0"
	set_parameter seven_seg_sel_1234 simDoTestBenchWiring "false"
	set_parameter seven_seg_sel_1234 simDrivenValue "0"
	set_parameter seven_seg_sel_1234 width "4"

	## Module seven_seg_minus
	set_parameter seven_seg_minus bitClearingEdgeCapReg "false"
	set_parameter seven_seg_minus captureEdge "false"
	set_parameter seven_seg_minus direction "Output"
	set_parameter seven_seg_minus edgeType "RISING"
	set_parameter seven_seg_minus generateIRQ "false"
	set_parameter seven_seg_minus irqType "LEVEL"
	set_parameter seven_seg_minus resetValue "1"
	set_parameter seven_seg_minus simDoTestBenchWiring "false"
	set_parameter seven_seg_minus simDrivenValue "0"
	set_parameter seven_seg_minus width "1"

	## Module display_timer
	set_parameter display_timer alwaysRun "false"
	set_parameter display_timer counterSize "32"
	set_parameter display_timer fixedPeriod "false"
	set_parameter display_timer period "1"
	set_parameter display_timer periodUnits "MSEC"
	set_parameter display_timer resetOutput "false"
	set_parameter display_timer snapshot "true"
	set_parameter display_timer timeoutPulseOutput "false"
	set_parameter display_timer timerPreset "CUSTOM"

	## Module pb_display_cpu_to_io
	set_parameter pb_display_cpu_to_io burstEnable "false"
	set_parameter pb_display_cpu_to_io dataWidth "32"
	set_parameter pb_display_cpu_to_io downstreamPipeline "true"
	set_parameter pb_display_cpu_to_io enableArbiterlock "false"
	set_parameter pb_display_cpu_to_io maxBurstSize "2"
	set_parameter pb_display_cpu_to_io upstreamPipeline "false"
	set_parameter pb_display_cpu_to_io waitrequestPipeline "false"

}

## Connection Instantiation
add_connection clkin_125.clk/pll_master.master_clk
add_connection clkin_125.clk/enet_pll.inclk0
add_connection pll_master.m0/enet_pll.s1
add_connection linux_cpu.instruction_master/linux_cpu.jtag_debug_module
add_connection linux_cpu.data_master/linux_cpu.jtag_debug_module
add_connection cfi_flash_atb.tristate_master/cfi_flash_64m.s1
add_connection ddr2_lo_latency_128m.sysclk/linux_cpu.clk

if { $system_type == "DEVELOPMENT" } {
	add_connection clkin_50.clk/ddr2_hi_latency_128m.refclk
}

add_connection clkin_50.clk/ddr2_lo_latency_128m.refclk
add_connection ddr2_lo_latency_128m.sysclk/fast_tlb_miss_ram_1k.clk2
add_connection ddr2_lo_latency_128m.sysclk/fast_tlb_miss_ram_1k.clk1
add_connection linux_cpu.tightly_coupled_data_master_0/fast_tlb_miss_ram_1k.s2
add_connection linux_cpu.tightly_coupled_instruction_master_0/fast_tlb_miss_ram_1k.s1
add_connection linux_cpu.instruction_master/pb_cpu_to_ddr2_lo_lat.s1
add_connection linux_cpu.data_master/pb_cpu_to_ddr2_lo_lat.s1
add_connection linux_cpu.instruction_master/pb_cpu_to_flash.s1
add_connection linux_cpu.data_master/pb_cpu_to_flash.s1

if { $system_type == "DEVELOPMENT" } {
	add_connection linux_cpu.data_master/pb_cpu_to_ddr2_hi_lat.s1
	add_connection linux_cpu.data_master/pb_cpu_to_hi_io.s1
}

add_connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_ddr2_lo_lat.clk
add_connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_flash.clk

if { $system_type == "DEVELOPMENT" } {
	add_connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_ddr2_hi_lat.clk
	add_connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_hi_io.clk
}
add_connection pb_cpu_to_ddr2_lo_lat.m1/ddr2_lo_latency_128m.s1
add_connection pb_cpu_to_flash.m1/ccb_cpu_to_flash.s1
add_connection ccb_cpu_to_flash.m1/cfi_flash_atb.avalon_slave
add_connection ddr2_lo_latency_128m.sysclk/ccb_cpu_to_flash.clk_s1

if { $system_type == "DEVELOPMENT" } {
	add_connection ddr2_lo_latency_128m.sysclk/ccb_cpu_to_hi_io.clk_s1
	add_connection ddr2_lo_latency_128m.sysclk/ccb_cpu_to_ddr2_hi_lat.clk_s1
	add_connection pb_cpu_to_hi_io.m1/ccb_cpu_to_hi_io.s1
	add_connection pb_cpu_to_ddr2_hi_lat.m1/ccb_cpu_to_ddr2_hi_lat.s1
	add_connection ccb_cpu_to_hi_io.m1/xtra_hi_mem_ram_1k.s1
}

add_connection ddr2_lo_latency_128m.auxhalf/ccb_cpu_to_flash.clk_m1
add_connection ddr2_lo_latency_128m.auxhalf/cfi_flash_atb.clk
add_connection ddr2_lo_latency_128m.auxhalf/cfi_flash_64m.clk

if { $system_type == "DEVELOPMENT" } {
	add_connection ddr2_lo_latency_128m.auxhalf/ccb_cpu_to_hi_io.clk_m1
	add_connection ddr2_lo_latency_128m.auxhalf/xtra_hi_mem_ram_1k.clk1
}

add_connection ddr2_lo_latency_128m.auxhalf/sysid.clk
add_connection linux_cpu.d_irq/linux_timer_1ms.irq
add_connection ddr2_lo_latency_128m.sysclk/linux_timer_1ms.clk
add_connection ccb_cpu_to_lo_io.m1/sysid.control_slave
add_connection ddr2_lo_latency_128m.sysclk/ccb_cpu_to_lo_io.clk_s1
add_connection ddr2_lo_latency_128m.auxhalf/ccb_cpu_to_lo_io.clk_m1
add_connection linux_cpu.d_irq/jtag_uart.irq
add_connection ddr2_lo_latency_128m.auxhalf/jtag_uart.clk
add_connection ccb_cpu_to_lo_io.m1/jtag_uart.avalon_jtag_slave

if { $system_type == "DEVELOPMENT" } {
	add_connection ccb_cpu_to_lo_io.m1/cpu_config_rom_8k.s1
	add_connection ddr2_lo_latency_128m.auxhalf/cpu_config_rom_8k.clk1
	add_connection linux_cpu.d_irq/user_dipsw_pio_8in.irq
	add_connection linux_cpu.d_irq/user_pb_pio_4in.irq
	add_connection ccb_cpu_to_lo_io.m1/user_led_pio_8out.s1
	add_connection ccb_cpu_to_lo_io.m1/user_dipsw_pio_8in.s1
	add_connection ccb_cpu_to_lo_io.m1/user_pb_pio_4in.s1
	add_connection ddr2_lo_latency_128m.auxhalf/user_led_pio_8out.clk
	add_connection ddr2_lo_latency_128m.auxhalf/user_dipsw_pio_8in.clk
	add_connection ddr2_lo_latency_128m.auxhalf/user_pb_pio_4in.clk
	add_connection linux_cpu.d_irq/xtra_timer_0.irq
	add_connection linux_cpu.d_irq/xtra_timer_1.irq
	add_connection linux_cpu.d_irq/xtra_timer_2.irq
	add_connection linux_cpu.d_irq/xtra_timer_3.irq
	add_connection ddr2_lo_latency_128m.auxhalf/xtra_timer_0.clk
	add_connection ddr2_lo_latency_128m.auxhalf/xtra_timer_1.clk
	add_connection ddr2_lo_latency_128m.auxhalf/xtra_timer_2.clk
	add_connection ddr2_lo_latency_128m.auxhalf/xtra_timer_3.clk
	add_connection ccb_cpu_to_hi_io.m1/xtra_timer_2.s1
	add_connection ccb_cpu_to_hi_io.m1/xtra_timer_3.s1
	add_connection ccb_cpu_to_lo_io.m1/xtra_timer_0.s1
	add_connection ccb_cpu_to_lo_io.m1/xtra_timer_1.s1
}

add_connection ddr2_lo_latency_128m.auxhalf/tse_mac.receive_clock_connection
add_connection ddr2_lo_latency_128m.auxhalf/tse_mac.transmit_clock_connection
add_connection ddr2_lo_latency_128m.auxhalf/tse_mac.control_port_clock_connection
add_connection ccb_cpu_to_lo_io.m1/tse_mac.control_port
add_connection linux_cpu.d_irq/sgdma_rx.csr_irq
add_connection linux_cpu.d_irq/sgdma_tx.csr_irq
add_connection ddr2_lo_latency_128m.auxhalf/sgdma_rx.clk
add_connection ddr2_lo_latency_128m.auxhalf/sgdma_tx.clk
add_connection sgdma_tx.out/tse_mac.transmit
add_connection tse_mac.receive/sgdma_rx.in
add_connection ccb_cpu_to_lo_io.m1/sgdma_rx.csr
add_connection ccb_cpu_to_lo_io.m1/sgdma_tx.csr
add_connection ddr2_lo_latency_128m.auxhalf/descriptor_memory.clk1
add_connection ddr2_lo_latency_128m.auxhalf/pb_dma_to_descriptor_ram.clk
add_connection pb_dma_to_descriptor_ram.m1/descriptor_memory.s1
add_connection sgdma_tx.descriptor_write/pb_dma_to_descriptor_ram.s1
add_connection sgdma_tx.descriptor_read/pb_dma_to_descriptor_ram.s1
add_connection sgdma_rx.descriptor_write/pb_dma_to_descriptor_ram.s1
add_connection sgdma_rx.descriptor_read/pb_dma_to_descriptor_ram.s1
add_connection ccb_cpu_to_lo_io.m1/descriptor_memory.s1
add_connection ddr2_lo_latency_128m.auxhalf/ccb_dma_to_ddr2.clk_s1
add_connection ddr2_lo_latency_128m.sysclk/ccb_dma_to_ddr2.clk_m1
add_connection sgdma_tx.m_read/ccb_dma_to_ddr2.s1
add_connection sgdma_rx.m_write/ccb_dma_to_ddr2.s1

if { $system_type == "DEVELOPMENT" } {
	add_connection ddr2_lo_latency_128m.auxhalf/display_fifo.clk_in
	add_connection ddr2_lo_latency_128m.auxhalf/display_cpu.clk
	add_connection ddr2_lo_latency_128m.auxhalf/display_program_ROM_8.clk1
	add_connection display_cpu.instruction_master/display_program_ROM_8.s1
	add_connection display_cpu.data_master/display_program_ROM_8.s1
	add_connection ddr2_lo_latency_128m.auxhalf/display_data_RAM_2.clk1
	add_connection display_cpu.data_master/display_data_RAM_2.s1
	add_connection ccb_cpu_to_lo_io.m1/display_fifo.in
	add_connection display_cpu.data_master/display_fifo.out
	add_connection display_cpu.data_master/display_atb.avalon_slave
	add_connection display_atb.tristate_master/character_lcd_rd.s0
	add_connection display_atb.tristate_master/character_lcd_wr.s0
	add_connection display_atb.tristate_master/graphics_lcd.s0
	add_connection display_cpu.data_master/graphics_lcd_resetn_pio.s1
	add_connection ddr2_lo_latency_128m.auxhalf/display_atb.clk
	add_connection ddr2_lo_latency_128m.auxhalf/character_lcd_rd.clock
	add_connection ddr2_lo_latency_128m.auxhalf/character_lcd_wr.clock
	add_connection ddr2_lo_latency_128m.auxhalf/graphics_lcd.clock
	add_connection ddr2_lo_latency_128m.auxhalf/graphics_lcd_resetn_pio.clk
	add_connection ddr2_lo_latency_128m.auxhalf/seven_seg_abcdefgdp.clk
	add_connection display_cpu.data_master/seven_seg_abcdefgdp.s1
	add_connection ddr2_lo_latency_128m.auxhalf/seven_seg_sel_1234.clk
	add_connection display_cpu.data_master/seven_seg_sel_1234.s1
	add_connection ddr2_lo_latency_128m.auxhalf/seven_seg_minus.clk
	add_connection display_cpu.data_master/seven_seg_minus.s1
	add_connection display_cpu.d_irq/display_timer.irq
	add_connection ddr2_lo_latency_128m.auxhalf/display_timer.clk
	add_connection display_cpu.data_master/display_timer.s1
	add_connection display_cpu.data_master/pb_display_cpu_to_io.s1
	add_connection ddr2_lo_latency_128m.auxhalf/pb_display_cpu_to_io.clk
	add_connection pb_display_cpu_to_io.m1/sysid.control_slave
	add_connection pb_display_cpu_to_io.m1/cpu_config_rom_8k.s1
}

add_connection linux_cpu.data_master/pb_cpu_to_lo_io.s1
add_connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_lo_io.clk
add_connection pb_cpu_to_lo_io.m1/linux_timer_1ms.s1
add_connection pb_cpu_to_lo_io.m1/ccb_cpu_to_lo_io.s1
add_connection ccb_dma_to_ddr2.m1/pb_dma_to_ddr2.s1
add_connection pb_dma_to_ddr2.m1/ddr2_lo_latency_128m.s1
add_connection ddr2_lo_latency_128m.sysclk/pb_dma_to_ddr2.clk

if { $system_type == "DEVELOPMENT" } {
	add_connection pb_display_cpu_to_io.m1/display_fifo.in_csr
	add_connection ccb_cpu_to_lo_io.m1/display_fifo.in_csr
	add_connection ccb_cpu_to_ddr2_hi_lat.m1/ddr2_hi_latency_128m.s1
	add_connection ddr2_hi_latency_128m.sysclk/ccb_cpu_to_ddr2_hi_lat.clk_m1
}

add_connection sgdma_rx.descriptor_read/ccb_dma_to_ddr2.s1
add_connection sgdma_rx.descriptor_write/ccb_dma_to_ddr2.s1
add_connection sgdma_tx.descriptor_read/ccb_dma_to_ddr2.s1
add_connection sgdma_tx.descriptor_write/ccb_dma_to_ddr2.s1
add_connection linux_cpu.d_irq/uart.irq
add_connection ccb_cpu_to_lo_io.m1/uart.s1
add_connection ddr2_lo_latency_128m.auxhalf/uart.clk

## Connection Parameterization

## Connection clkin_125.clk/pll_master.master_clk

## Connection clkin_125.clk/enet_pll.inclk0

## Connection pll_master.m0/enet_pll.s1
set_parameter pll_master.m0/enet_pll.s1 arbitrationPriority "1"
set_parameter pll_master.m0/enet_pll.s1 baseAddress "0x0000"

## Connection linux_cpu.instruction_master/linux_cpu.jtag_debug_module
set_parameter linux_cpu.instruction_master/linux_cpu.jtag_debug_module arbitrationPriority "1"
set_parameter linux_cpu.instruction_master/linux_cpu.jtag_debug_module baseAddress "0x07fff800"

## Connection linux_cpu.data_master/linux_cpu.jtag_debug_module
set_parameter linux_cpu.data_master/linux_cpu.jtag_debug_module arbitrationPriority "1"
set_parameter linux_cpu.data_master/linux_cpu.jtag_debug_module baseAddress "0x07fff800"

## Connection cfi_flash_atb.tristate_master/cfi_flash_64m.s1
set_parameter cfi_flash_atb.tristate_master/cfi_flash_64m.s1 arbitrationPriority "1"
set_parameter cfi_flash_atb.tristate_master/cfi_flash_64m.s1 baseAddress "0x0000"

## Connection ddr2_lo_latency_128m.sysclk/linux_cpu.clk

if { $system_type == "DEVELOPMENT" } {
	## Connection clkin_50.clk/ddr2_hi_latency_128m.refclk
}

## Connection clkin_50.clk/ddr2_lo_latency_128m.refclk

## Connection ddr2_lo_latency_128m.sysclk/fast_tlb_miss_ram_1k.clk2

## Connection ddr2_lo_latency_128m.sysclk/fast_tlb_miss_ram_1k.clk1

## Connection linux_cpu.tightly_coupled_data_master_0/fast_tlb_miss_ram_1k.s2
set_parameter linux_cpu.tightly_coupled_data_master_0/fast_tlb_miss_ram_1k.s2 arbitrationPriority "1"
set_parameter linux_cpu.tightly_coupled_data_master_0/fast_tlb_miss_ram_1k.s2 baseAddress "0x07fff400"

## Connection linux_cpu.tightly_coupled_instruction_master_0/fast_tlb_miss_ram_1k.s1
set_parameter linux_cpu.tightly_coupled_instruction_master_0/fast_tlb_miss_ram_1k.s1 arbitrationPriority "1"
set_parameter linux_cpu.tightly_coupled_instruction_master_0/fast_tlb_miss_ram_1k.s1 baseAddress "0x07fff400"

## Connection linux_cpu.instruction_master/pb_cpu_to_ddr2_lo_lat.s1
set_parameter linux_cpu.instruction_master/pb_cpu_to_ddr2_lo_lat.s1 arbitrationPriority "8"
set_parameter linux_cpu.instruction_master/pb_cpu_to_ddr2_lo_lat.s1 baseAddress "0x10000000"

## Connection linux_cpu.data_master/pb_cpu_to_ddr2_lo_lat.s1
set_parameter linux_cpu.data_master/pb_cpu_to_ddr2_lo_lat.s1 arbitrationPriority "8"
set_parameter linux_cpu.data_master/pb_cpu_to_ddr2_lo_lat.s1 baseAddress "0x10000000"

## Connection linux_cpu.instruction_master/pb_cpu_to_flash.s1
set_parameter linux_cpu.instruction_master/pb_cpu_to_flash.s1 arbitrationPriority "1"
set_parameter linux_cpu.instruction_master/pb_cpu_to_flash.s1 baseAddress "0x0000"

## Connection linux_cpu.data_master/pb_cpu_to_flash.s1
set_parameter linux_cpu.data_master/pb_cpu_to_flash.s1 arbitrationPriority "1"
set_parameter linux_cpu.data_master/pb_cpu_to_flash.s1 baseAddress "0x0000"

if { $system_type == "DEVELOPMENT" } {
	## Connection linux_cpu.data_master/pb_cpu_to_ddr2_hi_lat.s1
	set_parameter linux_cpu.data_master/pb_cpu_to_ddr2_hi_lat.s1 arbitrationPriority "1"
	set_parameter linux_cpu.data_master/pb_cpu_to_ddr2_hi_lat.s1 baseAddress "0x18000000"

	## Connection linux_cpu.data_master/pb_cpu_to_hi_io.s1
	set_parameter linux_cpu.data_master/pb_cpu_to_hi_io.s1 arbitrationPriority "1"
	set_parameter linux_cpu.data_master/pb_cpu_to_hi_io.s1 baseAddress "0x40000000"
}

## Connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_ddr2_lo_lat.clk

## Connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_flash.clk

if { $system_type == "DEVELOPMENT" } {
	## Connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_ddr2_hi_lat.clk

	## Connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_hi_io.clk
}

## Connection pb_cpu_to_ddr2_lo_lat.m1/ddr2_lo_latency_128m.s1
set_parameter pb_cpu_to_ddr2_lo_lat.m1/ddr2_lo_latency_128m.s1 arbitrationPriority "16"
set_parameter pb_cpu_to_ddr2_lo_lat.m1/ddr2_lo_latency_128m.s1 baseAddress "0x0000"

## Connection pb_cpu_to_flash.m1/ccb_cpu_to_flash.s1
set_parameter pb_cpu_to_flash.m1/ccb_cpu_to_flash.s1 arbitrationPriority "1"
set_parameter pb_cpu_to_flash.m1/ccb_cpu_to_flash.s1 baseAddress "0x0000"

## Connection ccb_cpu_to_flash.m1/cfi_flash_atb.avalon_slave
set_parameter ccb_cpu_to_flash.m1/cfi_flash_atb.avalon_slave arbitrationPriority "1"
set_parameter ccb_cpu_to_flash.m1/cfi_flash_atb.avalon_slave baseAddress "0x0000"

## Connection ddr2_lo_latency_128m.sysclk/ccb_cpu_to_flash.clk_s1

if { $system_type == "DEVELOPMENT" } {
	## Connection ddr2_lo_latency_128m.sysclk/ccb_cpu_to_hi_io.clk_s1

	## Connection ddr2_lo_latency_128m.sysclk/ccb_cpu_to_ddr2_hi_lat.clk_s1

	## Connection pb_cpu_to_hi_io.m1/ccb_cpu_to_hi_io.s1
	set_parameter pb_cpu_to_hi_io.m1/ccb_cpu_to_hi_io.s1 arbitrationPriority "1"
	set_parameter pb_cpu_to_hi_io.m1/ccb_cpu_to_hi_io.s1 baseAddress "0x0000"

	## Connection pb_cpu_to_ddr2_hi_lat.m1/ccb_cpu_to_ddr2_hi_lat.s1
	set_parameter pb_cpu_to_ddr2_hi_lat.m1/ccb_cpu_to_ddr2_hi_lat.s1 arbitrationPriority "1"
	set_parameter pb_cpu_to_ddr2_hi_lat.m1/ccb_cpu_to_ddr2_hi_lat.s1 baseAddress "0x0000"

	## Connection ccb_cpu_to_hi_io.m1/xtra_hi_mem_ram_1k.s1
	set_parameter ccb_cpu_to_hi_io.m1/xtra_hi_mem_ram_1k.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_hi_io.m1/xtra_hi_mem_ram_1k.s1 baseAddress "0x0000"
}

## Connection ddr2_lo_latency_128m.auxhalf/ccb_cpu_to_flash.clk_m1

## Connection ddr2_lo_latency_128m.auxhalf/cfi_flash_atb.clk

## Connection ddr2_lo_latency_128m.auxhalf/cfi_flash_64m.clk

if { $system_type == "DEVELOPMENT" } {
	## Connection ddr2_lo_latency_128m.auxhalf/ccb_cpu_to_hi_io.clk_m1

	## Connection ddr2_lo_latency_128m.auxhalf/xtra_hi_mem_ram_1k.clk1
}

## Connection ddr2_lo_latency_128m.auxhalf/sysid.clk

## Connection linux_cpu.d_irq/linux_timer_1ms.irq
set_parameter linux_cpu.d_irq/linux_timer_1ms.irq irqNumber "11"

## Connection ddr2_lo_latency_128m.sysclk/linux_timer_1ms.clk

## Connection ccb_cpu_to_lo_io.m1/sysid.control_slave
set_parameter ccb_cpu_to_lo_io.m1/sysid.control_slave arbitrationPriority "1"
set_parameter ccb_cpu_to_lo_io.m1/sysid.control_slave baseAddress "0x4d40"

## Connection ddr2_lo_latency_128m.sysclk/ccb_cpu_to_lo_io.clk_s1

## Connection ddr2_lo_latency_128m.auxhalf/ccb_cpu_to_lo_io.clk_m1

## Connection linux_cpu.d_irq/jtag_uart.irq
set_parameter linux_cpu.d_irq/jtag_uart.irq irqNumber "1"

## Connection ddr2_lo_latency_128m.auxhalf/jtag_uart.clk

## Connection ccb_cpu_to_lo_io.m1/jtag_uart.avalon_jtag_slave
set_parameter ccb_cpu_to_lo_io.m1/jtag_uart.avalon_jtag_slave arbitrationPriority "1"
set_parameter ccb_cpu_to_lo_io.m1/jtag_uart.avalon_jtag_slave baseAddress "0x4d50"

if { $system_type == "DEVELOPMENT" } {
	## Connection ccb_cpu_to_lo_io.m1/cpu_config_rom_8k.s1
	set_parameter ccb_cpu_to_lo_io.m1/cpu_config_rom_8k.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_lo_io.m1/cpu_config_rom_8k.s1 baseAddress "0x0000"

	## Connection ddr2_lo_latency_128m.auxhalf/cpu_config_rom_8k.clk1

	## Connection linux_cpu.d_irq/user_dipsw_pio_8in.irq
	set_parameter linux_cpu.d_irq/user_dipsw_pio_8in.irq irqNumber "8"

	## Connection linux_cpu.d_irq/user_pb_pio_4in.irq
	set_parameter linux_cpu.d_irq/user_pb_pio_4in.irq irqNumber "9"

	## Connection ccb_cpu_to_lo_io.m1/user_led_pio_8out.s1
	set_parameter ccb_cpu_to_lo_io.m1/user_led_pio_8out.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_lo_io.m1/user_led_pio_8out.s1 baseAddress "0x4cc0"

	## Connection ccb_cpu_to_lo_io.m1/user_dipsw_pio_8in.s1
	set_parameter ccb_cpu_to_lo_io.m1/user_dipsw_pio_8in.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_lo_io.m1/user_dipsw_pio_8in.s1 baseAddress "0x4ce0"

	## Connection ccb_cpu_to_lo_io.m1/user_pb_pio_4in.s1
	set_parameter ccb_cpu_to_lo_io.m1/user_pb_pio_4in.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_lo_io.m1/user_pb_pio_4in.s1 baseAddress "0x4d00"

	## Connection ddr2_lo_latency_128m.auxhalf/user_led_pio_8out.clk

	## Connection ddr2_lo_latency_128m.auxhalf/user_dipsw_pio_8in.clk

	## Connection ddr2_lo_latency_128m.auxhalf/user_pb_pio_4in.clk

	## Connection linux_cpu.d_irq/xtra_timer_0.irq
	set_parameter linux_cpu.d_irq/xtra_timer_0.irq irqNumber "4"

	## Connection linux_cpu.d_irq/xtra_timer_1.irq
	set_parameter linux_cpu.d_irq/xtra_timer_1.irq irqNumber "5"

	## Connection linux_cpu.d_irq/xtra_timer_2.irq
	set_parameter linux_cpu.d_irq/xtra_timer_2.irq irqNumber "6"

	## Connection linux_cpu.d_irq/xtra_timer_3.irq
	set_parameter linux_cpu.d_irq/xtra_timer_3.irq irqNumber "7"

	## Connection ddr2_lo_latency_128m.auxhalf/xtra_timer_0.clk

	## Connection ddr2_lo_latency_128m.auxhalf/xtra_timer_1.clk

	## Connection ddr2_lo_latency_128m.auxhalf/xtra_timer_2.clk

	## Connection ddr2_lo_latency_128m.auxhalf/xtra_timer_3.clk

	## Connection ccb_cpu_to_hi_io.m1/xtra_timer_2.s1
	set_parameter ccb_cpu_to_hi_io.m1/xtra_timer_2.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_hi_io.m1/xtra_timer_2.s1 baseAddress "0x0400"

	## Connection ccb_cpu_to_hi_io.m1/xtra_timer_3.s1
	set_parameter ccb_cpu_to_hi_io.m1/xtra_timer_3.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_hi_io.m1/xtra_timer_3.s1 baseAddress "0x0440"

	## Connection ccb_cpu_to_lo_io.m1/xtra_timer_0.s1
	set_parameter ccb_cpu_to_lo_io.m1/xtra_timer_0.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_lo_io.m1/xtra_timer_0.s1 baseAddress "0x4c00"

	## Connection ccb_cpu_to_lo_io.m1/xtra_timer_1.s1
	set_parameter ccb_cpu_to_lo_io.m1/xtra_timer_1.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_lo_io.m1/xtra_timer_1.s1 baseAddress "0x4c40"

}

## Connection ddr2_lo_latency_128m.auxhalf/tse_mac.receive_clock_connection

## Connection ddr2_lo_latency_128m.auxhalf/tse_mac.transmit_clock_connection

## Connection ddr2_lo_latency_128m.auxhalf/tse_mac.control_port_clock_connection

## Connection ccb_cpu_to_lo_io.m1/tse_mac.control_port
set_parameter ccb_cpu_to_lo_io.m1/tse_mac.control_port arbitrationPriority "1"
set_parameter ccb_cpu_to_lo_io.m1/tse_mac.control_port baseAddress "0x4000"

## Connection linux_cpu.d_irq/sgdma_rx.csr_irq
set_parameter linux_cpu.d_irq/sgdma_rx.csr_irq irqNumber "2"

## Connection linux_cpu.d_irq/sgdma_tx.csr_irq
set_parameter linux_cpu.d_irq/sgdma_tx.csr_irq irqNumber "3"

## Connection ddr2_lo_latency_128m.auxhalf/sgdma_rx.clk

## Connection ddr2_lo_latency_128m.auxhalf/sgdma_tx.clk

## Connection sgdma_tx.out/tse_mac.transmit

## Connection tse_mac.receive/sgdma_rx.in

## Connection ccb_cpu_to_lo_io.m1/sgdma_rx.csr
set_parameter ccb_cpu_to_lo_io.m1/sgdma_rx.csr arbitrationPriority "1"
set_parameter ccb_cpu_to_lo_io.m1/sgdma_rx.csr baseAddress "0x4400"

## Connection ccb_cpu_to_lo_io.m1/sgdma_tx.csr
set_parameter ccb_cpu_to_lo_io.m1/sgdma_tx.csr arbitrationPriority "1"
set_parameter ccb_cpu_to_lo_io.m1/sgdma_tx.csr baseAddress "0x4800"

## Connection ddr2_lo_latency_128m.auxhalf/descriptor_memory.clk1

## Connection ddr2_lo_latency_128m.auxhalf/pb_dma_to_descriptor_ram.clk

## Connection pb_dma_to_descriptor_ram.m1/descriptor_memory.s1
set_parameter pb_dma_to_descriptor_ram.m1/descriptor_memory.s1 arbitrationPriority "1"
set_parameter pb_dma_to_descriptor_ram.m1/descriptor_memory.s1 baseAddress "0x2000"

## Connection sgdma_tx.descriptor_write/pb_dma_to_descriptor_ram.s1
set_parameter sgdma_tx.descriptor_write/pb_dma_to_descriptor_ram.s1 arbitrationPriority "8"
set_parameter sgdma_tx.descriptor_write/pb_dma_to_descriptor_ram.s1 baseAddress "0x08000000"

## Connection sgdma_tx.descriptor_read/pb_dma_to_descriptor_ram.s1
set_parameter sgdma_tx.descriptor_read/pb_dma_to_descriptor_ram.s1 arbitrationPriority "8"
set_parameter sgdma_tx.descriptor_read/pb_dma_to_descriptor_ram.s1 baseAddress "0x08000000"

## Connection sgdma_rx.descriptor_write/pb_dma_to_descriptor_ram.s1
set_parameter sgdma_rx.descriptor_write/pb_dma_to_descriptor_ram.s1 arbitrationPriority "8"
set_parameter sgdma_rx.descriptor_write/pb_dma_to_descriptor_ram.s1 baseAddress "0x08000000"

## Connection sgdma_rx.descriptor_read/pb_dma_to_descriptor_ram.s1
set_parameter sgdma_rx.descriptor_read/pb_dma_to_descriptor_ram.s1 arbitrationPriority "8"
set_parameter sgdma_rx.descriptor_read/pb_dma_to_descriptor_ram.s1 baseAddress "0x08000000"

## Connection ccb_cpu_to_lo_io.m1/descriptor_memory.s1
set_parameter ccb_cpu_to_lo_io.m1/descriptor_memory.s1 arbitrationPriority "1"
set_parameter ccb_cpu_to_lo_io.m1/descriptor_memory.s1 baseAddress "0x2000"

## Connection ddr2_lo_latency_128m.auxhalf/ccb_dma_to_ddr2.clk_s1

## Connection ddr2_lo_latency_128m.sysclk/ccb_dma_to_ddr2.clk_m1

## Connection sgdma_tx.m_read/ccb_dma_to_ddr2.s1
set_parameter sgdma_tx.m_read/ccb_dma_to_ddr2.s1 arbitrationPriority "8"
set_parameter sgdma_tx.m_read/ccb_dma_to_ddr2.s1 baseAddress "0x10000000"

## Connection sgdma_rx.m_write/ccb_dma_to_ddr2.s1
set_parameter sgdma_rx.m_write/ccb_dma_to_ddr2.s1 arbitrationPriority "8"
set_parameter sgdma_rx.m_write/ccb_dma_to_ddr2.s1 baseAddress "0x10000000"

if { $system_type == "DEVELOPMENT" } {
	## Connection ddr2_lo_latency_128m.auxhalf/display_fifo.clk_in

	## Connection ddr2_lo_latency_128m.auxhalf/display_cpu.clk

	## Connection ddr2_lo_latency_128m.auxhalf/display_program_ROM_8.clk1

	## Connection display_cpu.instruction_master/display_program_ROM_8.s1
	set_parameter display_cpu.instruction_master/display_program_ROM_8.s1 arbitrationPriority "1"
	set_parameter display_cpu.instruction_master/display_program_ROM_8.s1 baseAddress "0x2000"

	## Connection display_cpu.data_master/display_program_ROM_8.s1
	set_parameter display_cpu.data_master/display_program_ROM_8.s1 arbitrationPriority "1"
	set_parameter display_cpu.data_master/display_program_ROM_8.s1 baseAddress "0x2000"

	## Connection ddr2_lo_latency_128m.auxhalf/display_data_RAM_2.clk1

	## Connection display_cpu.data_master/display_data_RAM_2.s1
	set_parameter display_cpu.data_master/display_data_RAM_2.s1 arbitrationPriority "1"
	set_parameter display_cpu.data_master/display_data_RAM_2.s1 baseAddress "0x4000"

	## Connection ccb_cpu_to_lo_io.m1/display_fifo.in
	set_parameter ccb_cpu_to_lo_io.m1/display_fifo.in arbitrationPriority "1"
	set_parameter ccb_cpu_to_lo_io.m1/display_fifo.in baseAddress "0x4d60"

	## Connection display_cpu.data_master/display_fifo.out
	set_parameter display_cpu.data_master/display_fifo.out arbitrationPriority "1"
	set_parameter display_cpu.data_master/display_fifo.out baseAddress "0x48c0"

	## Connection display_cpu.data_master/display_atb.avalon_slave
	set_parameter display_cpu.data_master/display_atb.avalon_slave arbitrationPriority "1"
	set_parameter display_cpu.data_master/display_atb.avalon_slave baseAddress "0x0000"

	## Connection display_atb.tristate_master/character_lcd_rd.s0
	set_parameter display_atb.tristate_master/character_lcd_rd.s0 arbitrationPriority "1"
	set_parameter display_atb.tristate_master/character_lcd_rd.s0 baseAddress "0x48c4"

	## Connection display_atb.tristate_master/character_lcd_wr.s0
	set_parameter display_atb.tristate_master/character_lcd_wr.s0 arbitrationPriority "1"
	set_parameter display_atb.tristate_master/character_lcd_wr.s0 baseAddress "0x48c6"

	## Connection display_atb.tristate_master/graphics_lcd.s0
	set_parameter display_atb.tristate_master/graphics_lcd.s0 arbitrationPriority "1"
	set_parameter display_atb.tristate_master/graphics_lcd.s0 baseAddress "0x48c8"

	## Connection display_cpu.data_master/graphics_lcd_resetn_pio.s1
	set_parameter display_cpu.data_master/graphics_lcd_resetn_pio.s1 arbitrationPriority "1"
	set_parameter display_cpu.data_master/graphics_lcd_resetn_pio.s1 baseAddress "0x4840"

	## Connection ddr2_lo_latency_128m.auxhalf/display_atb.clk

	## Connection ddr2_lo_latency_128m.auxhalf/character_lcd_rd.clock

	## Connection ddr2_lo_latency_128m.auxhalf/character_lcd_wr.clock

	## Connection ddr2_lo_latency_128m.auxhalf/graphics_lcd.clock

	## Connection ddr2_lo_latency_128m.auxhalf/graphics_lcd_resetn_pio.clk

	## Connection ddr2_lo_latency_128m.auxhalf/seven_seg_abcdefgdp.clk

	## Connection display_cpu.data_master/seven_seg_abcdefgdp.s1
	set_parameter display_cpu.data_master/seven_seg_abcdefgdp.s1 arbitrationPriority "1"
	set_parameter display_cpu.data_master/seven_seg_abcdefgdp.s1 baseAddress "0x4860"

	## Connection ddr2_lo_latency_128m.auxhalf/seven_seg_sel_1234.clk

	## Connection display_cpu.data_master/seven_seg_sel_1234.s1
	set_parameter display_cpu.data_master/seven_seg_sel_1234.s1 arbitrationPriority "1"
	set_parameter display_cpu.data_master/seven_seg_sel_1234.s1 baseAddress "0x4880"

	## Connection ddr2_lo_latency_128m.auxhalf/seven_seg_minus.clk

	## Connection display_cpu.data_master/seven_seg_minus.s1
	set_parameter display_cpu.data_master/seven_seg_minus.s1 arbitrationPriority "1"
	set_parameter display_cpu.data_master/seven_seg_minus.s1 baseAddress "0x48a0"

	## Connection display_cpu.d_irq/display_timer.irq
	set_parameter display_cpu.d_irq/display_timer.irq irqNumber "0"

	## Connection ddr2_lo_latency_128m.auxhalf/display_timer.clk

	## Connection display_cpu.data_master/display_timer.s1
	set_parameter display_cpu.data_master/display_timer.s1 arbitrationPriority "1"
	set_parameter display_cpu.data_master/display_timer.s1 baseAddress "0x4800"

	## Connection display_cpu.data_master/pb_display_cpu_to_io.s1
	set_parameter display_cpu.data_master/pb_display_cpu_to_io.s1 arbitrationPriority "1"
	set_parameter display_cpu.data_master/pb_display_cpu_to_io.s1 baseAddress "0x08000000"

	## Connection ddr2_lo_latency_128m.auxhalf/pb_display_cpu_to_io.clk

	## Connection pb_display_cpu_to_io.m1/sysid.control_slave
	set_parameter pb_display_cpu_to_io.m1/sysid.control_slave arbitrationPriority "1"
	set_parameter pb_display_cpu_to_io.m1/sysid.control_slave baseAddress "0x4d40"

	## Connection pb_display_cpu_to_io.m1/cpu_config_rom_8k.s1
	set_parameter pb_display_cpu_to_io.m1/cpu_config_rom_8k.s1 arbitrationPriority "1"
	set_parameter pb_display_cpu_to_io.m1/cpu_config_rom_8k.s1 baseAddress "0x0000"

}

## Connection linux_cpu.data_master/pb_cpu_to_lo_io.s1
set_parameter linux_cpu.data_master/pb_cpu_to_lo_io.s1 arbitrationPriority "1"
set_parameter linux_cpu.data_master/pb_cpu_to_lo_io.s1 baseAddress "0x08000000"

## Connection ddr2_lo_latency_128m.sysclk/pb_cpu_to_lo_io.clk

## Connection pb_cpu_to_lo_io.m1/linux_timer_1ms.s1
set_parameter pb_cpu_to_lo_io.m1/linux_timer_1ms.s1 arbitrationPriority "1"
set_parameter pb_cpu_to_lo_io.m1/linux_timer_1ms.s1 baseAddress "0x00400000"

## Connection pb_cpu_to_lo_io.m1/ccb_cpu_to_lo_io.s1
set_parameter pb_cpu_to_lo_io.m1/ccb_cpu_to_lo_io.s1 arbitrationPriority "1"
set_parameter pb_cpu_to_lo_io.m1/ccb_cpu_to_lo_io.s1 baseAddress "0x0000"

## Connection ccb_dma_to_ddr2.m1/pb_dma_to_ddr2.s1
set_parameter ccb_dma_to_ddr2.m1/pb_dma_to_ddr2.s1 arbitrationPriority "1"
set_parameter ccb_dma_to_ddr2.m1/pb_dma_to_ddr2.s1 baseAddress "0x0000"

## Connection pb_dma_to_ddr2.m1/ddr2_lo_latency_128m.s1
set_parameter pb_dma_to_ddr2.m1/ddr2_lo_latency_128m.s1 arbitrationPriority "8"
set_parameter pb_dma_to_ddr2.m1/ddr2_lo_latency_128m.s1 baseAddress "0x0000"

## Connection ddr2_lo_latency_128m.sysclk/pb_dma_to_ddr2.clk

if { $system_type == "DEVELOPMENT" } {
	## Connection pb_display_cpu_to_io.m1/display_fifo.in_csr
	set_parameter pb_display_cpu_to_io.m1/display_fifo.in_csr arbitrationPriority "1"
	set_parameter pb_display_cpu_to_io.m1/display_fifo.in_csr baseAddress "0x4d20"

	## Connection ccb_cpu_to_lo_io.m1/display_fifo.in_csr
	set_parameter ccb_cpu_to_lo_io.m1/display_fifo.in_csr arbitrationPriority "1"
	set_parameter ccb_cpu_to_lo_io.m1/display_fifo.in_csr baseAddress "0x4d20"

	## Connection ccb_cpu_to_ddr2_hi_lat.m1/ddr2_hi_latency_128m.s1
	set_parameter ccb_cpu_to_ddr2_hi_lat.m1/ddr2_hi_latency_128m.s1 arbitrationPriority "1"
	set_parameter ccb_cpu_to_ddr2_hi_lat.m1/ddr2_hi_latency_128m.s1 baseAddress "0x0000"

	## Connection ddr2_hi_latency_128m.sysclk/ccb_cpu_to_ddr2_hi_lat.clk_m1

}

## Connection sgdma_rx.descriptor_read/ccb_dma_to_ddr2.s1
set_parameter sgdma_rx.descriptor_read/ccb_dma_to_ddr2.s1 arbitrationPriority "8"
set_parameter sgdma_rx.descriptor_read/ccb_dma_to_ddr2.s1 baseAddress "0x10000000"

## Connection sgdma_rx.descriptor_write/ccb_dma_to_ddr2.s1
set_parameter sgdma_rx.descriptor_write/ccb_dma_to_ddr2.s1 arbitrationPriority "8"
set_parameter sgdma_rx.descriptor_write/ccb_dma_to_ddr2.s1 baseAddress "0x10000000"

## Connection sgdma_tx.descriptor_read/ccb_dma_to_ddr2.s1
set_parameter sgdma_tx.descriptor_read/ccb_dma_to_ddr2.s1 arbitrationPriority "8"
set_parameter sgdma_tx.descriptor_read/ccb_dma_to_ddr2.s1 baseAddress "0x10000000"

## Connection sgdma_tx.descriptor_write/ccb_dma_to_ddr2.s1
set_parameter sgdma_tx.descriptor_write/ccb_dma_to_ddr2.s1 arbitrationPriority "8"
set_parameter sgdma_tx.descriptor_write/ccb_dma_to_ddr2.s1 baseAddress "0x10000000"

## Connection linux_cpu.d_irq/uart.irq
set_parameter linux_cpu.d_irq/uart.irq irqNumber "10"

## Connection ccb_cpu_to_lo_io.m1/uart.s1
set_parameter ccb_cpu_to_lo_io.m1/uart.s1 arbitrationPriority "1"
set_parameter ccb_cpu_to_lo_io.m1/uart.s1 baseAddress "0x4c80"

## Connection ddr2_lo_latency_128m.auxhalf/uart.clk

save_system $project_name\_sys_sopc.sopc

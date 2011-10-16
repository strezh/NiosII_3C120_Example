if { $system_type == "DEVELOPMENT" } {
	set_global_assignment -name VERILOG_FILE $project_name\_dev_top.v
	set_global_assignment -name SDC_FILE $project_name\_dev_top.sdc
	set_global_assignment -name SDC_FILE ddr2_lo_latency_128m_phy_ddr_timing.sdc
	set_global_assignment -name SDC_FILE ddr2_hi_latency_128m_phy_ddr_timing.sdc
	set_global_assignment -name QIP_FILE $project_name\_sys_sopc.qip
} else {
	set_global_assignment -name VERILOG_FILE $project_name\_qual_top.v
	set_global_assignment -name SDC_FILE $project_name\_qual_top.sdc
	set_global_assignment -name SDC_FILE ddr2_lo_latency_128m_phy_ddr_timing.sdc
	set_global_assignment -name QIP_FILE $project_name\_sys_sopc.qip
}

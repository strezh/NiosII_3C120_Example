# example usage
# quartus_sh -t create_my_linker_script.tcl <infile> <outfile>

if { $argc != 2 } {
	error "Must specify <input_filename> and <output_filename?..."
}

set in_file [ open [ lindex $argv 0 ] "r" ]
set out_file [ open [ lindex $argv 1 ] "w" ]

while { [ gets $in_file line ] >= 0 } {

	if { [ regexp {\}\s*>\s*cpu_config_rom_8k\s*.*$} $line the_match other ] } {
		puts $out_file "$line"
		puts $out_file ""
		puts $out_file "    .my_cpu_config_rom_8k : { *(.my_cpu_config_rom_8k. my_cpu_config_rom_8k.*) } > cpu_config_rom_8k"
	} else {
		puts $out_file "$line"
	}
}

close $in_file
close $out_file

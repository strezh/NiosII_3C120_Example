# example usage
# quartus_sh -t strip_linux_cpu_header.tcl <infile> <outfile>

if { $argc != 2 } {
	error "Must specify <input_filename> and <output_filename?..."
}

set in_file [ open [ lindex $argv 0 ] "r" ]
set out_file [ open [ lindex $argv 1 ] "w" ]

set saw_first_define "0"
set started_cpu "0"
set saw_cpu_entirely "0"
while { [ gets $in_file line ] >= 0 } {
	if { $saw_first_define == 0 } {
		if { [ regexp {#define\s_ALTERA_LINUX_CPU_HEADER_H_$} $line define ] } {
			set saw_first_define "1"
		}
	} else {
		if { $saw_cpu_entirely == 0 } {
			if { [ regexp {#define\s(\S*)\s*(\S*.*)$} $line define macro body ] } {
				set length [ string length $body ]
				if { $length == 0 } {
					puts $out_file "$macro"
				} else {
					puts $out_file "$macro $body"
				}
				set started_cpu "1"
			} elseif { "$line" == "" } {
				if { $started_cpu == 1 } {
					set saw_cpu_entirely "1"
				}
			}
		} else {
			if { [ regexp {#define\s(\S*_BASE)\s*(\S*.*)$} $line define macro body ] } {
				set length [ string length $body ]
				if { $length == 0 } {
					puts $out_file "$macro"
				} else {
					puts $out_file "$macro $body"
				}
			}
			if { [ regexp {#define\s(\S*_SPAN)\s*(\S*.*)$} $line define macro body ] } {
				set length [ string length $body ]
				if { $length == 0 } {
					puts $out_file "$macro"
				} else {
					puts $out_file "$macro $body"
				}
			}
			if { [ regexp {#define\s(\S*_FREQ)\s*(\S*.*)$} $line define macro body ] } {
				set length [ string length $body ]
				if { $length == 0 } {
					puts $out_file "$macro"
				} else {
					puts $out_file "$macro $body"
				}
			}
		}
	}
}

close $in_file
close $out_file

# example usage
# quartus_sh -t make_cpu_header_strings.tcl <infile> <outfile>

if { $argc != 2 } {
	error "Must specify <input_filename> and <output_filename?..."
}

set in_file [ open [ lindex $argv 0 ] "r" ]
set out_file [ open [ lindex $argv 1 ] "w" ]

while { [ gets $in_file line ] >= 0 } {
	if { [ regexp {#define\s(ICACHE_SIZE)\s*(\S*.*)$} $line define macro body ] } {
		set length [ string length $body ]
		if { $length == 0 } {
			puts $out_file "#define $macro\_STR \"?\""
		} else {
			set bodyNew [ expr $body / 1024 ]
			puts $out_file "#define $macro\_STR \"$bodyNew\""
		}
	}

	if { [ regexp {#define\s(DCACHE_SIZE)\s*(\S*.*)$} $line define macro body ] } {
		set length [ string length $body ]
		if { $length == 0 } {
			puts $out_file "#define $macro\_STR \"?\""
		} else {
			set bodyNew [ expr $body / 1024 ]
			puts $out_file "#define $macro\_STR \"$bodyNew\""
		}
	}

	if { [ regexp {#define\s(PROCESS_ID_NUM_BITS)\s*(\S*.*)$} $line define macro body ] } {
		set length [ string length $body ]
		if { $length == 0 } {
			puts $out_file "#define $macro\_STR \"?\""
		} else {
			puts $out_file "#define $macro\_STR \"$body\""
		}
	}

	if { [ regexp {#define\s(TLB_NUM_WAYS)\s*(\S*.*)$} $line define macro body ] } {
		set length [ string length $body ]
		if { $length == 0 } {
			puts $out_file "#define $macro\_STR \"?\""
		} else {
			puts $out_file "#define $macro\_STR \"$body\""
		}
	}

	if { [ regexp {#define\s(TLB_NUM_ENTRIES)\s*(\S*.*)$} $line define macro body ] } {
		set length [ string length $body ]
		if { $length == 0 } {
			puts $out_file "#define $macro\_STR \"?\""
		} else {
			puts $out_file "#define $macro\_STR \"$body\""
		}
	}

	if { [ regexp {#define\s(LINUX_TIMER_1MS_FREQ)\s*(\S*.*)$} $line define macro body ] } {
		set length [ string length $body ]
		if { $length == 0 } {
			puts $out_file "#define $macro\_STR \"?\""
		} else {
			set body [ string trim $body "u" ]
			set bodyNew [ expr $body / 1000000 ]
			puts $out_file "#define $macro\_STR \"$bodyNew\""
		}
	}

	if { [ regexp {#define\s(MMU_PRESENT)\s*(\S*.*)$} $line define macro body ] } {
		puts $out_file "#define $macro"
	}
}

close $in_file
close $out_file

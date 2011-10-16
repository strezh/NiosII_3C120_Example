# example usage
# quartus_sh -t strip_linux_cpu_header.tcl <infile> <outfile>

if { $argc != 2 } {
    error "Must specify <input_filename> and <output_filename?..."
}

set in_file [ open [ lindex $argv 0 ] "r" ]
set out_file [ open [ lindex $argv 1 ] "w" ]

while { [ gets $in_file line ] >= 0 } {
    if { [ regexp {#define\s(\S*)\s*(\S*.*)$} $line define macro body ] } {
        set length [ string length $body ]
        if { $length == 0 } {
            puts $out_file "$macro"
        } else {
            puts $out_file "$macro $body"
        }
    }
}

close $in_file
close $out_file

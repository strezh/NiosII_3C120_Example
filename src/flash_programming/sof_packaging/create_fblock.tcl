# example usage
# quartus_sh -t create_fblock.tcl <outfile>

if { $argc != 1 } {
	error "Must specify <output_filename>..."
}

set out_file [ open [ lindex $argv 0 ] "w" ]

fconfigure $out_file -encoding binary

for { set i 0 } { $i < 256 } { incr i } {
	puts -nonewline $out_file [ binary format H* FF ]
} 

close $out_file

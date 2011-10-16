# example usage
# quartus_sh -t catenate_binary_image.tcl <sof_infile> <fpad_infile> <header_infile> <outfile>

if { $argc != 4 } {
    error "Must specify <sof_infile> <fpad_infile> <header_infile> and <outfile>..."
}

set sof_in_file [ open [ lindex $argv 0 ] "r" ]
set fpad_in_file [ open [ lindex $argv 1 ] "r" ]
set header_in_file [ open [ lindex $argv 2 ] "r" ]
set out_file [ open [ lindex $argv 3 ] "w" ]

fconfigure $sof_in_file		-encoding binary -translation binary
fconfigure $fpad_in_file	-encoding binary -translation binary
fconfigure $header_in_file	-encoding binary -translation binary
fconfigure $out_file		-encoding binary -translation binary

fcopy $sof_in_file $out_file
fcopy $fpad_in_file $out_file
fcopy $header_in_file $out_file

close $sof_in_file
close $fpad_in_file
close $header_in_file
close $out_file

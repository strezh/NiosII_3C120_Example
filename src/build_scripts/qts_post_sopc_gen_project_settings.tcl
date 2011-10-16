load_package report
load_package flow

if { $argc != 4 } {
    post_message -type error "Wrong number of arguments to script."
    exit 1
}

set project_name		[ lindex $argv 0 ]
set system_type			[ lindex $argv 1 ]
set pin_assignments		[ lindex $argv 2 ]
set post_assignments	[ lindex $argv 3 ]

project_open -current_revision $project_name

#
# After SOPC Builder generation, we must assign our pin numbers, and post generation assignments
#
source $pin_assignments
source $post_assignments

project_close

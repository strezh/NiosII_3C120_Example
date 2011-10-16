load_package report
load_package flow

if { $argc != 1 } {
    post_message -type error "Wrong number of arguments to script."
    exit 1
}

set project_name    [ lindex $argv 0 ]

project_open -current_revision $project_name

execute_flow -compile

project_close

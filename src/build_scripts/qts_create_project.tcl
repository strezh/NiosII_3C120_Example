load_package report
load_package flow

if { $argc != 2 } {
    post_message -type error "Wrong number of arguments to script."
    exit 1
}

set project_name        [ lindex $argv 0 ]
set initial_settings    [ lindex $argv 1 ]

if [project_exists $project_name] {
    post_message -type error "The project appears to already exist..."
    post_message -type error "Please delete everything except the source material before running this script."
    exit 1
} else {
    project_new -revision $project_name\_top $project_name
}

source $initial_settings

project_close

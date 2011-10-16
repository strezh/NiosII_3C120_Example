#!/bin/sh

#
# this script extracts the linux cpu header file from the sopcinfo system file
#

SOPCINFO_FILE=$1
SWINFO_FILE="temp.swinfo"
LINUX_CPU_HEADER_FILE="linux_cpu_header.h"
LINUX_CPU_CONFIG_FILE="linux_cpu_config.bin"

if [ ! -f $SOPCINFO_FILE ] ; then
	echo "ERROR: \"$SOPCINFO_FILE\" not found..."
	exit 1
fi

sopcinfo2swinfo --input=$SOPCINFO_FILE --output=$SWINFO_FILE

swinfo2header --swinfo $SWINFO_FILE --module linux_cpu --single $LINUX_CPU_HEADER_FILE

rm -f $SWINFO_FILE

quartus_sh -t strip_cpu_system_header.tcl $LINUX_CPU_HEADER_FILE $LINUX_CPU_CONFIG_FILE
dos2unix $LINUX_CPU_CONFIG_FILE

rm -f $LINUX_CPU_HEADER_FILE

exit 0

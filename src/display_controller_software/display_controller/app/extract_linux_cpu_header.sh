#!/bin/sh

#
# this script extracts the linux cpu header file from the sopcinfo system file
#

SOPCINFO_FILE=$1
SWINFO_FILE="linux_hp_no_mmu_sys_sopc.swinfo"
LINUX_CPU_HEADER_FILE="linux_cpu_header.h"
LINUX_CPU_CONFIG_FILE="linux_cpu_config.bin"
LINUX_CPU_STRINGS_FILE="linux_cpu_strings.h"
LINUX_CPU_CONFIG_ELF_FILE="linux_cpu_config.o"

if [ ! -f $SOPCINFO_FILE ] ; then
	echo "ERROR: \"$SOPCINFO_FILE\" not found..."
	exit 1
fi

sopcinfo2swinfo --input=$SOPCINFO_FILE --output=$SWINFO_FILE

swinfo2header --swinfo $SWINFO_FILE --module linux_cpu --single $LINUX_CPU_HEADER_FILE

rm -f $SWINFO_FILE

quartus_sh -t strip_linux_cpu_header.tcl $LINUX_CPU_HEADER_FILE $LINUX_CPU_CONFIG_FILE
dos2unix $LINUX_CPU_CONFIG_FILE

quartus_sh -t make_cpu_header_strings.tcl $LINUX_CPU_HEADER_FILE $LINUX_CPU_STRINGS_FILE

nios2-elf-objcopy --rename-section .data=.cpu_config_rom_8k -I binary -O elf32-littlenios2 -B nios2 $LINUX_CPU_CONFIG_FILE $LINUX_CPU_CONFIG_ELF_FILE

rm -f $LINUX_CPU_CONFIG_FILE
rm -f $LINUX_CPU_HEADER_FILE

exit 0

#!/bin/bash

SOF_FILENAME="../../nios2_linux_3c120_125mhz_top.sof"
SOPCINFO_FILENAME="../../nios2_linux_3c120_125mhz_sys_sopc.sopcinfo"

# parse the command line for the page option
PAGE_BASE=
PAGE_STR=
while [ $# -gt 0 ]
do
	case "$1" in
		--PAGE_0)
			PAGE_BASE="0x03500000"
			PAGE_STR="PAGE_0"
			;;
		--PAGE_1)
			PAGE_BASE="0x03880000"
			PAGE_STR="PAGE_1"
			;;
		--PAGE_2)
			PAGE_BASE="0x03C00000"
			PAGE_STR="PAGE_2"
			;;
		*)
			;;
	esac
	shift
done

if [ -z "$PAGE_BASE" ]; then
    
    echo ""
    echo "ERROR: you must supply a configuration page option to this script..."
    echo ""
    echo "USAGE: ./create-flash-programming-file.sh <PAGE>"
    echo ""
    echo "Valid <PAGE> options are --PAGE_0, --PAGE_1 or --PAGE_2"
    echo ""
    exit 1

fi



#
#	Create the hardware configuration flash file from the hardware SOF file
#
echo ""
echo "Creating hardware configuration flash file..."
echo ""
if [ -f $SOF_FILENAME ] ; then

	sof2flash --offset=0 --input=$SOF_FILENAME --output=processed_sof.flash || {
		echo "ERROR - occured while attempting to convert SOF file to FLASH file"
		exit 1
	}

else
	echo "ERROR - the file \"$SOF_FILENAME\" cannot be located..."
	exit 1
fi

#
# do some post processing to the SOF image
#

#
# get the binary data out of the sof2flash srec file
#
nios2-elf-objcopy -I srec -O binary processed_sof.flash processed_sof.flash.bin

#
# create a file with the macro definitions from the linux_cpu header file
#
./extract_linux_cpu_header.sh $SOPCINFO_FILENAME

#
# create a binary block of 256 F's to pad between the end of the sof data and the header ascii data
#
quartus_sh -t create_fblock.tcl fblock.bin

#
# stick the F block onto the sof data
# stick the header ascii data onto the end of the F block
#
quartus_sh -t catenate_binary_image.tcl processed_sof.flash.bin fblock.bin linux_cpu_config.bin full_image.bin

#
# now bin2flash this new binary file for flash programming
#
bin2flash --input=full_image.bin --output=sof_package_$PAGE_STR.flash --location=$PAGE_BASE

rm -f processed_sof.flash.bin linux_cpu_config.bin fblock.bin processed_sof.flash full_image.bin

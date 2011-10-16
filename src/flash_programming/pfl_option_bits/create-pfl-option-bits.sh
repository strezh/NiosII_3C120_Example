#!/bin/bash

echo ""
echo "Creating PFL option bits flash file..."
echo ""

#
# Compile option_bits.c with the Nios II gcc compiler
#
if [ -f option_bits.c ] ; then

	nios2-elf-gcc -c -o option_bits.o option_bits.c || {
		echo "ERROR while compiling \"option_bits.c\""
		rm -f option_bits.o
		exit 1
	}

else
	echo "ERROR - source file \"option_bits.c\" cannot be located..."
	exit 1
fi

#
# Link option_bits.elf with the Nios II gcc linker
#
if [ -f option_bits.o ] ; then

	nios2-elf-ld -T option_bits.x -o option_bits.elf option_bits.o || {
		echo "ERROR while linking \"option_bits.elf\""
		rm -f option_bits.o option_bits.elf
		exit 1
	}

else
	echo "ERROR - object file \"option_bits.o\" was not created..."
	exit 1
fi

#
# Convert option_bits.flash with the Nios II gcc binutils, objcopy
#
if [ -f option_bits.elf ] ; then

	nios2-elf-objcopy -I elf32-littlenios2 -O srec option_bits.elf option_bits.flash || {
		echo "ERROR while converting \"option_bits.elf\" into flash file."
		rm -f option_bits.o option_bits.elf
		exit 1
	}

else
	echo "ERROR - object file \"option_bits.elf\" was not created..."
	rm -f option_bits.o
	exit 1
fi

rm -f option_bits.o option_bits.elf
exit 0

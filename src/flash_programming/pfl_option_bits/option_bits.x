/*
    This linker script is provided to link the option_bits data section defined
    in the option_bits.c file into the appropriate offest of the configuration
    flash memory map.
*/

/*
    The page option words are programmed into the flash at a predetermined
    offset which is configured into the PFL design.  For the 3C120 board, this
    offset is 0x03FE0000, so we define the following macro to that offset.
*/ 
OPTION_BITS_BASE_ADDR = (0x03FE0000);

SECTIONS
{
    . = OPTION_BITS_BASE_ADDR;
    .option_bits : { *(option_bits) }
}

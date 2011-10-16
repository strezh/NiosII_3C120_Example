//
//  Note: This file requires the user to edit appropriate values in various
//        locations.  The edit locations contain the comment /* USER EDIT */.
//

//
//	This file will define the option bits for the Parallel Flash Loader design
//	used by the MAX II device on the 3C120 development board.  Some of
//	this information is generic PFL information applicable to any PFL design,
//	and	some of the information is specific to the implementation on the 3C120
//	development board.
//
//	The PFL design in general relies on OPTION bits programmed into a 4 byte
//	word associated with each PAGE of configuration data that the PFL manages.
//	The	layout of an OPTION WORD for a given CONFIGURATION PAGE looks like
//	this:
//
//	PAGE_OPTION_WORD_BYTE_0 = {PAGE_START_ADDRESS[19:13], PAGE_VALID_BIT}
//	PAGE_OPTION_WORD_BYTE_1 = PAGE_START_ADDRESS[27:20]
//	PAGE_OPTION_WORD_BYTE_2 = {PAGE_END_ADDRESS[19:13], 1'B0}
//	PAGE_OPTION_WORD_BYTE_3 = PAGE_END_ADDRESS[27:20]
//
//	The PAGE_VALID_BIT is set to ZERO for valid, and ONE for invalid.  The
//	PAGE_START_ADDRESS and PAGE_END_ADDRESS have specific boundry requirements,
//	and you should refer to the PFL documentation for those requirements.  In
//	general, you should probably keep these boundries around flash erase
//	sectors within your flash device.
//

//
//	The following two macros are defined to extract the hi and lo address bits
//	out	of a 32-bit offset address for either the start address or end address
//	of the PFL page option word.  Note that the macros always clear bit 0 of
//	the	lo address byte, this always creates a valid page setting.
//
#define ADDR_LO(x)	((x >> (12)) & 0xFE)
#define ADDR_HI(x)	((x >> (20)) & 0xFF)

//
//	We'll create one macro that has a disabled page valid bit just to make it 
//	easy to define unused pages later on.
//
#define UNUSED_ADDR_LO(x)	(((x >> (12)) & 0xFE) | 0x01)

//
//	The page option words are programmed into the flash at a predetermined
//	offset which is configured into the PFL design.  For the 3C120 board, this
//	offset is 0x03FE0000, so we define the following macro to that offset.
//	This macro is not used in this source file, but this value is placed into
//	the linker script to properly locate the option bits in the memory map.
//
#define OPTION_BITS_BASE_ADDR	(0x03FE0000)	/* USER EDIT - place the base address for the option bits here */

//
//	The Nios II linux hardware reference for the 3C120 board suggests a flash
//  layout that supports three hardware images located high up in the flash.
//  We'll program those three flash offsets for page 0, 1, and 2.  The rest of
//  the unused pages will be set to zero.
//
#define PAGE_0_OFFSET	(0x03500000)	/* USER EDIT - set the base address for this page in flash */
#define PAGE_1_OFFSET	(0x03880000)	/* USER EDIT - set the base address for this page in flash */
#define PAGE_2_OFFSET	(0x03C00000)	/* USER EDIT - set the base address for this page in flash */
#define PAGE_3_OFFSET	(0x00000000)	/* USER EDIT - set the base address for this page in flash */
#define PAGE_4_OFFSET	(0x00000000)	/* USER EDIT - set the base address for this page in flash */
#define PAGE_5_OFFSET	(0x00000000)	/* USER EDIT - set the base address for this page in flash */
#define PAGE_6_OFFSET	(0x00000000)	/* USER EDIT - set the base address for this page in flash */
#define PAGE_7_OFFSET	(0x00000000)	/* USER EDIT - set the base address for this page in flash */

//
//	In order determine the end address offset for a page option word, we must
//	know the size of the configuration bitstream.  The PFL defines rules about
//	what the boundary should be for an end address, we're going to round the end
//	address up to the next 32KB boundary.
//
#define HW_IMAGE_SIZE_IN_BYTES		(0x00367F06)	/* USER EDIT - set the size of the configuration bit stream */
#define HW_FLASH_ALLOCATION_SIZE	((HW_IMAGE_SIZE_IN_BYTES + 0x7FFF) & 0xFFFF8000)

//
//	So now we can easily construct the page start and page end addresses that
//	can be used to initialize the option words.
//
#define PAGE_0_START_ADDR	(PAGE_0_OFFSET)
#define PAGE_0_END_ADDR		(PAGE_0_START_ADDR + HW_FLASH_ALLOCATION_SIZE)
#define PAGE_1_START_ADDR	(PAGE_1_OFFSET)
#define PAGE_1_END_ADDR		(PAGE_1_START_ADDR + HW_FLASH_ALLOCATION_SIZE)
#define PAGE_2_START_ADDR	(PAGE_2_OFFSET)
#define PAGE_2_END_ADDR		(PAGE_2_START_ADDR + HW_FLASH_ALLOCATION_SIZE)
#define PAGE_3_START_ADDR	(PAGE_3_OFFSET)
#define PAGE_3_END_ADDR		(PAGE_3_START_ADDR + HW_FLASH_ALLOCATION_SIZE)
#define PAGE_4_START_ADDR	(PAGE_4_OFFSET)
#define PAGE_4_END_ADDR		(PAGE_4_START_ADDR + HW_FLASH_ALLOCATION_SIZE)
#define PAGE_5_START_ADDR	(PAGE_5_OFFSET)
#define PAGE_5_END_ADDR		(PAGE_5_START_ADDR + HW_FLASH_ALLOCATION_SIZE)
#define PAGE_6_START_ADDR	(PAGE_6_OFFSET)
#define PAGE_6_END_ADDR		(PAGE_6_START_ADDR + HW_FLASH_ALLOCATION_SIZE)
#define PAGE_7_START_ADDR	(PAGE_7_OFFSET)
#define PAGE_7_END_ADDR		(PAGE_7_START_ADDR + HW_FLASH_ALLOCATION_SIZE)

//
//	Now we will explicitly create macros for each option word value.  We will
//	create a set of valid option words and a set of invalid option words.
//	
//	Note that since we will compile this data initialization with the Nios II
//	compiler, we accumulate the word in little endian order as a Nios II would.
//	So the word actaully looks like this (BYTE_3, BYTE_2, BYTE_1, BYTE_0).
//	However, when it gets compiled and output into an SREC file for flash
//	programming, the byte order will be (BYTE_0, BYTE_1, BYTE_2, BYTE_3).
//
#define OPTION_WORD_0	((ADDR_LO(PAGE_0_START_ADDR) << 0) | (ADDR_HI(PAGE_0_START_ADDR) << 8) | (ADDR_LO(PAGE_0_END_ADDR) << 16) | (ADDR_HI(PAGE_0_END_ADDR) << 24))
#define OPTION_WORD_1	((ADDR_LO(PAGE_1_START_ADDR) << 0) | (ADDR_HI(PAGE_1_START_ADDR) << 8) | (ADDR_LO(PAGE_1_END_ADDR) << 16) | (ADDR_HI(PAGE_1_END_ADDR) << 24))
#define OPTION_WORD_2	((ADDR_LO(PAGE_2_START_ADDR) << 0) | (ADDR_HI(PAGE_2_START_ADDR) << 8) | (ADDR_LO(PAGE_2_END_ADDR) << 16) | (ADDR_HI(PAGE_2_END_ADDR) << 24))
#define OPTION_WORD_3	((ADDR_LO(PAGE_3_START_ADDR) << 0) | (ADDR_HI(PAGE_3_START_ADDR) << 8) | (ADDR_LO(PAGE_3_END_ADDR) << 16) | (ADDR_HI(PAGE_3_END_ADDR) << 24))
#define OPTION_WORD_4	((ADDR_LO(PAGE_4_START_ADDR) << 0) | (ADDR_HI(PAGE_4_START_ADDR) << 8) | (ADDR_LO(PAGE_4_END_ADDR) << 16) | (ADDR_HI(PAGE_4_END_ADDR) << 24))
#define OPTION_WORD_5	((ADDR_LO(PAGE_5_START_ADDR) << 0) | (ADDR_HI(PAGE_5_START_ADDR) << 8) | (ADDR_LO(PAGE_5_END_ADDR) << 16) | (ADDR_HI(PAGE_5_END_ADDR) << 24))
#define OPTION_WORD_6	((ADDR_LO(PAGE_6_START_ADDR) << 0) | (ADDR_HI(PAGE_6_START_ADDR) << 8) | (ADDR_LO(PAGE_6_END_ADDR) << 16) | (ADDR_HI(PAGE_6_END_ADDR) << 24))
#define OPTION_WORD_7	((ADDR_LO(PAGE_7_START_ADDR) << 0) | (ADDR_HI(PAGE_7_START_ADDR) << 8) | (ADDR_LO(PAGE_7_END_ADDR) << 16) | (ADDR_HI(PAGE_7_END_ADDR) << 24))

#define UNUSED_OPTION_WORD_0	((UNUSED_ADDR_LO(PAGE_0_START_ADDR) << 0) | (ADDR_HI(PAGE_0_START_ADDR) << 8) | (ADDR_LO(PAGE_0_END_ADDR) << 16) | (ADDR_HI(PAGE_0_END_ADDR) << 24))
#define UNUSED_OPTION_WORD_1	((UNUSED_ADDR_LO(PAGE_1_START_ADDR) << 0) | (ADDR_HI(PAGE_1_START_ADDR) << 8) | (ADDR_LO(PAGE_1_END_ADDR) << 16) | (ADDR_HI(PAGE_1_END_ADDR) << 24))
#define UNUSED_OPTION_WORD_2	((UNUSED_ADDR_LO(PAGE_2_START_ADDR) << 0) | (ADDR_HI(PAGE_2_START_ADDR) << 8) | (ADDR_LO(PAGE_2_END_ADDR) << 16) | (ADDR_HI(PAGE_2_END_ADDR) << 24))
#define UNUSED_OPTION_WORD_3	((UNUSED_ADDR_LO(PAGE_3_START_ADDR) << 0) | (ADDR_HI(PAGE_3_START_ADDR) << 8) | (ADDR_LO(PAGE_3_END_ADDR) << 16) | (ADDR_HI(PAGE_3_END_ADDR) << 24))
#define UNUSED_OPTION_WORD_4	((UNUSED_ADDR_LO(PAGE_4_START_ADDR) << 0) | (ADDR_HI(PAGE_4_START_ADDR) << 8) | (ADDR_LO(PAGE_4_END_ADDR) << 16) | (ADDR_HI(PAGE_4_END_ADDR) << 24))
#define UNUSED_OPTION_WORD_5	((UNUSED_ADDR_LO(PAGE_5_START_ADDR) << 0) | (ADDR_HI(PAGE_5_START_ADDR) << 8) | (ADDR_LO(PAGE_5_END_ADDR) << 16) | (ADDR_HI(PAGE_5_END_ADDR) << 24))
#define UNUSED_OPTION_WORD_6	((UNUSED_ADDR_LO(PAGE_6_START_ADDR) << 0) | (ADDR_HI(PAGE_6_START_ADDR) << 8) | (ADDR_LO(PAGE_6_END_ADDR) << 16) | (ADDR_HI(PAGE_6_END_ADDR) << 24))
#define UNUSED_OPTION_WORD_7	((UNUSED_ADDR_LO(PAGE_7_START_ADDR) << 0) | (ADDR_HI(PAGE_7_START_ADDR) << 8) | (ADDR_LO(PAGE_7_END_ADDR) << 16) | (ADDR_HI(PAGE_7_END_ADDR) << 24))


//	Now we allocate an initialized array with the values for our option words.

unsigned long option_words[8] __attribute__((section("option_bits"))) = {
	(unsigned long)(OPTION_WORD_0),			/* USER EDIT - assign OPTION_WORD_x or UNUSED_OPTION_WORD_x */
	(unsigned long)(OPTION_WORD_1),			/* USER EDIT - assign OPTION_WORD_x or UNUSED_OPTION_WORD_x */
	(unsigned long)(OPTION_WORD_2),			/* USER EDIT - assign OPTION_WORD_x or UNUSED_OPTION_WORD_x */
	(unsigned long)(UNUSED_OPTION_WORD_3),	/* USER EDIT - assign OPTION_WORD_x or UNUSED_OPTION_WORD_x */
	(unsigned long)(UNUSED_OPTION_WORD_4),	/* USER EDIT - assign OPTION_WORD_x or UNUSED_OPTION_WORD_x */
	(unsigned long)(UNUSED_OPTION_WORD_5),	/* USER EDIT - assign OPTION_WORD_x or UNUSED_OPTION_WORD_x */
	(unsigned long)(UNUSED_OPTION_WORD_6),	/* USER EDIT - assign OPTION_WORD_x or UNUSED_OPTION_WORD_x */
	(unsigned long)(UNUSED_OPTION_WORD_7)	/* USER EDIT - assign OPTION_WORD_x or UNUSED_OPTION_WORD_x */
};

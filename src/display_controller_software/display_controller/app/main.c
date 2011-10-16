#include <sys/alt_alarm.h>
#include "system.h"
#include "io.h"
#include "seven_seg.h"

#include "init_strings.h"

// prototypes for gfx display public routines
extern void init_gfx_display(void);
extern void clear_gfx_buffer(void);
extern void copy_gfx_buffer_to_gfx_display(void);
extern void gfx_display_put_str(char *str);

// prototypes for chr display public routines
extern void init_chr_display(void);
extern void clear_chr_buffer(void);
extern void copy_chr_buffer_to_chr_display(void);
extern void chr_display_put_str(char *str);

// prototypes for seven segment display public routines
extern alt_u32 seven_seg_alarm_callback (void* context);
void set_seven_seg_display(alt_u32 *the_seven_seg_context, alt_u32 new_value, alt_u32 new_digit_enable, alt_u32 new_dp_bits, alt_u32 new_minus_bit);
void set_seven_seg_vector(alt_u32 *the_seven_seg_context, alt_u32 new_vector);

// this system will keep track of seconds that have elapsed with an alarm
#define ONE_SECOND_TIMOUT	(alt_ticks_per_second())

alt_u32 one_second_alarm_callback (void* context)
{
	alt_u32 *one_second_count;
	
	one_second_count = (alt_u32 *)(context);
	(*one_second_count) = (*one_second_count) + 1;
	
	return ONE_SECOND_TIMOUT;
}

// this utility routine converts data to ascii characters
const char hex_table[16] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };

void convert_hex_word(char *hex_word, alt_u32 value) {
	int i;
	
	for(i = 0 ; i < 8 ; i++) {
		hex_word[i] = hex_table[((alt_u8)((value >> ((7 - i) * 4)) & 0x0F))];
	}
	hex_word[8] = '\0';
	return;
}

// these commands are used to communicate over the fifo with the display controller
#define COMMAND_MASK	(0xC0000000)
#define COMMAND_OFST	(30)
#define COMMAND_NOP		(0x00)
#define COMMAND_7SEG	(0x01)
#define COMMAND_CHR		(0x02)
#define COMMAND_GFX		(0x03)

int main()
{ 
	int result;
	alt_alarm seven_seg_alarm;
	alt_alarm one_second_alarm;
	volatile alt_u32 seven_seg_context = 0;
	volatile alt_u32 one_second_context = 0;
	alt_u32 last_second_value = 0;
	char hex_string[9];
	alt_u32 one_second_update_active = 1;
	alt_u32 next_command;
	
	// start the seven segment alarm to paint the seven segment display
	result = alt_alarm_start (
					&seven_seg_alarm,			// alt_alarm* alarm,
					SEVEN_SEG_TIMOUT,			// alt_u32 nticks,
					&seven_seg_alarm_callback,	// alt_u32 (*callback) (void* context),
					(void*)&seven_seg_context	// void* context
				);

	if(result) {
		while(1);
	}

	// start the one second alarm
	result = alt_alarm_start (
					&one_second_alarm,			// alt_alarm* alarm,
					ONE_SECOND_TIMOUT,			// alt_u32 nticks,
					&one_second_alarm_callback,	// alt_u32 (*callback) (void* context),
					(void*)&one_second_context	// void* context
				);

	if(result) {
		while(1);
	}

	// initialize gfx display
	init_gfx_display();
	clear_gfx_buffer();
	copy_gfx_buffer_to_gfx_display();
	
	// initialize chr display
	init_chr_display();
	clear_chr_buffer();
	copy_chr_buffer_to_chr_display();
	
	// display some stuff
	chr_display_put_str("\nWind River Linux");
	chr_display_put_str("\n  for Nios II");
	
	// display some stuff
	gfx_display_put_str("\nID: 0x");
	convert_hex_word(hex_string, IORD_32DIRECT(SYSID_BASE, 0));
	gfx_display_put_str(hex_string);
	gfx_display_put_str("\nTS: 0x");
	convert_hex_word(hex_string, IORD_32DIRECT(SYSID_BASE, 4));
	gfx_display_put_str(hex_string);
	gfx_display_put_str(LINE_3_TXT);
	gfx_display_put_str(LINE_4_TXT);
	gfx_display_put_str(LINE_5_TXT);
			
	// start the seven segment display
	set_seven_seg_vector((alt_u32*)&seven_seg_context, 0x00F00000);
	
	// event loop never exits
	while(1) {
		// service the one second display on seven segments
		if(last_second_value != one_second_context) {
				last_second_value = one_second_context;
				if(one_second_update_active) {
					set_seven_seg_display((alt_u32*)&seven_seg_context, last_second_value, 0x0F, 0x00, 0x00);
			}
		}
		
		// monitor the fifo for display commands
		if(IORD_32DIRECT(DISPLAY_FIFO_IN_CSR_BASE, 0)) {
			next_command = IORD_32DIRECT(DISPLAY_FIFO_OUT_BASE, 0);
			switch((next_command & COMMAND_MASK) >> COMMAND_OFST) {
			case(COMMAND_7SEG):
				one_second_update_active = 0;
				set_seven_seg_vector((alt_u32*)&seven_seg_context, next_command & ~COMMAND_MASK);
				break;
			case(COMMAND_CHR):
				hex_string[0] = next_command & 0xFF;
				hex_string[1] = '\0';
				chr_display_put_str(hex_string);
				break;
			case(COMMAND_GFX):
				hex_string[0] = next_command & 0xFF;
				hex_string[1] = '\0';
				gfx_display_put_str(hex_string);
				break;
			case(COMMAND_NOP):
				if(next_command == 0x0A55A55A) {
					// initialize gfx display
					init_gfx_display();
					clear_gfx_buffer();
					copy_gfx_buffer_to_gfx_display();
					
					// initialize chr display
					init_chr_display();
					clear_chr_buffer();
					copy_chr_buffer_to_chr_display();
					
					// display some stuff
					chr_display_put_str("\nWind River Linux");
					chr_display_put_str("\n  for Nios II");
					
					// display some stuff
					gfx_display_put_str("\nID: 0x");
					convert_hex_word(hex_string, IORD_32DIRECT(SYSID_BASE, 0));
					gfx_display_put_str(hex_string);
					gfx_display_put_str("\nTS: 0x");
					convert_hex_word(hex_string, IORD_32DIRECT(SYSID_BASE, 4));
					gfx_display_put_str(hex_string);
					gfx_display_put_str(LINE_3_TXT);
					gfx_display_put_str(LINE_4_TXT);
					gfx_display_put_str(LINE_5_TXT);
							
					// start the seven segment display
					set_seven_seg_vector((alt_u32*)&seven_seg_context, 0x00F00000);
					
					one_second_update_active = 1;
				}
				break;
			default:
				break;
			}
		}
	}

	return 0;
}

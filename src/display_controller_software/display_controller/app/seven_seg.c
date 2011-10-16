#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include "seven_seg.h"
#include <sys/alt_alarm.h>
#include <sys/alt_irq.h>

const alt_u8 digit_map[16] = {
		_0_DIGIT,
		_1_DIGIT,
		_2_DIGIT,
		_3_DIGIT,
		_4_DIGIT,
		_5_DIGIT,
		_6_DIGIT,
		_7_DIGIT,
		_8_DIGIT,
		_9_DIGIT,
		_A_DIGIT,
		_B_DIGIT,
		_C_DIGIT,
		_D_DIGIT,
		_E_DIGIT,
		_F_DIGIT
};

alt_u32 seven_seg_alarm_callback (void* context)
{
	alt_u32 *seven_seg_status_ptr;
	alt_u32 seven_seg_status;
	alt_u32 current_digit;
	alt_u32 this_digit_value;
	alt_u8 this_digit_pattern;
	
	seven_seg_status_ptr = (alt_u32 *)(context);
	seven_seg_status = *seven_seg_status_ptr;
		
	// manipulate the minus sign
	if(seven_seg_status & MINUS_MASK) {
		IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_MINUS_BASE, 0);
	} else {
		IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_MINUS_BASE, 1);
	}
		
	// turn off the current digit
	IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_ABCDEFGDP_BASE, 0xFF);
	
	// manipulate the next digit
	current_digit = (seven_seg_status & CURRENT_DIGIT_MASK) >> CURRENT_DIGIT_OFST;
	current_digit++;
	current_digit &= 0x03;
	IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_SEL_1234_BASE, (1 << current_digit));
	
	switch(current_digit) {
	case(0):
		this_digit_pattern = 0;
		if(seven_seg_status & DIGIT_0_ENABLE_MASK) {
			this_digit_value = (seven_seg_status & DIGIT_0_VALUE_MASK) >> DIGIT_0_VALUE_OFST;
			this_digit_pattern = digit_map[this_digit_value];
			this_digit_pattern |= (seven_seg_status & DP_0_VALUE_MASK) ? (1) : (0);
		}
		this_digit_pattern |= (seven_seg_status & DP_0_VALUE_MASK) >> DP_0_VALUE_OFST;
		IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_ABCDEFGDP_BASE, ~this_digit_pattern);
		break;
	case(1):
		this_digit_pattern = 0;
		if(seven_seg_status & DIGIT_1_ENABLE_MASK) {
			this_digit_value = (seven_seg_status & DIGIT_1_VALUE_MASK) >> DIGIT_1_VALUE_OFST;
			this_digit_pattern = digit_map[this_digit_value];
			this_digit_pattern |= (seven_seg_status & DP_1_VALUE_MASK) ? (1) : (0);
		}
		this_digit_pattern |= (seven_seg_status & DP_1_VALUE_MASK) >> DP_1_VALUE_OFST;
		IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_ABCDEFGDP_BASE, ~this_digit_pattern);
		break;
	case(2):
		this_digit_pattern = 0;
		if(seven_seg_status & DIGIT_2_ENABLE_MASK) {
			this_digit_value = (seven_seg_status & DIGIT_2_VALUE_MASK) >> DIGIT_2_VALUE_OFST;
			this_digit_pattern = digit_map[this_digit_value];
			this_digit_pattern |= (seven_seg_status & DP_2_VALUE_MASK) ? (1) : (0);
		}
		this_digit_pattern |= (seven_seg_status & DP_2_VALUE_MASK) >> DP_2_VALUE_OFST;
		IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_ABCDEFGDP_BASE, ~this_digit_pattern);
		break;
	case(3):
	default:
		this_digit_pattern = 0;
		if(seven_seg_status & DIGIT_3_ENABLE_MASK) {
			this_digit_value = (seven_seg_status & DIGIT_3_VALUE_MASK) >> DIGIT_3_VALUE_OFST;
			this_digit_pattern = digit_map[this_digit_value];
			this_digit_pattern |= (seven_seg_status & DP_3_VALUE_MASK) ? (1) : (0);
		}
		this_digit_pattern |= (seven_seg_status & DP_3_VALUE_MASK) >> DP_3_VALUE_OFST;
		IOWR_ALTERA_AVALON_PIO_DATA(SEVEN_SEG_ABCDEFGDP_BASE, ~this_digit_pattern);
		break;
	}
	
	seven_seg_status = (seven_seg_status & ~CURRENT_DIGIT_MASK) | (current_digit << CURRENT_DIGIT_OFST);
	*seven_seg_status_ptr = seven_seg_status;
	
	return SEVEN_SEG_TIMOUT;
}

void set_seven_seg_display(alt_u32 *the_seven_seg_context, alt_u32 new_value, alt_u32 new_digit_enable, alt_u32 new_dp_bits, alt_u32 new_minus_bit) {
	alt_irq_context irq_context;
	alt_u32 initial_context;
	alt_u32 current_state;
	
	initial_context = (new_value) & (DIGIT_3_VALUE_MASK | DIGIT_2_VALUE_MASK | DIGIT_1_VALUE_MASK | DIGIT_0_VALUE_MASK);
	initial_context |= (new_digit_enable << DIGIT_0_ENABLE_OFST) & (DIGIT_3_ENABLE_MASK | DIGIT_2_ENABLE_MASK | DIGIT_1_ENABLE_MASK | DIGIT_0_ENABLE_MASK);
	initial_context |= (new_dp_bits << DP_0_VALUE_OFST) & (DP_3_VALUE_MASK | DP_2_VALUE_MASK | DP_1_VALUE_MASK | DP_0_VALUE_MASK);
	initial_context |= (new_minus_bit << MINUS_OFST) & (MINUS_MASK);
	
	irq_context = alt_irq_disable_all();
	
	current_state = *the_seven_seg_context & CURRENT_DIGIT_MASK;
	*the_seven_seg_context = current_state | initial_context;
	
	alt_irq_enable_all(irq_context);
}

void set_seven_seg_vector(alt_u32 *the_seven_seg_context, alt_u32 new_vector) {
	alt_irq_context irq_context;
	alt_u32 initial_context;
	alt_u32 current_state;
	
	initial_context = (new_vector) & (~CURRENT_DIGIT_MASK);
	
	irq_context = alt_irq_disable_all();
	
	current_state = *the_seven_seg_context & CURRENT_DIGIT_MASK;
	*the_seven_seg_context = current_state | initial_context;
	
	alt_irq_enable_all(irq_context);
}

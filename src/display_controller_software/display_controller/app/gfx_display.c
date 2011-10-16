#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "io.h"
#include "alt_types.h"
#include "os/alt_syscall.h"
#include "unistd.h"

#define GFX_RESET_PIO	GRAPHICS_LCD_RESETN_PIO_BASE
#define GFX_BASE		GRAPHICS_LCD_BASE
#define GFX_CNTL		(0)
#define GFX_DATA		(1)

#define GFX_CHAR_HEIGHT	(12)

alt_u8 my_gfx_buffer[1024];
int gfx_current_column = 0;
extern unsigned char character_bitmaps[128][12];

void init_gfx_display(void) {
	
	// apply hardware reset to the graphics display
	IOWR_ALTERA_AVALON_PIO_DATA(GFX_RESET_PIO, 0);
	ALT_USLEEP(2);
	IOWR_ALTERA_AVALON_PIO_DATA(GFX_RESET_PIO, 1);
	ALT_USLEEP(2);
	
	// initialize registers according to user guide suggestions
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xA2);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xA1);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xC0);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x40);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x20);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x81);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x20);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x2B);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xA4);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xE7);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xAF);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xB0);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x10);
	IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x00);
	
	// initialize the current column global
	gfx_current_column = 0;
}

void clear_gfx_buffer(void) {
	int i;
	
	for(i = 0 ; i < 1024 ; i++) {
		my_gfx_buffer[i] = 0x00;
	}
}

void copy_gfx_buffer_to_gfx_display(void) {
	
	int i;
	int j;
	alt_u8 temp, temp_0, temp_1, temp_2, temp_3, temp_4, temp_5, temp_6, temp_7;
	int row;
	
	for(row = 0 ; row < 8 ; row++) {
		IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xB0 + row);
		IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x10);
		IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x00);
		for(i = 0 ; i < 16 ; i++) {
			temp_0 = my_gfx_buffer[(row * 16 * 8) + i + (0 * 16)];
			temp_1 = my_gfx_buffer[(row * 16 * 8) + i + (1 * 16)];
			temp_2 = my_gfx_buffer[(row * 16 * 8) + i + (2 * 16)];
			temp_3 = my_gfx_buffer[(row * 16 * 8) + i + (3 * 16)];
			temp_4 = my_gfx_buffer[(row * 16 * 8) + i + (4 * 16)];
			temp_5 = my_gfx_buffer[(row * 16 * 8) + i + (5 * 16)];
			temp_6 = my_gfx_buffer[(row * 16 * 8) + i + (6 * 16)];
			temp_7 = my_gfx_buffer[(row * 16 * 8) + i + (7 * 16)];

			for(j = 0 ; j < 8 ; j++) {
				temp = 0;
				temp |= ((temp_7 & (1 << (7 - j))) ? (1) : (0)) << 7;
				temp |= ((temp_6 & (1 << (7 - j))) ? (1) : (0)) << 6;
				temp |= ((temp_5 & (1 << (7 - j))) ? (1) : (0)) << 5;
				temp |= ((temp_4 & (1 << (7 - j))) ? (1) : (0)) << 4;
				temp |= ((temp_3 & (1 << (7 - j))) ? (1) : (0)) << 3;
				temp |= ((temp_2 & (1 << (7 - j))) ? (1) : (0)) << 2;
				temp |= ((temp_1 & (1 << (7 - j))) ? (1) : (0)) << 1;
				temp |= ((temp_0 & (1 << (7 - j))) ? (1) : (0)) << 0;
				IOWR_8DIRECT(GFX_BASE, GFX_DATA, temp);
			}
		}
	}
}

void copy_bottom_two_to_gfx_display(void) {
	
	int i;
	int j;
	alt_u8 temp, temp_0, temp_1, temp_2, temp_3, temp_4, temp_5, temp_6, temp_7;
	int row;
	
	for(row = 6 ; row < 8 ; row++) {
		IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0xB0 + row);
		IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x10);
		IOWR_8DIRECT(GFX_BASE, GFX_CNTL, 0x00);
		for(i = 0 ; i < 16 ; i++) {
			temp_0 = my_gfx_buffer[(row * 16 * 8) + i + (0 * 16)];
			temp_1 = my_gfx_buffer[(row * 16 * 8) + i + (1 * 16)];
			temp_2 = my_gfx_buffer[(row * 16 * 8) + i + (2 * 16)];
			temp_3 = my_gfx_buffer[(row * 16 * 8) + i + (3 * 16)];
			temp_4 = my_gfx_buffer[(row * 16 * 8) + i + (4 * 16)];
			temp_5 = my_gfx_buffer[(row * 16 * 8) + i + (5 * 16)];
			temp_6 = my_gfx_buffer[(row * 16 * 8) + i + (6 * 16)];
			temp_7 = my_gfx_buffer[(row * 16 * 8) + i + (7 * 16)];

			for(j = 0 ; j < 8 ; j++) {
				temp = 0;
				temp |= ((temp_7 & (1 << (7 - j))) ? (1) : (0)) << 7;
				temp |= ((temp_6 & (1 << (7 - j))) ? (1) : (0)) << 6;
				temp |= ((temp_5 & (1 << (7 - j))) ? (1) : (0)) << 5;
				temp |= ((temp_4 & (1 << (7 - j))) ? (1) : (0)) << 4;
				temp |= ((temp_3 & (1 << (7 - j))) ? (1) : (0)) << 3;
				temp |= ((temp_2 & (1 << (7 - j))) ? (1) : (0)) << 2;
				temp |= ((temp_1 & (1 << (7 - j))) ? (1) : (0)) << 1;
				temp |= ((temp_0 & (1 << (7 - j))) ? (1) : (0)) << 0;
				IOWR_8DIRECT(GFX_BASE, GFX_DATA, temp);
			}
		}
	}
}

void scroll_gfx_buffer_up_one_char_row(void) {
	int dst_line = 4;
	int src_line = dst_line + 12;
	int i;
	int j;
	
	for(i = 0 ; i < (5 * 12) ; i++) {
		for(j = 0 ; j < 16 ; j++) {
			my_gfx_buffer[((dst_line + i) * 16) + j] = my_gfx_buffer[((src_line + i) * 16) + j];
		}
	}
}

void clear_gfx_buffer_last_char_row(void) {
	int dst_line = 64 - 12;
	int i;
	int j;
	
	for(i = 0 ; i < 12 ; i++) {
		for(j = 0 ; j < 16 ; j++) {
			my_gfx_buffer[((dst_line + i) * 16) + j] = 0x00;
		}
	}
}

void gfx_display_put_char(char c) {
	int dst_line = 64 - 12;
	int i;

	for(i = 0 ; i < 12 ; i++) {
		my_gfx_buffer[((dst_line + i) * 16) + gfx_current_column] = character_bitmaps[(int)(c)][i];
	}
}

void gfx_display_put_str(char *str) {
	char c;
	int redraw_screen = 0;
	int redraw_last_row = 0;
	
	c = *str++;
	while(c != '\0') {
		if(c > 0) {
			if(c == '\n') {
				scroll_gfx_buffer_up_one_char_row();
				clear_gfx_buffer_last_char_row();
				gfx_current_column = 0;
				redraw_screen = 1;
			} else if(c == '\r') {
				clear_gfx_buffer_last_char_row();
				gfx_current_column = 0;
				redraw_last_row = 1;
			} else if(c == '\b') {
				gfx_current_column--;
				if(gfx_current_column < 0){
					gfx_current_column = 0;					
				}
				gfx_display_put_char(' ');
				redraw_last_row = 1;
			} else if(gfx_current_column < 16) {
				gfx_display_put_char(c);
				gfx_current_column++;
				redraw_last_row = 1;
			}
		}
		c = *str++;
	}
	
	if(redraw_screen) {
		copy_gfx_buffer_to_gfx_display();
	} else if(redraw_last_row){
		copy_bottom_two_to_gfx_display();		
	}
}

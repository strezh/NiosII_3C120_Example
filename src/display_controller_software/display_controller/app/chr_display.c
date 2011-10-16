#include "system.h"
#include "io.h"
#include "alt_types.h"
#include "string.h"

#define CHR_RD_BASE		CHARACTER_LCD_RD_BASE
#define CHR_WR_BASE		CHARACTER_LCD_WR_BASE
#define CHR_CNTL		(0)
#define CHR_DATA		(1)

#define BUSY_FLAG_MASK	(0x80)
#define ADDR_CNT_MASK	(0x7F)

#define CLEAR_DISPLAY_CMD	(0x01)
#define RETURN_HOME_CMD		(0x02)
#define ENTRY_MODE_SET_CMD	(0x06)
#define DISPLAY_ON_CMD		(0x0C)
#define FUNCTION_SET_CMD	(0x3C)
#define SET_LINE_1_CMD		(0x80)
#define SET_LINE_2_CMD		(0xC0)

char my_chr_buffer[2][16];
int chr_current_column = 0;

void wait_chr_display_not_busy(void) {
	while(IORD_8DIRECT(CHR_RD_BASE, CHR_CNTL) & BUSY_FLAG_MASK);
}

void init_chr_display(void) {
	wait_chr_display_not_busy();
	IOWR_8DIRECT(CHR_WR_BASE, CHR_CNTL, FUNCTION_SET_CMD);
	wait_chr_display_not_busy();
	IOWR_8DIRECT(CHR_WR_BASE, CHR_CNTL, DISPLAY_ON_CMD);
	wait_chr_display_not_busy();
	IOWR_8DIRECT(CHR_WR_BASE, CHR_CNTL, CLEAR_DISPLAY_CMD);
	wait_chr_display_not_busy();
	IOWR_8DIRECT(CHR_WR_BASE, CHR_CNTL, ENTRY_MODE_SET_CMD);
	
	chr_current_column = 0;
}

void clear_chr_buffer(void) {
	memset(&my_chr_buffer[0][0], ' ', 32);
}

void scroll_chr_buffer_up_one_char_row(void) {
	memcpy(&my_chr_buffer[0][0], &my_chr_buffer[1][0], 16);
}

void clear_chr_buffer_last_char_row(void) {
	memset(&my_chr_buffer[1][0], ' ', 16);
}

void copy_chr_buffer_to_chr_display(void) {
	int i;
	
	wait_chr_display_not_busy();
	IOWR_8DIRECT(CHR_WR_BASE, CHR_CNTL, SET_LINE_1_CMD);
	for(i = 0 ; i < 16 ; i++) {
		wait_chr_display_not_busy();
		IOWR_8DIRECT(CHR_WR_BASE, CHR_DATA, my_chr_buffer[0][i]);
	}

	wait_chr_display_not_busy();
	IOWR_8DIRECT(CHR_WR_BASE, CHR_CNTL, SET_LINE_2_CMD);
	for(i = 0 ; i < 16 ; i++) {
		wait_chr_display_not_busy();
		IOWR_8DIRECT(CHR_WR_BASE, CHR_DATA, my_chr_buffer[1][i]);
	}
}

void chr_display_put_char(char c) {
	my_chr_buffer[1][chr_current_column] = c;
}

void chr_display_put_str(char *str) {
	char c;
	int redraw_screen = 0;
	
	c = *str++;
	while(c != '\0') {
		if(c > 0) {
			if(c == '\n') {
				scroll_chr_buffer_up_one_char_row();
				clear_chr_buffer_last_char_row();
				chr_current_column = 0;
				redraw_screen = 1;
			} else if(c == '\r') {
				clear_chr_buffer_last_char_row();
				chr_current_column = 0;
				redraw_screen = 1;
			} else if(c == '\b') {
				chr_current_column--;
				if(chr_current_column < 0) {
					chr_current_column = 0;
				}
				chr_display_put_char(' ');
				redraw_screen = 1;				
			} else if(chr_current_column < 16) {
				chr_display_put_char(c);
				chr_current_column++;
				redraw_screen = 1;
			}
		}
		c = *str++;
	}
	
	if(redraw_screen) {
		copy_chr_buffer_to_chr_display();
	}
}

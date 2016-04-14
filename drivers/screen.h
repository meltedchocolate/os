#ifndef SCREEN_H
#define SCREEN_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

//Define colors
enum vga_color {
	COLOR_BLACK = 0,
	COLOR_BLUE = 1,
	COLOR_GREEN = 2,
	COLOR_CYAN = 3,
	COLOR_RED = 4,
	COLOR_MAGENTA = 5,
	COLOR_BROWN = 6,
	COLOR_LIGHT_GREY = 7,
	COLOR_DARK_GREY = 8,
	COLOR_LIGHT_BLUE = 9,
	COLOR_LIGHT_GREEN = 10,
	COLOR_LIGHT_CYAN = 11,
	COLOR_LIGHT_RED = 12,
	COLOR_LIGHT_MAGENTA = 13,
	COLOR_LIGHT_BROWN = 14,
	COLOR_WHITE = 15,
};

#define VIDEO_ADDRESS 0xB8000
#define VGA_HEIGHT 25
#define VGA_WIDTH 80

uint8_t color(enum vga_color fg, enum vga_color bg) {
	return fg | bg << 4;
}

uint16_t vga_entry(char c, uint8_t color) {
	uint16_t char16 = c;
	uint16_t color16 = color;
	return char16 | color16 << 8;
}

void setcursor(unsigned int row, unsigned int column) {
		int offset = ((row*VGA_WIDTH + column) * 2);
		port_byte_out(0x3D4, 14);
		port_byte_out(0x3D5, (unsigned char)(offset >> 8));
		port_byte_out(0x3D4, 15);
		port_byte_out(0x3D5, (unsigned char)(offset));
}

void putchar(char c, uint8_t color, unsigned int row, unsigned int column) {
	uint16_t* vidmem = (uint16_t *)VIDEO_ADDRESS;
	unsigned int offset = row*VGA_WIDTH + column;
	vidmem[offset] = vga_entry(c, color);
}
#endif
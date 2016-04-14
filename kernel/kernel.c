#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "../drivers/screen.h"
#include "strutil.h"
void main() {
	char * message = "THIS IS MY KERNEL AND I WROTE IT AND I AM VERY PROUD OF MYSELF FOR DOING THAT";
	int len = strlen(message);
	for (int i = 0; i < len; i++) {
		putchar(message[i], color(COLOR_GREEN, COLOR_DARK_GREY), 0, i);
	}
}
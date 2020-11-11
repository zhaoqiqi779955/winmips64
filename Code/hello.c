#include <stdio.h>
#include <string.h>

int main() {
	char str[] = "Hello World!";
	char * p = str;
	for(; (*p) != '\0'; ++p) {
		printf("\'%c\', ", *p);
	}
	printf("\n");
	return 0;
}


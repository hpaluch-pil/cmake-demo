// demoapp.c - demo application using demolib

#include <stdio.h>
#include <stdlib.h>

#include "demolib.h"


int main(int argc, char **argv)
{
	printf("demo_call returned %d\n", demo_call());
	return EXIT_SUCCESS;
}


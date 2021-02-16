
ASM			= nasm.exe
CC 			= gcc.exe
CPP 		= g++.exe
CFLAGS		= -nostdlib -fno-stack-protector -fno-builtin -W -Wall -m32
PYTHON		= python.exe

.PHONY:all

all:
	$(ASM) .\boot\MBR.S -o .\boot\MBR.bin
	$(ASM) .\boot\Loader.S -o .\boot\Loader.bin
	$(CPP) .\cpp\main.cpp -o .\pe.exe $(CFLAGS)
	$(PYTHON) .\MakeDisk.py .\hd.img 0 .\boot\MBR.bin 2 .\boot\Loader.bin 16 .\pe.exe
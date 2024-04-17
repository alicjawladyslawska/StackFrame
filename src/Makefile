CC=gcc
RM=rm -f

# General compile & link flags, e.g. to show all warnings and turn off optimisation
GFLAGS = -Wall -Wextra -O0

# Compiler Flags to use for compiling only
CFLAGS = $(GFLAGS) -c -g

TryStackFrames: TryStackFrames.o Factorial.o StackFrame.o
	$(CC) $(GFLAGS) -o TryStackFrames TryStackFrames.o Factorial.o StackFrame.o

%.o: %.c
	$(CC) $(GFLAGS) $(CFLAGS) -o $@ $<

%.s: %.c
	$(CC) $(GFLAGS) -S -o $@ $<



# Targets to clean up your file space

clean:
	$(RM) TryStackFrames *.o *~
	
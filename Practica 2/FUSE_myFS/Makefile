OBJDIR := obj
C_FILES := $(wildcard src/*.c)
OBJ_FILES := $(addprefix $(OBJDIR)/,$(notdir $(C_FILES:.c=.o)))

CFLAGS := -g -O0 -Wall $(shell pkg-config fuse --cflags)
#LDFLAGS := -lreadline $(shell pkg-config fuse --libs)
LDFLAGS := $(shell pkg-config fuse --libs)
CC=gcc

TARGET = fs-fuse

all: $(TARGET)

$(TARGET): $(OBJ_FILES)
	$(CC) -o $@ $^ $(LDFLAGS)
	
obj/%.o: src/%.c
	mkdir -p $(OBJDIR)
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -f ./obj/*.o
	rm -f $(TARGET)

# Use cc/gcc for linking too
LIBRARY_PATH ?= /usr/local/lib

LD = $(CC)
CFLAGS = -Wall -Wextra
LDFLAGS := -lpthread -Wl,-rpath,$(LIBRARY_PATH) -L$(LIBRARY_PATH)

UNAME := $(shell uname)
# Assume target is Mac OS if build host is Mac OS; any other host targets Linux
ifeq ($(UNAME), Darwin)
	LDFLAGS += -lobjc -framework IOKit -framework CoreFoundation
else
	LDFLAGS += -lrt
endif

VERBOSE = 0
ifeq ("$(origin V)", "command line")
  VERBOSE = $(V)
endif

ifeq ($(VERBOSE),1)
  Q =
else
  Q = @
endif

%.o: %.c
	$(Q)echo "CC $@"
	$(Q)$(CC) $< -c -o $@ $(CFLAGS)

%-static:
	$(Q)echo "LD $@"
	$(Q)$(LD) $< -o $@ $(LIBRARY_PATH)/libftd2xx.a $(CFLAGS)

%-dynamic:
	$(Q)echo "LD $@"
	$(Q)$(LD) $< -o $@ -lftd2xx $(CFLAGS)

# $(1): The app name
# The directory use capital letters, and converting to lower caps requires
# the shell and lc, or a long convertion function
define app

  .PHONY: all clean

  all: $(1)-static $(1)-dynamic

  $(1)-static $(1)-dynamic: main.o

  clean:
	$(Q)echo cleaning
	$(Q)rm -f *.o
	$(Q)rm -f $(1)-static
	$(Q)rm -f $(1)-dynamic
endef # app

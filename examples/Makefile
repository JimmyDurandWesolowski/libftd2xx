include Rules.make

SUBDIRS = \
	BitMode \
	EEPROM/erase \
	EEPROM/read \
	EEPROM/write \
	EEPROM/user/read \
	EEPROM/user/size \
	EEPROM/user/write \
	Events \
	LargeRead \
	loopback \
	MultiThread \
	SetVIDPID \
	Simple \
	static \
	Timeouts \
	W32/escapeseq \
	W32/events \
	W32/simple \
	W32/timeouts \
	write

all: subdirs

.PHONY: $(SUBDIRS)

MAKEFLAGS += --no-print-directory

$(SUBDIRS):
	$(Q)$(MAKE) -C $@

%-clean:
	$(Q)echo $@
	$(Q)$(MAKE) -C $(subst -clean,,$@) clean

subdirs: $(SUBDIRS)

clean: $(foreach subdir,$(SUBDIRS),$(subdir)-clean)

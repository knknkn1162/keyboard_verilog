VC=iverilog

WORKDIR=..

INCLUDE_OPTION=$(addprefix -I$(WORKDIR)/, $(INCLUDES))
OPTION=$(INCLUDE_OPTION)

# extract all *.v files and remove extention.
FILES=$(shell find . -type f -name "*_tb.v" | xargs -IFILE basename FILE .v)

all: list $(FILES) clean

list:
	echo $(FILES)

%: %.o
	vvp -N $^

%.o: %.v
	$(VC) ${OPTION} -o $@ $<

open:
	open out.vcd

clean:
	rm -rf *.o *.vcd **/*.o **/*.vcd

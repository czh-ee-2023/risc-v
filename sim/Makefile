.PHONY: vcs verdi clean

#compile command 
VCS	=	vcs +v2k  -timescale=1ns/1ps	\
			-full64	\
			-R 		\
			-debug_access+all	\
			-f filelist.f	\
			+mindelays	\
			-negdelay	\
			+neg_tchk	\
			-l vcs.log

VERDI=Verdi-Ultra -f filelist.f   \
		-ssf *.fsdb    \
		-nologo                \
		-l verdi.log             

#start compile and simulate
vcs:
	$(VCS)

#run verdi
verdi:
	$(VERDI)
	
#clean
clean:
	rm -rf  ./Verdi-SXLog  ./dff ./csrc *.daidir *log *.vpd *.vdb simv* *.key *race.out* *.fsdb *.vpd *.log *.conf *.dat *.conf *.so uart
all:	clean vcs verdi

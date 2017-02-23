# External sources
PBASE=$(shell pwd)

# Targets
TARGETS = .fastqc .homer .picard 

all:   	$(TARGETS)

.fastqc:
	cd src && wget 'http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip' && unzip fastqc_v0.11.5.zip && chmod 755 FastQC/fastqc && rm fastqc_v0.11.5.zip && cd ../ && touch .fastqc

.homer:
	export PATH=${PBASE}/src/gs/bin:${PBASE}/src/weblogo:${PBASE}/src/blat:${PATH} && cd src/homer/ && perl configureHomer.pl -install homer && perl configureHomer.pl -install hg19 && cd ../../ && touch .homer

.picard:
	mkdir -p src/picard/ && cd src/picard && wget -O picard.jar 'https://github.com/broadinstitute/picard/releases/download/2.8.3/picard.jar' && cd ../../ && touch .picard

clean:
	mv src/homer/configureHomer.pl . && rm -rf src/homer/ && mkdir -p src/homer/ && mv configureHomer.pl src/homer/
	rm -rf $(TARGETS) $(TARGETS:=.o) src/FastQC src/picard/

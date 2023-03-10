PROGRAM       = parser
GRAMMARFOLDER = ./Linux/
BUILDFOLDER   = build/
BUILDIO       = build/io
NASM          = nasm
CXX           = g++
FLEX          = flex
BISON         = bison
CXXVER        = c++11
BUILDIOEXIST  = $(shell if [ -d $(BUILDIO) ]; then echo "exist"; else echo "notexist"; fi;)
GRAMMAREXIST  = $(shell if [ -d $(GRAMMARFOLDER) ]; then echo "exist"; else echo "notexist"; fi;)
BUILDEXIST    = $(shell if [ -d $(BUILDFOLDER) ]; then echo "exist"; else echo "notexist"; fi;)
DEPS          = $(shell find ./ -name "*.h")
SRC           = $(shell find ./ -name "*.cpp")
OBJ           = $(SRC:%.cpp=%.o)


grammar: lexer.l grammar.y
ifeq ($(GRAMMAREXIST),notexist)
	mkdir $(GRAMMARFOLDER)
endif
	$(BISON) --output="./Linux/grammar.tab.cpp" --defines="./Linux/grammar.tab.h" grammar.y
	$(FLEX) --outfile="./Linux/lexer.flex.cpp" lexer.l
	sed -i "1i\#include \"../common/trees.h\"" ./Linux/grammar.tab.h

$(PROGRAM): $(OBJ)
	$(CXX) -o $(PROGRAM) $(OBJ) -std=$(CXXVER) -g
	
%.o: %.cpp $(DEPS)
	$(CXX) -c $< -o $@ -std=$(CXXVER) -g

build:
ifeq ($(BUILDEXIST),notexist)
	mkdir $(BUILDFOLDER)
endif
ifeq ($(BUILDIOEXIST),notexist)
	mkdir $(BUILDIO)
endif
	$(NASM) -f elf -d ELF_TYPE common/util/io/asm_io.asm -o common/util/io/asm_io.o
	cp $(PROGRAM) $(BUILDFOLDER)
	cp common/util/io/asm_io.o $(BUILDIO)
	cp common/util/io/asm_io.inc $(BUILDIO)
	cp -r test/ $(BUILDFOLDER)
	cp example/Makefile $(BUILDFOLDER)

clean:
	rm -rf $(GRAMMARFOLDER) $(OBJ) $(PROGRAM) $(BUILDFOLDER) common/util/io/asm_io.o
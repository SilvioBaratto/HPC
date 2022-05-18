SRC = ring.c \
	sum3Dmatrix.c \

CXX = mpicc
CXXFLAGS = -O3 -march=native

EXE = $(SRC:.c=.x)

.SUFFIXES:
SUFFIXES = 

.SUFFIXES: .c .x 

all: $(EXE)

.PHONY: all

%.x: %.c
	$(CXX) $< -o build/$@ $(CXXFLAGS)

format: $(SRC)

.PHONY: format

clean:
	rm -rf $(EXE) *~

.PHONY: clean



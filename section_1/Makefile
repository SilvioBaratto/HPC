CC := mpicc

BUILD_DIR = ./build
all: ring sum3Dmatrix

ring:
	$(CC) ring.c -o $(BUILD_DIR)/ring.x
	
sum3Dmatrix:
	$(CC) sum3Dmatrix.c -o $(BUILD_DIR)/sum3Dmatrix.x

.PHONY: clean
clean:
	rm -f $(BUILD_DIR)/*

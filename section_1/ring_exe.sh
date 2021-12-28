#! /bin/sh
module load openmpi-4.1.1+gnu-9.3.0

rm *.csv
mpicc ring.c -o ring.x

for i in {2..48}
	do
		mpirun -np ${i} --map-by core --mca btl ^openib ring.x 
	done


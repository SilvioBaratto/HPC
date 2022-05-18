#! /bin/sh
module load openmpi-4.1.1+gnu-9.3.0

declare -a nprocs=(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48)

for i in "${nprocs[@]}"
	do
		mpirun -np ${i} --map-by node --mca btl ^openib ring.x 
	done


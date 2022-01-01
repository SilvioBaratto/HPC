#!/bin/bash
module load openmpi-4.1.1+gnu-9.3.0

CWD=/u/dssc/sbaratto/HPC/section_3

mpif77 -ffixed-line-length-none $CWD/Jacobi_MPI_vectormode.F -o $CWD/jacoby3D.x

PROCESSES=(4 8 12)

for process in "${PROCESSES[@]}"
do
	mpirun --mca btl ^openib -np $process --map-by core $CWD/jacoby3D.x <$CWD/input.1200 >$CWD/$process-map-core.txt
	mpirun --mca btl ^openib -np $process --map-by socket $CWD/jacoby3D.x <$CWD/input.1200 >$CWD/$process-map-socket.txt
done

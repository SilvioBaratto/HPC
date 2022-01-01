#! /bin/sh
module load openmpi-4.1.1+gnu-9.3.0

CWD=/u/dssc/sbaratto/HPC/section_3

mpif77 -ffixed-line-length-none $CWD/Jacobi_MPI_vectormode.F -o $CWD/jacoby3D.x

for i in 12 24 48
	do
		mpirun --mca btl ^openib -np $i --map-by node $CWD/jacoby3D.x <$CWD/input.1200 >$CWD/"thin_node_${i}".txt
	done

rm *.dat

#!/bin/bash
module load openmpi-4.1.1+gnu-9.3.0


CWD=/u/dssc/sbaratto/HPC/section_3/

mpif77 -ffixed-line-length-none $CWD/Jacobi_MPI_vectormode.F -o $CWD/jacoby3D.x

mpirun --mca btl ^openib -np 1 $CWD/jacoby3D.x <$CWD/input.1200 > ${CWD}/single_core_gpu.out 
#| sed 's/  4  Maxtime , Mintime + JacobiMi , JacobiMa   //' | sed 's/  4  Maxtime , Mintime + JacobiMi , JacobiMa   //' | sed 's/Residual    //' | sed 's/      MLUPs    /,/' >> "${CWD}/single_core_gpu".csv


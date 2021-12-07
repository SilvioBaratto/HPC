#!bin/bash

module load intel/20.4

#NODE 

for type in tcp mlx verbs
	do
	
	mpirun -np 2 -ppn 1 -genv I_MPI_DEBUG=4 -genv I_MPI_OFI_PROVIDER=$type -f $PBS_NODEFILE ~/mpi-benchmarks/src_c/IMB-MP1 PingPong -msglog 28 > thin_intelMPI_socket_0_1_$type.out

	done	

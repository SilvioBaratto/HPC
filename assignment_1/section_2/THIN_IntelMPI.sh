#!/bin/bash

# NODE
mpirun -np 2 -ppn 1 -genv I_MPI_DEBUG=4 -f $PBS_NODEFILE ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_node_default.out

mpirun -np 2 -ppn 1 -genv I_MPI_DEBUG=4 -genv I_MPI_OFI_PROVIDER=tcp -f $PBS_NODEFILE ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_node_tcp.out

mpirun -np 2 -ppn 1 -genv I_MPI_DEBUG=4 -genv I_MPI_OFI_PROVIDER=mlx -f $PBS_NODEFILE ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_node_mlx.out

mpirun -np 2 -ppn 1 -genv I_MPI_DEBUG=4 -genv I_MPI_OFI_PROVIDER=verbs -f $PBS_NODEFILE ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_node_verbs.out




# SOCKET
mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,1 ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_1_default.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,23 ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_23_default.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,1 -genv I_MPI_OFI_PROVIDER=tcp ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_1_tcp.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,23 -genv I_MPI_OFI_PROVIDER=tcp ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_23_tcp.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,1 -genv I_MPI_OFI_PROVIDER=mlx ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_1_mlx.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,23 -genv I_MPI_OFI_PROVIDER=mlx ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_23_mlx.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,1 -genv I_MPI_OFI_PROVIDER=verbs ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_1_verbs.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,23 -genv I_MPI_OFI_PROVIDER=verbs ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_23_verbs.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,1 -genv I_MPI_FABRICS=ofi ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_1_ofi.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,23 -genv I_MPI_FABRICS=ofi ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_23_ofi.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,1 -genv I_MPI_FABRICS=shm ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_1_shm.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,23 -genv I_MPI_FABRICS=shm ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_socket_0_23_shm.out




# CORE
mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,2 ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_2_default.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,22 ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_22_default.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,2 -genv I_MPI_OFI_PROVIDER=tcp ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_2_tcp.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,22 -genv I_MPI_OFI_PROVIDER=tcp ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_22_tcp.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,2 -genv I_MPI_OFI_PROVIDER=mlx ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_2_mlx.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,22 -genv I_MPI_OFI_PROVIDER=mlx ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_22_mlx.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,2 -genv I_MPI_OFI_PROVIDER=verbs ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_2_verbs.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,22 -genv I_MPI_OFI_PROVIDER=verbs ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_22_verbs.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,2 -genv I_MPI_FABRICS=ofi ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_2_ofi.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,22 -genv I_MPI_FABRICS=ofi ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_22_ofi.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,2 -genv I_MPI_FABRICS=shm ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_2_shm.out

mpirun -np 2 -genv I_MPI_DEBUG=4 -genv I_MPI_PIN_PROCESSOR_LIST=0,22 -genv I_MPI_FABRICS=shm ./IMB-MPI1 PingPong -msglog 28 >thin_intelMPI_core_0_22_shm.out

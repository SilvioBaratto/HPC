# Section 1

This section contains two programs:
* Ring: implementation in C using MPI and P processors on a ring. (simple 1D topology where each processor has a left and right neighbour). The program implement a stream messages in both directions.
* Sum3DMatrix: implementation of a simple 3D matrix-matrix addition in parallel using 1D, 2D and 3D distribution of data using virtual topology. The program accept as input the sizes of the matrixes.

To compile all files on orfeo do:
```bash
module load openmpi-4.1.1+gnu-9.3.0
make
```

## Ring

To execute the ring with `N` processors do:
```bash
mpirun -np 4 --mca btl ^openib ./ring.x
```
## Sum3DMatrix

To run with `N` processors do:
```bash
mpirun -np N --mca btl ^openib sum3Dmatrix.x Nx Ny Nz x y z
```
where `Nx` `Ny` `Nz` are the sizes of the matrixes and `x` `y` `z` are the grid of the virtual topology. 

# Section 2

This section contains the estimation of latency and bandwidth of all available combinations of topologies and networks on ORFEO computational nodes. To performe this benchmark both IntelMPI and openmpi in there lates version where used on ORFEO

# Section 3

Jacobi applications discussed in class

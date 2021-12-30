To compile all files on orfeo do:
```bash
module load openmpi-4.1.1+gnu-9.3.0
make
```

# Ring

To execute the ring with `N` processors do:
```bash
mpirun -np 4 --mca btl ^openib ./ring.x
```
# sum3Dmatrix

To run with `N` processors do:
```bash
mpirun -np N --mca btl ^openib sum3Dmatrix.x Nx Ny Nz x y z
```
where `Nx` `Ny` `Nz` are the sizes of the matrixes and `x` `y` `z` are the grid of the virtual topology. 

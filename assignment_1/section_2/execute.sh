#! /bin/sh
module load openmpi-4.1.1+gnu-9.3.0

for type in core socket node
	do for i in ob1 ucx
		 do for j in tcp vader
			do
				echo "#mpirun  --map-by $type --mca pml $i --mca btl self,$j -np 2 --report-bindings ./IMB-MPI1 PingPong -msglog 28" > "$type-$i-$j".csv
				mpirun  --map-by $type --mca pml $i --mca btl self,$j -np 2 --report-bindings ~/mpi-benchmarks/src_c/IMB-MPI1 PingPong -msglog 28 2>/dev/null | grep -v ^\# | grep -v '^$' | sed 's/   */,/g' | cut -c 2- >> "$type-$i-$j".csv
				echo "$type-$i-$j"
			done
		done
	done

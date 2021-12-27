#!/bin/bash
 
# Name of my job:
#PBS -N jacobi_thin
#PBS -q dssc
#PBS -l nodes=2:ppn=24
#PBS -l walltime=1:00:00 
 
# This command switched to the directory from which the "qsub" command was run:
cd $PBS_O_WORKDIR
 
#  Now run my program
./jacobi_benchmark_thin_node.sh
 
echo Done!

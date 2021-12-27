#!/bin/bash
 
# Name of my job:
#PBS -N jacobi_gpu
#PBS -q dssc_gpu
#PBS -l nodes=1:ppn=48
#PBS -l walltime=1:00:00 
 
# This command switched to the directory from which the "qsub" command was run:
cd $PBS_O_WORKDIR
 
#  Now run my program
./jacobi_benchmark_gpu_node.sh
 
echo Done!

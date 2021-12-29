#!/bin/bash
 
# Name of my job:
#PBS -N matrix
#PBS -q dssc
#PBS -l nodes=1:ppn=24
#PBS -l walltime=00:05:00 
 
# This command switched to the directory from which the "qsub" command was run:
cd $PBS_O_WORKDIR
 
#  Now run my program
./matrix_exe.sh
 
echo Done!

#!/bin/bash
 
# Name of my job:
#PBS -N ring
#PBS -q dssc
#PBS -l nodes=1:ppn=48
#PBS -l walltime=00:10:00 
 
# This command switched to the directory from which the "qsub" command was run:
cd $PBS_O_WORKDIR
 
#  Now run my program
./ring_exe.sh
 
echo Done!

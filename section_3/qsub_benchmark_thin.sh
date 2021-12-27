#!/bin/bash

qsub -l nodes=1:ppn=12 -I -q dssc -l walltime=00:20:00

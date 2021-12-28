#!/bin/bash

mpicc sum3Dmatrix.c -o sum3Dmatrix.x

topology=("topo1" "topo2" "topo3") 
topo1=24
topo2=(6 4 4 6 8 3 3 8 12 2 2 12 24 1 1 24)
topo3=(24 1 1 1 24 1 1 1 24 12 2 1 1 12 2 2 1 12 6 2 2 2 6 2 2 2 6 4 3 2 3 2 4 2 3 4 4 2 3 3 4 2 2 4 3)


distribution=("dist1" "dist2" "dist3")
dist1=("2400" "100" "100")
dist2=("1200" "200" "100")
dist3=("800" "300" "100")


for distribution in "${distribution[@]}"
do
	if [ "$distribution" == "dist1" ];
	then
		mpirun -np 4 sum3Dmatrix.x ${dist1[@]} $topo1
		for((start=0;start< "${#topo2[@]};start+=2"));
		do
			mpirun -np 4 sum3Dmatrix.x ${dist1[@]} ${topo2[@]:$start:2}
		done
		for((start=0;start<"${#topo3[@]};start+=3"));
		do
			mpirun -np 4 sum3Dmatrix.x ${dist1[@]} ${topo3[@]:$start:3}
		done
	elif [ "$distribution" == "dist2" ];
	then
		mpirun -np 4 sum3Dmatrix.x ${dist2[@]} $topo1
		for((start=0;start<"${#topo2[@]};start+=2"));
		do
			mpirun -np 4 sum3Dmatrix.x ${dist2[@]} ${topo2[@]:$start:2}
		done
		for((start=0;start<"${#topo3[@]};start+=3"));
		do
			mpirun -np 4 sum3Dmatrix.x ${dist2[@]} ${topo3[@]:$start:3}
		done	
	else
		mpirun -np 4 sum3Dmatrix.x ${dist3[@]} $topo1
		for((start=0;start<"${#topo2[@]};start+=2"));
		do
			mpirun -np 4 sum3Dmatrix.x ${dist3[@]} ${topo2[@]:$start:2}
		done
		for((start=0;start<"${#topo3[@]};start+=3"));
		do
			mpirun -np 4 sum3Dmatrix.x ${dist3[@]} ${topo3[@]:$start:3}
		done
	fi
done

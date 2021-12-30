#!/bin/bash

cd ~/OneDrive/github/HPC/section_3/outputs

rm -r tabular

for type in gpu thin
do 
	for i in socket node core
	do
		mkdir -p "tabular"
		
		if [ "$i" != "node" ]; then

		for j in 4 8 12 
			do
		echo "   MaxTime        MinTime     JacobiMin     JacobiMax      Residuals        MPUls   " > "tabular/${type}_${i}_${j}".txt
		cat ${type}_${i}_${j}.txt | grep Maxtime | sed 's/  4  Maxtime , Mintime + JacobiMi , JacobiMa   //' | awk '{$5=$7=""; print $0}' >> "tabular/${type}_${i}_${j}".txt
		echo "${type}_${i}_${j}"
			done
		else
			for k in 12 24 48
			do
				echo "   MaxTime        MinTime     JacobiMin     JacobiMax      Residuals        MPUls   " > tabular/"${type}_${i}_${k}".txt
				cat ${type}_${i}_${k}.txt | grep Maxtime | sed 's/  4  Maxtime , Mintime + JacobiMi , JacobiMa   //' | awk '{$5=$7=""; print $0}' >> "tabular/${type}_${i}_${k}".txt
		echo "${type}_${i}_${k}"
			done
		fi
	done
done
echo "   MaxTime        MinTime     JacobiMin     JacobiMax      Residuals        MPUls   " > "tabular/gpu_single_core".txt
cat gpu_single_core.txt | grep Maxtime | sed 's/  4  Maxtime , Mintime + JacobiMi , JacobiMa   //' | awk '{$5=$7=""; print $0}' >> "tabular/gpu_single_core".txt

echo "   MaxTime        MinTime     JacobiMin     JacobiMax      Residuals        MPUls   " > "tabular/thin_single_core".txt
cat thin_single_core.txt | grep Maxtime | sed 's/  4  Maxtime , Mintime + JacobiMi , JacobiMa   //' | awk '{$5=$7=""; print $0}' >> "tabular/thin_single_core".txt

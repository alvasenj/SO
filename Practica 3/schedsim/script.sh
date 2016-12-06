#!/bin/bash

	read -p "Seleccione ruta de fichero que desea simular: " RUTAFICHERO
	
	while [ ! -f $RUTAFICHERO ] ; do
	echo "Fichero no valido"
	read -p "Seleccione ruta de fichero que desea simular: " RUTAFICHERO
	done
	
	echo "Fichero valido"
	
	read -p "Numero maximo de CPU: " CPU
	while [  $CPU -le 0 ] ; do
		echo "Numero de CPU no valido"
		read -p "Numero maximo de CPU: " CPU
	done
	
	echo "Numero de cpu valido"

	rm -r -f resultados
	mkdir resultados
	

	array=("RR" "SJF" "FCFS" "PRIO")
	for i in "${array[@]}"
	do
		for (( cpus=1; cpus <= CPU; cpus++ ))
		do
		   ./schedsim -s $i -i $RUTAFICHERO -n $cpus
			for (( j=0; j < $cpus; j++ ))
			do
				mv CPU_$j.log ./resultados/$i-CPU-$j.log		
				cd gantt-gplot/
				./generate_gantt_chart ../resultados/$i-CPU-$j.log
				cd ../

			done	
			
		done
	done









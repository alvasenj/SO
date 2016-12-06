#! /bin/bash

MPOINT="./mount-point"
	
	echo -e "\n-----> Crea el directorio copiasTemporales\n" 	
	mkdir temp

	echo -e "\n-----> Copia los fichero fuseLib.c y myFS.h en copiasTemporales y punto-montaje\n" 
	cp ./src/fuseLib.c $MPOINT/fuseLibc.txt
	cp ./src/fuseLib.c ./temp/fuseLibc.txt
	cp ./src/myFS.h $MPOINT/myFSh.txt
	cp ./src/myFS.h ./temp/myFSh.txt
	

	echo -e "\n-----> Audita el disco\n" 
	if !./my-fsck virtual-disk ; then
		echo "error de consistencia"
	fi

	echo -e "\n-----> Diferencias entre los originales y los copiados en punto-montaje\n" 
	diff ./src/fuseLib.c $MPOINT/fuseLibc.txt
	diff ./src/myFS.h $MPOINT/myFSh.txt

	echo -e "\n-----> Trunca el primer fichero de copiasTemporales y punto-montaje\n" 
	truncate -s 15906 ./temp/fuseLibc.txt
	truncate -s 15906 $MPOINT/fuseLibc.txt

	echo -e "\n-----> Audita el disco\n" 
	./my-fsck virtual-disk

	echo -e "\n-----> Diferencias entre el original y el truncado en punto-montaje\n" 
	diff ./temp/fuseLibc.txt  $MPOINT/fuseLibc.txt

	echo -e "\n-----> Copia el fichero myFS.c en punto-montaje\n" 
	cp ./src/myFS.c  $MPOINT/myFSc.txt

	echo -e "\n-----> Audita el disco\n" 
	./my-fsck virtual-disk
	
	echo -e "\n-----> Diferencias entre el original y el copiado en punto-montaje\n" 
	diff ./src/myFS.c $MPOINT/myFSc.txt
	
	echo -e "\n-----> Trunca segundo fichero de copiasTemporales y punto-montaje\n" 
	truncate -s 8001 ./temp/myFSh.txt
	truncate -s 8001 $MPOINT/myFSh.txt

	echo -e "\n-----> Audita el disco\n" 
	./my-fsck virtual-disk
	
	echo -e "\n-----> Diferencias entre el original y el truncado en punto-montaje\n" 
	diff $MPOINT/myFSh.txt ./temp/myFSh.txt

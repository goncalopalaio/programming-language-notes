#!/bin/bash

N=1000000

TIMEFORMAT=%3R

time_file="generated_methods_time.txt"

for i in $(seq 1 1000 $N)
do
	sh generate_methods.sh $i

	rm hello.jar

	echo "" >> $time_file
	echo "N="$i >> $time_file
	{ time kotlinc generated_methods.kt -include-runtime -d hello.jar; } 2>> $time_file
	

done


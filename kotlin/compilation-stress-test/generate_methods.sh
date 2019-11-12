#!/bin/bash

N=$1

# rm *.class || true
# rm *.jar || true
# rm -rf META-INF || true

echo "N="$N

file=generated_methods.kt
rm $file || true

for i in $(seq 1 $N)
do
   echo 'fun a'$i'(){}' >> $file
   echo '' >> $file
done


echo "fun main() {" >> $file
	echo '	a1()' >> $file
echo "}" >> $file
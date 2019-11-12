#!/bin/bash

N=$1

# rm *.class || true
# rm *.jar || true
# rm -rf META-INF || true

file=generated_hello.kt
rm $file || true

echo "Writing to file."
echo "N="$N

echo "fun main() {" >> $file

for i in $(seq 1 $N)
do
   echo '	println("Hello")' >> $file
done

echo "}" >> $file



echo "Finished"
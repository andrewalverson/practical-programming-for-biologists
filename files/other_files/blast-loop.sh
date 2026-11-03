#!/bin/bash

mkdir output

# here is my loop
for i in *.fasta
do
  echo blastn -query $i -db watermelon.fsa '>' output/${i%.fasta}.blastn 
done

#!/bin/bash
#PBS -k oe
#PBS -m abe
#PBS -M USER@hawaii.edu
#PBS -N runRAxML
#PBS -l nodes=2:ppn=16,vmem=200gb,walltime=10:00:00

wd=/WORKDIR
out=OUTPUT_NAME

module load raxml
module unload python
module load python/3.6.1
# Step 4) Run raxml
raxmlHPC-PTHREADS -T 8 -f a -m PROTGAMMAJTT -N 100 -n $out -s $wd/supermatrix.aln.faa -p 13432 -x 89090

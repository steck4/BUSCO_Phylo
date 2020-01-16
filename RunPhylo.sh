#PBS -k oe
#PBS -m abe
#PBS -M 
#PBS -N RunPhylo
#PBS -l nodes=1:ppn=1,vmem=200gb,walltime=00:24:00:00

home=PDWHERE

cd $home

unload python
module load python3
module load raxml
module load mafft
module load trimAl
module load newick-utils
module load busco

export "wd=$home"
bash run.sh

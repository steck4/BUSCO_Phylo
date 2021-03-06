#PBS -k oe
#PBS -m abe
#PBS -M 
#PBS -N RunBUSCO
#PBS -l nodes=1:ppn=1,vmem=100gb,walltime=00:12:00:00

#This is IN PROGRESS an attempt to generate BUSCO sets for multiple assemblies for phylogenomic analyses

home=PDWHERE

cd $home

#1) Make script to run BUSCO on all - Needs TESTING
module unload python
module load python/3.6.1
module load busco/3.0.2

for f in *.fasta
  do 
    run_BUSCO.py -i $f -o ${f}_busco -l /N/soft/rhel7/busco/3.0.2/busco-lineage/eukaryota_odb9 -m tran
  done

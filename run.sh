# Produce a phylogeny based on provided BUSCO protein and transcriptome runs.
# USE THE SAME DATASET FOR EACH OF THEM
#
# This script is designed to run with the following tools:
# - raxml 8
# - mafft 7
# - trimAl 1.4
# - newick-utils 1.6
# - BUSCO 3.0.2
#
module unload python
module load python/3.6.1
module load busco
#
# !!! You need to have run BUSCO on each species before running this script
#
wd=/WORKDIR #your working directory
cd $wd
mkdir extracted
# Step 1) Extract BUSCO genes, produce one multispecies-fasta per BUSCO family
# !!! You need to edit the script "extract_buscos_phylo.py" to provide information about each species folder
echo "extracting BUSCO genes..."
python3 /$wd/BUSCO_Phylo/extract_buscos_phylo.py
# Step 2) Run mafft and trimAl on each BUSCO family
echo "starting mafft trimAl"
for b in $(ls $wd/extracted/*.faa)
do
echo $b
mafft --thread -8 --auto $b > $b.aln
trimal -in $b.aln -out $b.aln.trimmed -automated1
done
# Step 3) Produce the supermatrix
python3 /$wd/BUSCO_Phylo/superalignment.py $wd/extracted/
mv $wd/extracted/supermatrix.aln.faa .
# Step 4) Run raxml
#raxmlHPC-PTHREADS-SSE3 -T 8 -f a -m PROTGAMMAJTT -N 100 -n my_busco_phylo -s $wd/supermatrix.aln.faa -p 13432 -x 89090
qsub $wd/BUSCO_Phylo/runRAxML.sh
# Step 5) Root the tree
# !!! > You need to replace OUTGRP by the name of your outgroup
#nw_reroot RAxML_bestTree.my_busco_phylo OUTGRP > final.nwk

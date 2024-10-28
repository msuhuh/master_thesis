#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 5:00:00
#SBATCH -J misa1224_K-mer_analysis
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load bioinfo-tools
module load jellyfish

# SET VARIABLES
infile="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/03_K-mer_analysis/prep_seqs_K-mer_analysis.fa"
outpath="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/03_K-mer_analysis"


# RUN ANALYSIS
for kmer in 5 6 7 8 9 10 11 12 13; do
    outname="${outpath}/${kmer}_mer"
    
    jellyfish count -m $kmer -s 100M -t 2 -C "$infile" -o "${outname}_counts.jf"
    
    jellyfish dump -c "${outname}_counts.jf" > "${outname}_dumps.fa"

    jellyfish histo -t 2 -h 50000 "${outname}_counts.jf" > "${outname}_histo.txt"
done

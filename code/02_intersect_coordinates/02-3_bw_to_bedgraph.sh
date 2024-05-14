#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10-00:00:00
#SBATCH -J misa1224_bw2bedgrapg
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load bioinfo-tools
module load ucsc-utilities


# SET VARIABLES
bw_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/Zoonomia_alignment/hg38.phyloP447way.bw"
bedgraph_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/Zoonomia_alignment/hg38.phyloP447way.bedGraph"


# RUN SCRIPT
bigWigToBedGraph "$bw_file" "$bedgraph_file"

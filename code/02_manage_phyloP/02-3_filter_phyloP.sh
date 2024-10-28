#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 3-00:00:00
#SBATCH -J misa1224_filtering
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# SET VARIABLES
bedgraph_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/zoonomia_data/phyloP/hg38.phyloP447way.bedGraph"
filtered_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/zoonomia_data/phyloP/hg38.phyloP447way.above_2.bed"


# RUN SCRIPT
awk '$4 > 2' "$bedgraph_file" > "$filtered_file"


#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10-00:00:00
#SBATCH -J misa1224_maf2bed
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load bioinfo-tools
module load ucsc-utilities


# SET VARIABLES
maf_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/Zoonomia_alignment/8-t2t-apes-2023v2.maf"
bed_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/Zoonomia_alignment/8-t2t-apes-2023v2.bed"


# CONVERT ALIGNMENT FILE TO BED-FORMAT
maf2bed < "$maf_file" > "$bed_file"  

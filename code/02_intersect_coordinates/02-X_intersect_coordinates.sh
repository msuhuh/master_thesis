#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J misa1224_intersect_coordinates
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load bioinfo-tools
module load BEDTools


# SET VARIABLES
maf_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/Zoonomia_alignment/8-t2t-apes-2023v2.maf"
coordinates_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/01_LTR_coordinates/hg38_LTR_coordinates.bed"
out_bed_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/intersected_regions.bed"


# INTERSECT COORDINATES WITH ALIGNMENT
bedtools intersect -a "$coordinates_file" -b "$maf_file" -wo > "$out_bed_file"




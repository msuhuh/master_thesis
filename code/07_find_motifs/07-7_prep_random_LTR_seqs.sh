#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 5:00:00
#SBATCH -J misa1224_prep_random_ltr_seq
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load bioinfo-tools
module load R_packages
module load samtools
module load BEDTools


# SET VARIABLES
size="+250"
conversion_script="/proj/snic2020-16-24/private/users/minna/master_thesis/code/07_find_motifs/07-6_convert_GR_2_bed.R"
LTR_vs_phyloP_GR="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38.p12_LTR_vs_phyloP.RData"
LTR_vs_phyloP_bed="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/03_K-mer_analysis/hg38.p12_LTR_vs_phyloP.bed"
outpath="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/03_K-mer_analysis" 
real_bed="${outpath}/real_regions_${size}.bed" 
chr_sizes="${outpath}/GRCh38.p12_chr_sizes"
assembly="/proj/snic2020-16-24/private/users/minna/master_thesis/data/zoonomia_data/assembly/GCF_000001405.38_GRCh38.p12_genomic.fna"
random_bed="${outpath}/random_LTR_regions_${size}.bed"
random_fasta="${outpath}/random_LTR_regions_${size}.fa"
lengths_file="${outpath}/real_region_lengths_${size}.bed"
resized_LTR_vs_phylop_bed="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/03_K-mer_analysis/resized_hg38_LTR_vs_phyloP.bed"


# CONVERT LTR_vs_PHYLOP GR-OBJECT TO BED
Rscript $conversion_script $LTR_vs_phyloP_GR $LTR_vs_phyloP_bed


# RESIZE LTR REGIONS TO MATCH REAL REGIONS
paste <(cut -f1,2 $LTR_vs_phylop_bed) <(awk '{print $1}' $lengths_file) | awk '{OFS="\t"; print $1, $2, $2 + $3}' > ${resized_LTR_vs_phylop_bed}


# CREATE RANDOM REGIONS FILE IN BED FORMAT FROM LTR_vs_phyloP
bedtools shuffle -i $resized_LTR_vs_phylop_bed -g $chr_sizes -excl $real_bed -noOverlapping > $random_bed


# CONVERT RANDOM REGIONS IN BED FORMAT TO FASTA
bedtools getfasta -fi $assembly -bed $random_bed -fo $random_fasta



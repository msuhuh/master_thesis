# IMPORT MODULES
module load bioinfo-tools
module load samtools
module load BEDTools


# SET VARIABLES
real_fasta="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/03_K-mer_analysis/prep_seqs_K-mer_analysis_+50.fa" 
assembly="/proj/snic2020-16-24/private/users/minna/master_thesis/data/zoonomia_data/assembly/GCF_000001405.38_GRCh38.p12_genomic.fna"
outpath="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/03_K-mer_analysis"
real_bed="${outpath}/real_regions_+50.bed"
chipseq_bed="/proj/snic2020-16-24/private/users/minna/master_thesis/data/ChIP_seq_data/brattas/GSM2230418_NS_Trim28.peaks.bed"
resized_chipseq_bed="/proj/snic2020-16-24/private/users/minna/master_thesis/data/ChIP_seq_data/brattas/GSM2230418_NS_Trim28.peaks.resize.bed"
assembly_indx="${outpath}/GCF_000001405.38_GRCh38.p12_genomic.fna.fai"
chr_sizes="${outpath}/GRCh38.p12_chr_sizes"
random_bed="${outpath}/random_chipseq_regions_+50.bed"
random_fasta="${outpath}/random_chipseq_regions_+50.fa"
lengths_file="${outpath}/real_region_lengths.bed"



# CREATE BED FILE OF REAL REGION
grep ">" $real_fasta | sed 's/>//g' | awk -F'[_:-]' '{print $2"\t"$4"\t"$5}' > $real_bed


# EXTRACT LENGTHS OF REAL REGIONS
awk '{print $3-$2+1}' $real_bed > $lengths_file


# CREATE INDEX FILE OF ASSEMBLY
samtools faidx $assembly --output $assembly_indx


# CREATE CHROMOSOME SIZE FILE FROM INDEX FILE
cut -f1,2 $assembly_indx > $chr_sizes


# RESIZE PEAK REGIONS TO MATCH REAL REGIONS
paste <(cut -f1,2 $chipseq_bed) <(awk '{print $2+$3}' $chipseq_bed | cut -f3) | \
    awk 'NR==FNR{len[NR]=$1;next} {OFS="\t"; print $1, $2, $2+len[FNR]}' $lengths_file $chipseq_bed > ${resized_chipseq_bed}

# CREATE RANDOM REGIONS FILE IN BED FORMAT FROM CHIP-SEQ PEAKS
bedtools shuffle -i $resized_chipseq_bed -g $chr_sizes -excl $real_bed -noOverlapping > $random_bed


# CONVERT RANDOM REGIONS IN BED FORMAT TO FASTA
bedtools getfasta -fi $assembly -bed $random_bed -fo $random_fasta


############## LOAD PACKAGES & LIBRARIES #################
library(GenomicRanges)


############## GET COMMAND-LINE ARGUMENTS #################
args <- commandArgs(trailingOnly = TRUE)
LTR_cons_file <- args[1]
TRIM28_cons_file <- args[2]
out_file <- args[3]


################ LOAD GRANGES OBJECTS ######################
load(file = LTR_cons_file)
head(hg38_LTR_GR)

load(file = TRIM28_cons_file)
head(hg38_TRIM28_GR)


############## FILTER & KEEP COMMON SEQNAMES BETWEEN GRANGES OBJECTS ##################
common_seqnames <- intersect(seqlevels(hg38_TRIM28_GR), seqlevels(hg38_LTR_GR))

hg38_TRIM28_GR <- keepSeqlevels(hg38_TRIM28_GR, common_seqnames, pruning.mode = "coarse")
hg38_LTR_GR <- keepSeqlevels(hg38_LTR_GR, common_seqnames, pruning.mode = "coarse")


############## FIND INTERSECTION ###################
hg38_LTR_vs_TRIM28 <- findOverlaps(hg38_LTR_GR, hg38_TRIM28_GR) 

hg38_LTR_GR[hg38_LTR_vs_TRIM28@from[1]] 
hg38_TRIM28_GR[hg38_LTR_vs_TRIM28@to[1]]


############# EXTRACT INTERSECTED REGIONS & THEIR PHYLOP ###############
overlaps_LTR <- hg38_LTR_GR[queryHits(hg38_LTR_vs_TRIM28)]
overlaps_TRIM28 <- hg38_TRIM28_GR[subjectHits(hg38_LTR_vs_TRIM28)] 

phyloP_LTR <-mcols(overlaps_LTR)$max_cons
phyloP_TRIM28 <- mcols(overlaps_TRIM28)$max_cons


############# GET MAX PHYLOP FOR REGIONS ##############
max_phyloP <- pmax(phyloP_LTR, phyloP_TRIM28)


############## UPDATE INTERSECTION WITH MAX PHYLOP
hg38_LTR_vs_TRIM28 <- overlaps_TRIM28 
mcols(hg38_LTR_vs_TRIM28)$max_cons <- max_phyloP 

hg38_LTR_vs_TRIM28


############## REMOVE DUPLICATE REGIONS ###############
hg38_LTR_vs_TRIM28 <- unique(hg38_LTR_vs_TRIM28)


################ SAVE FILE ###################
save(hg38_LTR_vs_TRIM28, file = out_file)

# sum(!is.na(hg38_LTR_vs_TRIM28$max_cons))
# hist(new_hg38_LTR_vs_TRIM28$max_cons)

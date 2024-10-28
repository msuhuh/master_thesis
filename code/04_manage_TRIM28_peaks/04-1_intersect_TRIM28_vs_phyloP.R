############## LOAD PACKAGES & LIBRARIES #################
library(GenomicRanges)


############## GET COMMAND-LINE ARGUMENTS #################
args <- commandArgs(trailingOnly = TRUE)
TRIM28_file <- args[1]
phyloP_file <- args[2]
out_file <- args[3]
hist_file <- args[4]

############## MANAGE FILES #################
hg38_TRIM28 <- read.table(TRIM28_file, sep = "\t", stringsAsFactors = F) 
hg38_phyloP <- read.table(phyloP_file, sep = "\t", stringsAsFactors = F)


############## CONVERT FILES TO GR MANAGEABLE OBJECTS ###################
hg38_TRIM28_GR <- GRanges(seqnames = hg38_TRIM28$V1, ranges = IRanges(start = hg38_TRIM28$V2, end = hg38_TRIM28$V3)) 
hg38_phyloP_GR <- GRanges(seqnames = hg38_phyloP$V1, ranges = IRanges(start = hg38_phyloP$V2, end = hg38_phyloP$V3), cons = hg38_phyloP$V4)


############## FIND INTERSECTION ###################
hg38_TRIM28_vs_phyloP <- findOverlaps(hg38_TRIM28_GR, hg38_phyloP_GR) 
hg38_TRIM28_GR[hg38_TRIM28_vs_phyloP@from[1]] 
hg38_phyloP_GR[hg38_TRIM28_vs_phyloP@to[1]]

tmp_cons_df = data.frame( TRIM28_idx = hg38_TRIM28_vs_phyloP@from, cons = hg38_phyloP_GR$cons[hg38_TRIM28_vs_phyloP@to]) 
cons_agg <- aggregate(cons~TRIM28_idx, data = tmp_cons_df, FUN = "max")
hg38_TRIM28_GR$max_cons <- NA 
hg38_TRIM28_GR$max_cons[cons_agg$TRIM28_idx] <- cons_agg$cons 


################ SAVE FILE ###################
save(hg38_TRIM28_GR, file = out_file)
pdf(file = hist_file)
hist(hg38_phyloP_GR$cons)
dev.off()

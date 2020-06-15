
library(AnnotationHub)

# Use the AnnotationHub package to obtain data on "CpG Islands" in the human genome.

ahub <- AnnotationHub()
ahub <- subset(ahub, species=="Homo sapiens")

# Q1 How many islands exists on the autosomes?
qhs <- query(ahub, c("CpG Islands"))
qhs$genome
genes <- qhs[[1]]
autosome <- paste("chr", 1:22, sep="")
genes_autosome <- genes[seqnames(genes) %in% autosome]

# Q2 How many CpG Islands exists on chromosome 4.
genes_autosome[seqnames(genes_autosome) == "chr4"]


# Obtain the data for the H3K4me3 histone modification for the H1 cell line 
# from Epigenomics Roadmap, using AnnotationHub. Subset these regions to 
# only keep regions mapped to the autosomes (chromosomes 1 to 22).

# Q3 How many bases does these regions cover?
qhs <- query(ahub, c("H3K4me3", "E003"))
genes1 <- qhs[["AH29884"]]
genes1_autosome <- genes1[seqnames(genes1) %in% autosome]
sum(width(genes1_autosome))


# Obtain the data for the H3K27me3 histone modification for the H1 cell line 
# from Epigenomics Roadmap, using the AnnotationHub package. Subset these 
# regions to only keep regions mapped to the autosomes. In the return data, 
# each region has an associated "signalValue".

# Q4 What is the mean signalValue across all regions on the standard chromosomes?
qhs <- query(ahub, c("H3K27me3", "E003"))
genes2 <- qhs[["AH29892"]]
genes2_autosome <- genes2[seqnames(genes2) %in% autosome]
mean(genes2_autosome$signalValue)


# Bivalent regions are bound by both H3K4me3 and H3K27me3.

# Q5 Using the regions we have obtained above, how many bases on the standard 
#    chromosomes are bivalently marked?
bivalen <- intersect(genes1_autosome, genes2_autosome)
sum(width(bivalen))


# We will examine the extent to which bivalent regions overlap CpG Islands.

# Q6 How big a fraction (expressed as a number between 0 and 1) of the bivalent 
#    regions, overlap one or more CpG Islands?
CpG_bivalen <- findOverlaps(bivalen, genes_autosome)
length(unique(queryHits(CpG_bivalen)))/length(bivalen)

# Q7 How big a fraction (expressed as a number between 0 and 1) of the bases 
#    which are part of CpG Islands, are also bivalent marked
CpG_bivalen1 <- intersect(bivalen, genes_autosome)
sum(width(CpG_bivalen1))/sum(width(genes_autosome))

# Q8 How many bases are bivalently marked within 10kb of CpG Islands?
CpG_10k <- resize(genes_autosome, 
                  width = 20000 + width(genes_autosome), 
                  fix = "center")
CpG_10k_bivalen <- intersect(CpG_10k, bivalen)
sum(width(CpG_10k_bivalen))

# Q9 How big a fraction (expressed as a number between 0 and 1) of the human 
#    genome is contained in a CpG Island?
qhs <- query(ahub, c("hg19"))
genes_hg19 <- qhs[[1]]
seqlen_hg19 <- seqlengths(genes_hg19)
sum(width(genes_autosome))/sum(seqlen_hg19[names(seqlen_hg19) %in% autosome])

# Q10 Compute an odds-ratio for the overlap of bivalent marks with CpG islands.
inout <- matrix(0, ncol=2, nrow=2)
colnames(inout) <- c("in", "out")
rownames(inout) <- c("in", "out")
inout
inout[1,1] <- sum(width(intersect(bivalen, genes_autosome, ignore.strand=TRUE)))
inout[1,2] <- sum(width(setdiff(bivalen, genes_autosome, ignore.strand=TRUE)))
inout[2,1] <- sum(width(setdiff(genes_autosome, bivalen, ignore.strand=TRUE)))
inout[2,2] <- sum(seqlen_hg19[names(seqlen_hg19) %in% autosome]) - sum(inout)
inout
odd_ratio <- inout[1,1]*inout[2,2]/(inout[1,2]*inout[2,1])
odd_ratio

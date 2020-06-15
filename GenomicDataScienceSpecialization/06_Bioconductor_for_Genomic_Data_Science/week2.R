
library(AnnotationHub)
library(Biostrings)
library(BSgenome.Hsapiens.UCSC.hg19)

# Q1
letterFrequency(Hsapiens$chr22, "GC")/(sum(alphabetFrequency(Hsapiens$chr22))-letterFrequency(Hsapiens$chr22, "N"))

# Q2
ahub <- AnnotationHub()
ahub <- subset(ahub, species=="Homo sapiens")
qhs <- query(ahub, c("H3K27me3", "E003", "narrowPeak"))
genes <- qhs[["AH29892"]]
genes_chr22 <- subset(genes, seqnames == "chr22")
genes_chr22_seq <- Views(Hsapiens, genes_chr22)
gc <- letterFrequency(genes_chr22_seq, "GC", as.prob = T)
mean(gc)

# Q3
sigVal <- mcols(genes_chr22_seq)$signalValue
cor(sigVal, gc)

# Q4
qhs <- query(ahub, c("H3K27me3", "E003", "fc.signal"))
genes1 <- qhs[["AH32033"]]
gr_chr22 <- GRanges(seqnames = "chr22", 
                    ranges = IRanges(start=1, end=seqlengths(genes1)["chr22"]))
out_chr22 <- import(genes1, which = gr_chr22, as = "Rle")[["chr22"]]
out_chr22_seq <- Views(out_chr22, 
                       start = start(genes_chr22_seq), 
                       end = end(genes_chr22_seq))
cor(mean(out_chr22_seq), sigVal)

# Q5
sum(out_chr22 >= 1)

# Q6
qhs <- query(ahub, c("H3K27me3", "E055", "fc.signal"))
genes2 <- qhs[["AH32470"]]
out_chr22_E055 <- import(genes2, which =gr_chr22, as = "Rle")[["chr22"]]
region_E003 <- slice(out_chr22, upper = 0.5)
region_E055 <- slice(out_chr22_E055, lower = 2)
region_E003 <- as(region_E003, "IRanges")
region_E055 <- as(region_E055, "IRanges")
inter_region <- intersect(region_E003, region_E055)
sum(width(inter_region))

# Q7
qhs <- query(ahub, c("hg19", "CpG Islands"))
cpg <- qhs[["AH5086"]]
cpg_chr22 <- subset(cpg, seqnames == "chr22")
cpg_chr22_seq <- Views(Hsapiens, cpg_chr22)
region_length <- width(cpg_chr22_seq)
observed_gcBase <- dinucleotideFrequency(cpg_chr22_seq)[,7]/region_length
freq_C <- letterFrequency(cpg_chr22_seq, "C")
freq_G <- letterFrequency(cpg_chr22_seq, "G")
expected_gcBase <- (freq_C/region_length)*(freq_G/region_length)
mean(observed_gcBase/expected_gcBase)

# Q8
countPattern("TATAAA", Hsapiens$chr22) +
    countPattern("TATAAA", reverseComplement(Hsapiens$chr22))

# Q9 (Wrong answer)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
gr <- GRanges(seqnames = "chr22", 
              ranges = IRanges(start = 1, end = seqlengths(txdb)["chr22"]))
gr_trans_chr22 <- subsetByOverlaps(transcripts(txdb), gr, 
                                   ignore.strand = TRUE)
proms <- promoters(gr_trans_chr22, upstream = 100, downstream = 900)
cdseq <- subsetByOverlaps(genes(txdb), gr, 
                          ignore.strand = TRUE)
proms_cds <- findOverlaps(proms, cdseq)
proms_cds_view <- Views(Hsapiens, proms[unique(queryHits(proms_cds))])
sum(vcountPattern("TATAAA", DNAStringSet(proms_cds_view)))

# Q10 (Wrong answer)
tl_chr22 <- transcriptLengths(txdb, with.cds_len = TRUE) #rtn df
tl_chr22  <- tl_chr22[tl_chr22$cds_len > 0,]
trans_eval <- proms[mcols(proms)$tx_id %in% tl_chr22$tx_id]
sum(coverage(trans_eval) > 1)["chr22"]

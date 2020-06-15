
# Q1
library(ALL)
data(ALL)
sample5 <- ALL[, 5]
mean(exprs(sample5))

# Q2
library(biomaRt)
library(dplyr)
mart <- useMart(host = 'feb2014.archive.ensembl.org', 
                biomart = "ENSEMBL_MART_ENSEMBL")
ensembl <- useDataset("hsapiens_gene_ensembl", mart)
names <- featureNames(ALL)
attrs <- listAttributes(ensembl, page = "feature_page")
result <- getBM(attributes = c("affy_hg_u95av2", "ensembl_gene_id", "chromosome_name"),
                filters = "affy_hg_u95av2", values = names, mart = ensembl)
prob_set <- result %>% group_by (affy_hg_u95av2) %>% summarise(prob_count = n())
sum(prob_set$prob_count > 1)

# Q3 (wrong answer)
result_autosome <- subset(result, chromosome_name <= 22)
sum(table(result_autosome$affy_hg_u95av2) > 0)

# Q4
library(minfiData)
data(MsetEx)
sample_2 <- MsetEx[, 2]
mean(getMeth(sample_2))

# Q5
library(GEOquery)
query <- getGEO("GSE788")
data <- query[[1]]
GSM9024 <- data[, 2]
mean(exprs(GSM9024))

# Q6
library(airway)
data(airway)
mean(airway$avgLength)

# Q7
SRR1039512 <- airway[, 3]
counts <- assay(SRR1039512, "counts")
sum(counts >= 1)

# Q8
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
exons <- exons(txdb)
autosome <- paste("chr", 1:22, sep="")
seqlevels(exons, pruning.mode="coarse") <- autosome
ncbiStyleLevels <- mapSeqlevels(seqlevels(exons), "NCBI")
exons <- renameSeqlevels(exons, ncbiStyleLevels)
subset <- subsetByOverlaps(airway, exons)
subset

# Q9
SRR1039508 <- airway[, 1]
subset_SRR1039508 <- subsetByOverlaps(SRR1039508, exons)
counts <- assay(SRR1039508, "counts")
subset_counts <- assay(subset_SRR1039508, "counts")
sum(subset_counts)/sum(counts)

# Q10 (wrong answer)
library(AnnotationHub)
ahub <- AnnotationHub()
qhs <- query(ahub, c("E096", "H3K4me3"))
h1 <- qhs[["AH30596"]]
seqlevels(h1, pruning.mode="coarse") <- autosome
h1 <- renameSeqlevels(h1, ncbiStyleLevels)
t <- range(rowRanges(subset_SRR1039508))
ncbiByGroup <- extractSeqlevelsByGroup(species = "Homo sapiens", style = "NCBI", 
                                       group = "auto")
t <- keepSeqlevels(t, ncbiByGroup)
p <- promoters(t)
ov <- subsetByOverlaps(p, h1)
t2 <- subsetByOverlaps(SRR1039508, ov)
counts <- assay(t2, "counts")
median(counts)
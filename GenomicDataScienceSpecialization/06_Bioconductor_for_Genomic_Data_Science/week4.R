
# Q1
library(yeastRNASeq)
library(ShortRead)
fastqFilePath <- system.file("reads", "wt_1_f.fastq.gz", package = "yeastRNASeq")
reads <- readFastq(fastqFilePath)
reads_set <- sread(reads)
sum(DNAStringSet(reads_set, 5, 5) == "A") / length(reads_set)

# Q2
qm <- as(quality(reads), "matrix")
mean(qm[, 5:5])

# Q3
library(leeBamViews)
bamFilePath <- system.file("bam", "isowt5_13e.bam", package="leeBamViews")
bamFile <- BamFile(bamFilePath)
gr <- GRanges(seqnames = "Scchr13", ranges = IRanges(start = 800000, end = 801000))
params <- ScanBamParam(which = gr, what = scanBamWhat())
aln <- scanBam(bamFile, param = params)
aln <- aln[[1]]  
duplicatedValues = unique(aln$pos[duplicated(aln$pos)])
sum(aln$pos %in% duplicatedValues)

# Q4
library(GenomicRanges)
bpaths <- list.files(system.file("bam", package = "leeBamViews"), pattern = "bam$", 
                     full=TRUE)
gr <- GRanges(seqnames = "Scchr13", ranges = IRanges(start = 807762, end = 808068))
bamView <- BamViews(bpaths)
bamRanges(bamView) <- gr
aln <- scanBam(bamView)
lens <- sapply(aln, function(x) length(x[[1]]$seq))
mean(unlist(lens))

# Q5
library(oligo)
library(GEOquery)
geoMat <- getGEO("GSE38792")
pD.all <- pData(geoMat[[1]])
getGEOSuppFiles("GSE38792")
untar("GSE38792/GSE38792_RAW.tar", exdir = "GSE38792/CEL")
celfiles <- list.files("GSE38792/CEL", full = TRUE)
rawData <- read.celfiles(celfiles)
filename <- sampleNames(rawData)
pData(rawData)$filename <- filename
sampleNames <- gsub(".*_", "", filename)
sampleNames <- gsub(".CEL.gz$", "", sampleNames)
sampleNames(rawData) <- sampleNames
pData(rawData)$group <- ifelse(grepl("^OSA", sampleNames(rawData)), "OSA", "Control")
normData <- rma(rawData)
expr <- exprs(normData)
mean(expr["8149273", 1:8])

# Q6
library(limma)
design <- model.matrix(~ normData$group)
fit <- lmFit(normData, design)
fit <- eBayes(fit)
abs(topTable(fit, n = 1)$logFC)

# Q7
topTable(fit, p.value = 0.05)

# Q8 (wrong answer)
library(minfiData)
data(RGsetEx)
p <- preprocessFunnorm(RGsetEx)
b <- getBeta(p)
b_os <- b[getIslandStatus(p) == "OpenSea", ]
mean(b_os[, c(1, 2, 5)]) - mean(b_os[, c(3, 4, 6)])

# Q9
library(AnnotationHub)
ahub <- AnnotationHub()
qhs <- subset(ahub, species=="Homo sapiens")
genes <- query(qhs, c("Caco2", "Awg", "DNase"))
genes <- genes[["AH22442"]]
sum(countOverlaps(genes, p))
#67365(x)/90561(x)/76722/29265/40151
source("https://bioconductor.org/biocLite.R")
biocLite("IlluminaHumanMethylation450kanno.ilmn12.hg19")
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)
CpG<-IlluminaHumanMethylation450kanno.ilmn12.hg19

class(CpG)
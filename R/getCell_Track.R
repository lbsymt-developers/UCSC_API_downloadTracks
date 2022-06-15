getCell_Track <- function(celltType="ASC", start = 44883309, end = 44931881,
                          chr = "chr19",
                          perCondition=FALSE,
                          strand = "-"){
  # library(TxDb.Hsapiens.UCSC.hg38.knownGene)
  # library(org.Hs.eg.db)
  # library(Gviz)
  library(rtracklayer)
  library(trackViewer)

  gr_1 <- GRanges(chr,
                  IRanges(start = start, end = end),
                          strand = strand)

  file_cell <- paste0("data_AD_NatGen_2021/celltypes/", celltType, ".bw")
  Track_celltype <- importScore(file = file_cell,
                                ranges= gr_1, format = "BigWig")

  Track_celltype <- importScore(file = "data_AD_NatGen_2021/celltypes/EX.bw",
                                ranges= gr_1, format = "BigWig")


}

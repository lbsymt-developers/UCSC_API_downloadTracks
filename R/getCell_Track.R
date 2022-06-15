getCell_Track <- function(celltType="ASC", start = 44883309, end = 44931881,
                          chr = "chr19",
                          perCondition=FALSE,
                          strand = "-"){
  library(rtracklayer)
  library(trackViewer)
  if(perCondition==FALSE){
    gr_1 <- GRanges(chr,
                    IRanges(start = start, end = end),
                    strand = strand)

    file_cell <- paste0("data_AD_NatGen_2021/celltypes/", celltType, ".bw")
    Track_celltype <- importScore(file = file_cell,
                                  ranges= gr_1, format = "BigWig")
    Track_celltype$dat <- coverageGR(Track_celltype$dat)

    return(Track_celltype)
  } else {
    gr_1 <- GRanges(chr,
                    IRanges(start = start, end = end),
                    strand = strand)

    file_cell_AD <- paste0("data_AD_NatGen_2021/bigwigs/", celltType, "_AD.bw")
    file_cell_control <- paste0("data_AD_NatGen_2021/bigwigs/", celltType, "_Control.bw")

    Track_celltype_AD <- importScore(file = file_cell_AD,
                                  ranges= gr_1, format = "BigWig")
    Track_celltype_Control <- importScore(file = file_cell_control,
                                     ranges= gr_1, format = "BigWig")

    Track_celltype_AD$dat <- coverageGR(Track_celltype_AD$dat)
    Track_celltype_Control$dat <- coverageGR(Track_celltype_Control$dat)

    tracks <- list(AD = Track_celltype_AD,
                   Control = Track_celltype_Control)

    return(tracks)
    }
  }

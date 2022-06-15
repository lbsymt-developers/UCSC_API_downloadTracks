# https://hgdownload.soe.ucsc.edu/admin/exe/
# "rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/macOSX.x86_64/ ./"
# Se descargo el archivo Unix de bigBedToBed para ejecutar la funcion en el entorno

getSNPs_Region<- function(start = 44883309, end = 44931881,
                          chr = "chr19"){
  out <- paste0("SNPs_",chr,":",start,"-",end, ".csv")
  chrom <- paste0("-chrom=", chr)
  pos <- paste0("-start=", start, " ","-end=", end)

  system(paste('./bigBedToBed',
               "http://hgdownload.soe.ucsc.edu/gbdb/hg38/snp/dbSnp153.bb",
               chrom,
               pos,
               "stdout",
               ">",
               out))

  doc <- data.table::fread(out)
  doc <- doc[,1:4]
  colnames(doc) <- c("chr", "start", "end",
                     "rsid")
  return(doc)

}

prueba <- getSNPs_Region()

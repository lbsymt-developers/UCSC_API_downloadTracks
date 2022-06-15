a <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?hubUrl=https://swaruplab.bio.uci.edu/trackhubs/AD_chromatin_hub/AD_NatGen_2021.hub.txt;track=MG_AD;chrom=chr19")

b <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?genome=hg38;track=gold;chrom=chr1;start=47000;end=48000")

"AD_NatGen_2021"

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

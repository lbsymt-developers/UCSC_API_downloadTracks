a <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?hubUrl=https://swaruplab.bio.uci.edu/trackhubs/AD_chromatin_hub/AD_NatGen_2021.hub.txt;track=MG_AD;chrom=chr19")

b <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?genome=hg38;track=gold;chrom=chr1;start=47000;end=48000")

"AD_NatGen_2021"

# https://hgdownload.soe.ucsc.edu/admin/exe/
# "rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/macOSX.x86_64/ ./"
getSNPs_frombigbed <- function(start = 44883309, end = 44931881,
                               chr = "chr19"){
  out <- paste0("SNPs_",chr,":",start,"-",end, ".tsv")
  chrom <- paste0("-chrom=", chr)
  pos <- paste0("-start=", start, " ","-end=", end)

  system(paste('./bigBedToBed',
               "http://hgdownload.soe.ucsc.edu/gbdb/hg38/snp/dbSnp153.bb",
               chrom,
               pos,
               "stdout",
               ">",
               out))

}

bigbed2bed <- function(inputFile, compress = TRUE, keep.header = TRUE){

  # set output bedfile name path
  output_bed <- paste0(sub(pattern = "(.*)\\..*$", replacement = "\\1", inputFile),'.bed')

  # invoke cmd line tool bigbedtobed
  if (!file.exists(output_bed)) {
    system(paste('bigBedToBed', inputFile, output_bed, sep = '\t'))
    # insert header into the bed output file?
    # if(keep.header){
    #    fields <- getBigBedFieldNames(inputFile = inputFile)
    #      if(!is.null(fields)){
    #         names <- as.character(fields)
    #         # parsing header
    #           temp <- paste(names, collapse = ' ')
    #         # insert header in-place using GNU sed tool
    #         system(paste('sed', '-i', paste("'1 ", "i ", temp, "'", sep = ""), output_bed, sep = '\t'))
    #      }
    # must the output to be compressed
    if(compress){
      system(paste('bgzip', output_bed, '-f', sep = '\t'))
    }
  } else {
    message('The output bed file already exists...')
  }
}

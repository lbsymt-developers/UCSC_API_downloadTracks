a <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?hubUrl=https://swaruplab.bio.uci.edu/trackhubs/AD_chromatin_hub/AD_NatGen_2021.hub.txt;track=MG_AD;chrom=chr19")

b <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?genome=hg38;track=gold;chrom=chr1;start=47000;end=48000")

"AD_NatGen_2021"


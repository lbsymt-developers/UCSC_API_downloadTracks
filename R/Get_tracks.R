a <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?hubUrl=https://swaruplab.bio.uci.edu/trackhubs/AD_chromatin_hub/AD_NatGen_2021.hub.txt;track=MG_AD;chrom=chr19")

b <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?genome=hg38;track=gold;chrom=chr1;start=47000;end=48000")


a <- jsonlite::fromJSON("https://api.genome.ucsc.edu/list/publicHubs")

a <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?hubUrl=https://hgdownload.soe.ucsc.edu/hubs/primates/hub.txt;genome=human")


a <- jsonlite::fromJSON("https://api.genome.ucsc.edu/getData/track?genome=hg38;track=gold;chrom=chrM")

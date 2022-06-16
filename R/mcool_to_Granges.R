# http://www.bioconductor.org/packages/devel/bioc/vignettes/HiCBricks/inst/doc/IntroductionToHiCBricks.html#25_Exporting_data_from_Brick_objects
library(HiCBricks)
mcool_path <- "Astro_all_brain.txt_1kb_contacts.mcool"
Brick_mcool_normalisation_exists(mcool = mcool_path,
                                 norm_factor = "Iterative-Correction",
                                 resolution = 10000)
Brick_list_mcool_normalisations(names.only = TRUE)

out_dir <- file.path(tempdir(), "mcool_to_Brick_test")
dir.create(out_dir)

Create_many_Bricks_from_mcool(output_directory = out_dir,
                              file_prefix = "mcool_to_Brick_test",
                              mcool = mcool_path,
                              resolution = 10000,
                              experiment_name = "Testing mcool creation",
                              remove_existing = TRUE)

Create_many_Bricks_from_mcool(output_directory = out_dir,
                              file_prefix = "mcool_to_Brick_test",
                              mcool = mcool_path,
                              resolution = 40000,
                              experiment_name = "Testing mcool creation",
                              remove_existing = TRUE)
# Brick_list_mcool_resolutions()
out_dir <- file.path(tempdir(), "mcool_to_Brick_test")
My_BrickContainer <- load_BrickContainer(project_dir = out_dir)

Brick_load_data_from_mcool(Brick = My_BrickContainer,
                           mcool = mcool_path,
                           resolution = 10000,
                           cooler_read_limit = 10000000,
                           matrix_chunk = 2000,
                           remove_prior = TRUE,
                           norm_factor = "Iterative-Correction")


# load the Brick Container
BrickContainer_dir <- file.path(tempdir(), "mcool_to_Brick_test")
My_BrickContainer <- load_BrickContainer(project_dir = BrickContainer_dir)

# export the contact matrix to a a sparse matrix format and save it on a file
Brick_export_to_sparse(Brick=My_BrickContainer,
                       out_file="brick_export.tsv",
                       remove_file=TRUE,
                       resolution=100000,
                       sep="\t")

# create a dataframe containing the bintable
bintable <- Brick_get_bintable(My_BrickContainer, resolution = 100000)

require(GenomicRanges)

df1 <- data.frame(seqnames=seqnames(bintable),
                start(bintable)-1,
                ends=end(bintable),
                names=c(rep(".",length(bintable))),
                scores=c(rep(".", length(bintable))),
                strands=strand(bintable))

# save the bintable as a bed file
write.table(df1,
            file="bintable.bed",
            quote=FALSE,
            row.names=FALSE,
            col.names=FALSE,
            sep="\t")

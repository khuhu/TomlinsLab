###Generating the necessary input files for Dan's script
###Mainly used to test out the CN calling on Cho data
###Note to self: I need to make my own copy of both scripts so that I can edit the parts of the scripts for mouse and then redirect them .........may prove to be a slight problem b/c of the paths . we'll see


###Dan's script needs the following arguments: path to the script is /home/hovelson/scripts/runCNA.wAmps.forAuto.pl
# Usage: ./runCNA.pl --idx <coverage_Index> --gc <gc_bed_file> --out <output_dir> --normals <comma-separated-list_of_normals||or||file_wList_of_NormIDs> --flag <optional: set to 1 if gc bed has ampID in col4>\n"

###From above, I know I jsut need to generate the idx file and gc bedfile

###The idx file is not too bad the as it needs 3 fields that are tab-delimited
#(1)the sample name, (2)barcode and (3)path to the amplicon cov file - use full not and relative
###Now the second portion, the GC file ... I think ..... 



library(jsonlite)

directory <- "/mnt/DATA3/Yoda_data_dump/Auto_user_SATProton-166-Cho_mouse_1_353_410/plugin_out/coverageAnalysis_out.721"
setwd(directory)

barcodes <- system('find . -type d -name "IonXpress*"', intern = TRUE)
for(i in seq_along(barcodes)){
  barcodes[i] <- gsub("./","",barcodes[i])
}


jsonFile <- fromJSON("./results.json")


for(i in seq_along(barcodes)){
  idxTable <- NULL
  idxTable <- c("SampleName","Barocde","path")
  sampleName <- jsonFile$barcodes[[i]]$`Sample Name`
  path <- paste(directory, "/",barcodes[i], "/",sep = "")
  setwd(path)
  ampliCovFile <- system('find . -name "*.amplicon.cov.xls" | grep IonXpress',intern = TRUE)
  ampliCovFile <- sub("./","",ampliCovFile)
  ampliCovFile <- paste(path, ampliCovFile, sep = "")
  combined <- c(sampleName, barcodes[i], ampliCovFile)
  idxTable <- rbind(idxTable, combined)
  idxTable <- data.frame(idxTable, stringsAsFactors = FALSE)
  rownames(idxTable) <- NULL
  colnames(idxTable) <- NULL
  idxTable <- idxTable[-1,]
  setwd("/home/kevhu/data/")
  write.table(x = idxTable, file = paste(sampleName,barcodes[i],".txt",sep = ""),
              sep = '\t',row.names = FALSE, quote = FALSE)
}






###create gc bed 
gcbed <- read.table("/mnt/DATA3/Yoda_data_dump/Auto_user_SATProton-166-Cho_mouse_1_353_410/plugin_out/coverageAnalysis_out.721/local_beds/IAD124056_167_Designed.gc.bed", 
           skip = 1)

col4 <- sub("*;.....","",sub("GENE_ID=","", gcbed$V5))

totalBase <- gcbed$V3 - gcbed$V2
percentage <- gcbed$V6/totalBase

gcbed <- cbind(gcbed, col4, totalBase, percentage)
newGcBed <- gcbed[,-4]

newGcBed <- newGcBed[,c(1,2,3,6,5,7,8,4)]

write.table(newGcBed, "/home/kevhu/data/IAD124056_167_Designed.test.gc.bed", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")

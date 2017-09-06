###create gc bed 
gcbed <- read.table("/mnt/DATA3/Yoda_data_dump/Auto_user_SATProton-166-Cho_mouse_1_353_410/plugin_out/coverageAnalysis_out.721/local_beds/IAD124056_167_Designed.gc.bed", 
           skip = 1)
### with pool number
col4 <- sub("*;.....","",sub("GENE_ID=","", gcbed$V5))

### without pool number
col4 <- sub("*;......","",sub("GENE_ID=","", gcbed$V5))

totalBase <- gcbed$V3 - gcbed$V2
percentage <- gcbed$V6/totalBase

gcbed <- cbind(gcbed, col4, totalBase, percentage)

newGcBed <- gcbed[,c(1,2,3,4,6,8,9,7)]

write.table(newGcBed, "/home/kevhu/data/IAD124056_167_Designed.test.gc.bed", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")


write.table(newGcBed, "/home/kevhu/data/IAD124056_167_Designed.nopool.gc.bed", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")

# Libraries
library(reshape)
###################################################################################################
args  =  commandArgs(TRUE);
argmat  =  sapply(strsplit(args, "="), identity)

for (i in seq.int(length=ncol(argmat))) {
  assign(argmat[1, i], argmat[2, i])
}

# available variables
print(ls())


###################################################################################################

good_categories=c("exon","5UTR","3UTR","intron","TE","none")


#name="wt_poll_chip"
#folder_name="uniq-full-rep"

file_name=paste(name,"_final_annotation.txt",sep="")
table=read.table(file_name)

data=table[table$V2 %in% good_categories,]
data2=data$V3
labels_names=data$V

output_name=paste(name,"_pie.jpeg",sep="")    
jpeg(output_name,width = 1024, height = 1024, units = "px",quality=100)
pie(data2,clockwise=TRUE, col= c("#ECF0B1","#CB8948","#A6BEE3","#BE5A66","#85AD53","#82817F"),radius=1 )
title(main=c(name,folder_name), font.main= 4)
dev.off()



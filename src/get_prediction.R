#---------------------------------------#
# Get predictions using all-SNPs models #
#---------------------------------------#

args = commandArgs(trailingOnly = T)
data = args[1]
output = args[2]

###############################################################################
# init gene expression matrix (output)
EXPR = NULL #will be a indiv x gene_expr matrix
NAMES = NULL #list of gene names

#read models
models = read.delim('../model/AllSNPs-elasticNet.txt',header=TRUE)
for(gene in unique(models$gene)){
  #store names
  NAMES = c(NAMES,gene)
  #subset beta weights
  idx = which(models$gene == gene)
  tmp = data[,which(colnames(data) %in% models$SNP[idx])]
  beta = models$beta[idx]
  names(beta) = models$SNP[idx]
  
  if(!is.null(dim(tmp))){
    EXPR = cbind(EXPR, tmp%*%beta[colnames(tmp)])
  }else{
    EXPR = cbind(EXPR, tmp*beta[colnames(data)[which(colnames(data) %in% models$SNP[idx])]])
  }  
}

write.table(EXPR,file=output,quote=FALSE,row.names = row.names(data),col.names = NAMES)

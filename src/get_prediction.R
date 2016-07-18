#---------------------------------------#
# Get predictions using all-SNPs models #
#---------------------------------------#

args = commandArgs(trailingOnly = T)
data = args[1]
output = args[2]


#load input data
GENO = read.table(data,header=TRUE)
GENO = as.matrix(GENO)

#read models
models = read.delim('../model/AllSNPs-elasticNet.txt',header=TRUE,as.is = TRUE)

###############################################################################
# init gene expression matrix (output)
EXPR = NULL #will be a indiv x gene_expr matrix
NAMES = NULL #list of gene names

for(gene in unique(models$gene)){
  #store names
  NAMES = c(NAMES,gene)
  #subset beta weights
  idx = which(models$gene == gene)
  match.idx = which(colnames(GENO) %in% models$SNP[idx])
  if(length(match.idx) > 0){
  tmp = GENO[,match.idx]
  beta = as.numeric(models$beta[idx])
  names(beta) = models$SNP[idx]
  
  if(!is.null(dim(tmp))){ #general case
    EXPR = cbind(EXPR, tmp%*%beta[colnames(tmp)])
  }else{ #only one SNP found case
    EXPR = cbind(EXPR, tmp*beta[colnames(GENO)[which(colnames(GENO) %in% models$SNP[idx])]])
  }  
  
  }else{EXPR = cbind(EXPR,rep(0,nrow(GENO)))} #case where not a single SNP matched with model SNPs
}

write.table(EXPR,file=output,quote=FALSE,col.names = NAMES)

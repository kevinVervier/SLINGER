# geno2expr-ML
Work on large-scale ML for gene expression prediction based on genotype only.


# Introduction
This project aims to provide a machine-learning based tool for assessing gene expression based on genotype data only.
# Installation
This tool requires the installation of [R software](http://cran.r-project.org/).
## Dependencies
No specific dependency, except basic R packages installed by default. 
# Tutorial
After cloning the repository, you may want to call the `get_prediction.R` function on a test sample data, to make sure that everything runs properly.

First, move in the `src` repository, `cd <github-clone-location>/src`.

Then run predictions for sample data: `Rscript get_prediction.R ../test/sample.txt ../test/test_output.txt`.

This function takes as inputs:

* 1) genotype matrix with 0 --> 2 allele count values for individuals (rows) and SNPs (columns).
* 2) path to output file where estimated gene expression will be stored.

It should create a new file in the `test` repository, called `test_output.txt`.


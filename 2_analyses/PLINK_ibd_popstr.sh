#!/bin/sh

#PBS -N PLINK
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module load bioinfo
module load vcftools

cd $PBS_O_WORKDIR

# path to PLINK
export PATH=/depot/fnrdewoody/apps:$PATH

# make PLINK files 
#vcftools --vcf SNPs_20x_DP.vcf --plink --out SNPs_20x_DP

# make test file with scaffold info instead of chromosome info
# take column with contig info
#awk '{print $2}' SNPs_20x_DP.map > scaffold.txt
#split at the first full stop
#awk -F'.' '{print $1}' scaffold.txt > scaffold2.txt
#paste -d' ' scaffold2.txt SNPs_20x_DP.map > test.map
#awk '{print $1,$3,$4,$5}' test.map > SNPs_20x_DP.map

# relatedness and pop structure test
# PPC=0.05
plink-1.9 --ped SNPs_20x_DP.ped --map SNPs_20x_DP.map -out PPC \
--allow-extra-chr --genome full --ppc-gap 500 --ppc 0.05 --cluster \
-maf 0.01 


# test ROH
plink-1.9 --ped SNPs_20x_DP.ped --map SNPs_20x_DP.map --allow-extra-chr --homozyg-snp 20 \
--homozyg-kb 1 --homozyg-window-het 1 --homozyg-window-snp 20 \
--homozyg-window-threshold 0.01 --out SNPs_20x_DP


# END


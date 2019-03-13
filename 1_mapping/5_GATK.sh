#!/bin/sh

#PBS -N GTcalling
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load GATK
module load picard-tools


cd $PBS_O_WORKDIR

#GATK (SNP calling across all 3 samples (SNPs, indels, and structural variation (SV))
#First HaplotypeCaller for each individual sample - > then call genotypes jointly 

# copy the ref files
#cp /scratch/snyder/a/abruenic/grey_whale_1_12/BWA_men_rerun/ref.* .
 
# copy the .g.vcf + .g.vcf.idx files
#cp /scratch/snyder/a/abruenic/grey_whale_project/grey_whale_1_12/BWA_men_rerun/*_NO_*.g.vcf .
#cp /scratch/snyder/a/abruenic/grey_whale_project/grey_whale_2_13/BWA_mem_rerun/*_NO_*.g.vcf .
#cp /scratch/snyder/a/abruenic/grey_whale_project/grey_whale_eastern/BWA_mem_rerun/*_NO_*.g.vcf .

# filter based on depth of coverage prior to combining the vcf files
#PicardCommandLine FilterVcf I=112_GVCF_variants.g.vcf O=112_GVCF_variants_20x.g.vcf \
#MIN_DP=20

# the filtered sites needs to be removed from the vcfs
#sed '/LowDP/d' 112_GVCF_variants_20x.g.vcf > 112_GVCF_variants_20x_DP.g.vcf

#PicardCommandLine FilterVcf I=213_GVCF_variants.g.vcf O=213_GVCF_variants_20x.g.vcf \
#MIN_DP=20

# the filtered sites needs to be removed from the vcfs
#sed '/LowDP/d' 213_GVCF_variants_20x.g.vcf > 213_GVCF_variants_20x_DP.g.vcf

#PicardCommandLine FilterVcf I=EGW_GVCF_variants.g.vcf O=EGW_GVCF_variants_20x.g.vcf \
#MIN_DP=20

# the filtered sites needs to be removed from the vcfs
#sed '/LowDP/d' EGW_GVCF_variants_20x.g.vcf > EGW_GVCF_variants_20x_DP.g.vcf

# run without multi-treading as this cause errors
# run genotype caller on ALL samples combined
GenomeAnalysisTK -T GenotypeGVCFs -R ref.fa \
--variant 112_GVCF_variants_20x_DP.g.vcf \
--variant 213_GVCF_variants_20x_DP.g.vcf \
--variant EGW_GVCF_variants_20x_DP.g.vcf \
-o NO_QUAL_SNPs_20x_DP.vcf

# select only SNPs
GenomeAnalysisTK -T SelectVariants -R ref.fa -V NO_QUAL_SNPs_20x_DP.vcf \
-selectType SNP -o SNPs_20x_DP.vcf

# filter so depth of cov is minimum 20x per sample
#vcffilter -f "DP > 19" NO_QUAL_SNPs_20x.vcf

# END



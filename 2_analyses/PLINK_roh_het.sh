#!/bin/sh

#PBS -N PLINK
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load vcftools
module load bcftools

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

# split VCF into individual sample files
#for file in SNPs_20x_DP.vcf*; do
#  for sample in `bcftools query -l $file`; do
#    bcftools view -c1 -Oz -s $sample -o ${file/.vcf*/$sample.vcf.gz} $file
#  done
#done

# unzip sample vcf files
#gunzip SNPs_20x_DPsample112.vcf.gz 
#gunzip SNPs_20x_DPsample213.vcf.gz 
#gunzip SNPs_20x_DPsampleEGW.vcf.gz  

plink-1.9 --ped SNPs_20x_DP.ped --map SNPs_20x_DP.map --allow-extra-chr --homozyg-snp 20 \
--homozyg-kb 1 --homozyg-window-het 1 --homozyg-window-snp 20 \
--homozyg-window-threshold 0.01 --out SNPs_20x_DP

# split *.hom into roh files for each sample
grep 'sample112' SNPs_20x_DP.hom > 112_roh.hom
grep 'sample213' SNPs_20x_DP.hom > 213_roh.hom
grep 'sampleEGW' SNPs_20x_DP.hom > EGW_roh.hom

# make file with header to have ROH summary stats in
echo -e "sample\t rohNumber\t rohLength\t snpNumberROH\t sites_cov20x\t \
heterozygote_sites\t homozygote_sites\t total_SNPs\t nonvariant_sites\t \
heterozygosity_all\t heterozygosity_no_ROH\t SNPrate" \
> /scratch/snyder/a/abruenic/grey_whale_project/REVISIONS/ROH_summary_stats.txt

# for each sample get ROH summary stats
cat species.txt | while read -r LINE

do

echo $LINE

##################################################
###### THIS PART FINDS RUNS-OF-HOMOZYGOSITY ######
##################################################

# count number of ROHs, ROHs are in column 9
awk '{print $9}' $LINE_roh.hom > roh.txt

# count number of ROHs
wc -l roh.txt > rohNumber.txt
rohNumber=$(awk '{print $1}' rohNumber.txt)

# estimate length of ROHs
rohLength=$(awk '{ sum += $1} END {printf "%.2f", sum }' roh.txt)

# number of SNPs in ROHs, SNPs are in column 10
awk '{print $10}' $LINE.hom > roh_snps.txt

# estimate number of ROHs
snpNumberROH=$(awk '{ sum += $1} END {printf "%.2f", sum }' roh_snps.txt)

############################################
###### THIS PART FINDS HETEROZYGOSITY ######
############################################

# total number of sites at 20x depth of coverage
# replace \t with \n
# the realigned_reads.sample_cumulative_coverage_counts file has been renamed
# to reflect the sample name
tr '\t' '\n' < $LINE_depthofcov > site_20x.txt
# grep line 524 (gte_20)
sites=$(sed -n '524p' site_20x.txt)

# the VCF has genotypes for all 3 samples

# count heterozygotes
grep '0/1' SNPs_20x_DP.sample$LINE.vcf > het.txt
het="$(wc -l < het.txt)"

# count homozygotes
grep '0/0' SNPs_20x_DPsample$LINE.vcf > homo.txt
grep '1/1' SNPs_20x_DPsample$LINE.vcf >> homo.txt
homo="$(wc -l < homo.txt)"

# total number of SNPs
SNPs=$(($homo + $het)) 

# non-variant sites
bc <<< "($sites - $SNPs)" > non.txt
non=$(sed -n '1p' non.txt)

# heterozygosity
# adjust scale to allow for decimals
bc <<< "scale=9; ($het / $sites)" > hetero.txt
heteroAll=$(sed -n '1p' hetero.txt)

# heterozygosity minus ROH snps
bc <<< "($sites - $snpNumberROH)" > sitesNoRoh.txt
sitesNoRoh=$(sed -n '1p' sitesNoRoh.txt)
bc <<< "scale=9; ($het / $sitesNoRoh)" > hetNoRoh.txt
heteroNoRoh=$(sed -n '1p' hetNoRoh.txt)

# SNPrate
bc <<< "scale=6; ($SNPs / $sites)" > SNPrate.txt
SNPrate=$(sed -n '1p' SNPrate.txt)

# print to file
echo -e "$LINE\t $rohNumber\t $rohLength\t $snpNumberROH\t $sites\t $het\t \
$homo\t $SNPs\t $non\t $heteroAll\t $heteroNoRoh\t $SNPrate" \
>> /scratch/snyder/a/abruenic/grey_whale_project/REVISIONS/ROH_summary_stats.txt

done

# END


#!/bin/sh

#PBS -N PSMC_mpileup
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools

cd $PBS_O_WORKDIR

# path to msmc
export PATH=/depot/fnrdewoody/apps:$PATH

# path to psmc
export PATH=/depot/fnrdewoody/apps/psmc-master:$PATH

# from "https://github.com/lh3/psmc"

# generate the diploid wgs consensus sequence for each whale
# test with 112_realigned_reads.bam
# mean depth of cov is 35x. -d should be 1/3 and -D should be double the mean cov
samtools mpileup -C50 -uf ref.fa EGW_realigned_reads.bam | bcftools view -c - \
| vcfutils.pl vcf2fq -d 10 -D 70 | gzip > EGW.fq.gz

# End

#!/bin/sh

#PBS -N MSMC
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools
module load GATK
module load vcflib

cd $PBS_O_WORKDIR

# path to msmc
export PATH=/depot/fnrdewoody/apps:$PATH

# path to psmc
export PATH=/depot/fnrdewoody/apps/psmc-master:$PATH

# from "https://github.com/lh3/psmc"

# generate the diploid wgs consensus sequence for each whale
# test with 112_realigned_reads.bam
# mean depth of cov is 35x. -d should be 1/3 and -D should be double the mean cov
samtools mpileup -C50 -uf ref.fa 112_realigned_reads.bam | bcftools view -c - \
| vcfutils.pl vcf2fq -d 10 -D 70 | gzip > 112.fq.gz
      
#To perform bootstrapping, one has to run splitfa first to split long chromosome
#sequences to shorter segments. When the `-b' option is applied, psmc will then
#randomly sample with replacement from these segments. As an example, the
#following command lines perform 100 rounds of bootstrapping:

    utils/fq2psmcfa -q20 diploid.fq.gz > diploid.psmcfa
    
	utils/splitfa diploid.psmcfa > split.psmcfa
	
    psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o diploid.psmc diploid.psmcfa
    
	seq 100 | xargs -i echo psmc -N25 -t15 -r5 -b -p "4+25*2+4+6" \
	    -o round-{}.psmc split.fa | sh
    cat diploid.psmc round-*.psmc > combined.psmc
	utils/psmc_plot.pl -pY50000 combined combined.psmc

#One probably wants to modify the "xargs" command-line to parallelize PSMC.

# END


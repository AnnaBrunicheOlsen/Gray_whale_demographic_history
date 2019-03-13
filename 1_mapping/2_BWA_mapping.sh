#!/bin/sh

#PBS -N fortress
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

#Paired-end reads from the 3 grey whales were mapped to the reference individually. We changed the read group to reflect the #individual sample names (e.g., sample1=112, sample2 = 213, sample3= EGW)
bwa mem -t 20 -M -R "@RG\tID:group1\tSM:sample1\tPL:illumina\tLB:lib1\tPU:unit1" ref.fa read1.fq read2.fq > aln.sam

# END
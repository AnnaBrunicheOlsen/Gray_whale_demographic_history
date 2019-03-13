#!/bin/sh

#PBS -N depthofcov
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load GATK

cd $PBS_O_WORKDIR

# depht of coverage 
GenomeAnalysisTK -T DepthOfCoverage -R ref.fa -o realigned_reads \
-I EGW_realigned_reads.bam

cp realigned_reads.sample_cumulative_coverage_counts EGW_depthofcov
mv EGW_depthofcov /scratch/snyder/a/abruenic/grey_whale_project/REVISIONS/

# END



#!/bin/sh

#PBS -N GATK_nt1
#PBS -q standby
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
#PBS -l walltime=4:00:00
#PBS -m abe

module purge
module load bioinfo
module load GATK

cd $PBS_O_WORKDIR

cd /scratch/snyder/a/abruenic/grey_whale_project/grey_whale_1_12/BWA_men_rerun/

GenomeAnalysisTK -T DepthOfCoverage -R ref.fa -o coverage \
-I *_realigned_reads_sorted.bam -nt 20 -omitIntervals -omitSampleSummary \
-omitBaseOutput

cd ..
cd ..

cd /scratch/snyder/a/abruenic/grey_whale_project/grey_whale_2_13/BWA_mem_rerun/

GenomeAnalysisTK -T DepthOfCoverage -R ref.fa -o coverage \
-I *_realigned_reads_sorted.bam -nt 20 -omitIntervals -omitSampleSummary \
-omitBaseOutput

cd ..
cd ..

cd /scratch/snyder/a/abruenic/grey_whale_project/grey_whale_eastern/BWA_mem_rerun/

GenomeAnalysisTK -T DepthOfCoverage -R ref.fa -o coverage \
-I *_realigned_reads_sorted.bam -nt 20 -omitIntervals -omitSampleSummary \
-omitBaseOutput

	
# END

#!/bin/sh

#PBS -N picard
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load picard-tools

cd $PBS_O_WORKDIR

#Picard Tools was used to mark and remove duplicated reads
# Validate the SAM file should produce a validate_output.txt file that says there are no errors. 
PicardCommandLine ValidateSamFile I=aln.sam MODE=SUMMARY O=validate_samfile.txt

# make tmp directory for the files
mkdir tmp
PicardCommandLine SortSam SORT_ORDER=coordinate INPUT=aln.sam OUTPUT=sorted.bam \
TMP_DIR=`pwd`/tmp VALIDATION_STRINGENCY=LENIENT

# mark PCR duplicated reads without removing them
PicardCommandLine MarkDuplicates INPUT=sorted.bam OUTPUT=marked.bam M=metrics.txt

# check coverage
PicardCommandLine CollectWgsMetrics I=marked.bam O=coverage_marked.txt R=ref.fa 

PicardCommandLine BuildBamIndex INPUT=marked.bam

# create reference that reads can be mapped to.
samtools faidx ref.fa

PicardCommandLine CreateSequenceDictionary reference=ref.fa output=revisedassembly.dict

# END


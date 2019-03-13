#!/bin/sh

#PBS -N GATK_hapcal
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load GATK

cd $PBS_O_WORKDIR

#GATK was used for local realignment of reads
#GenomeAnalysisTK -nt 20 -T RealignerTargetCreator -R ref.fa -I marked.bam \
#-o forIndelRealigner.intervals

#GenomeAnalysisTK -T IndelRealigner -R ref.fa -I marked.bam \
#-targetIntervals forIndelRealigner.intervals -o realigned_reads.bam

# NB outfile name according to sample
# here its sample: 213
# this is the version we submitted to BMC
#GenomeAnalysisTK -T HaplotypeCaller -R ref.fa -I realigned_reads.bam -nct 19 \
#--genotyping_mode DISCOVERY --emitRefConfidence GVCF -stand_emit_conf 30 \
#-stand_call_conf 10 -o 213_GVCF_variants.g.vcf

# Run HaplotypeCaller
# this is with the same settings as the RPOH manu
GenomeAnalysisTK -T HaplotypeCaller -R ref.fa -I EGW_realigned_reads.bam -nct 20 \
--genotyping_mode DISCOVERY --emitRefConfidence GVCF -stand_call_conf 0 \
--min_base_quality_score 20 --min_mapping_quality_score 20 \
-o EGW_NO_QUAL_variants.g.vcf

#‘HaplotypeCaller’ applying a minimum base quality score of 20 
# (which corresponds to a base calling error rate of ~1% (Nielsen et al. 2011))
# with a minimum mapping quality score of 20. 


# Note April 17th 2017 when you run HC in GVCF mode the thresholds are set to 0 
# automatically since we want to account for every possibility.
# See https://gatkforums.broadinstitute.org/gatk/discussion/5220/producing-gvcf-with-haplotype-caller-3-3-0-incompatibility-with-stand-emit-conf-stand-call-conf

# END



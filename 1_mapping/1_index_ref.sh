#!/bin/sh

#PBS -N index_ref
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

#BWA was used to map reads to the minke whale genome (ref.fa). The reference genome was indexed:
bwa index -a bwtsw ref.fa

# END
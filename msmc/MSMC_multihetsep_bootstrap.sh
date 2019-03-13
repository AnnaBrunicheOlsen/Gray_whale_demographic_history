#!/bin/sh

#PBS -N MSMC_bootstrapping
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load python/3.4.1

cd $PBS_O_WORKDIR

# MSMC is in /depot/fnrdewoody/apps/

python3 /depot/fnrdewoody/apps/msmc-tools-master/multihetsep_bootstrap.py \
-n 20 -s 5000000 --chunks_per_chromosome 10 \
--nr_chromosomes 11 EGW_bootstrap \
scaf590092363_EGW.txt \
scaf590100083_EGW.txt \
scaf590093474_EGW.txt \
scaf590091147_EGW.txt \
scaf590095696_EGW.txt \
scaf590100999_EGW.txt \
scaf590098591_EGW.txt \
scaf590106210_EGW.txt \
scaf590096804_EGW.txt \
scaf590094585_EGW.txt \
scaf590107106_EGW.txt

# END
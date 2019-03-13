#!/bin/sh

#PBS -N msmc_original
#PBS -q fnrquail
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

# export msmc path
export PATH=/apps/rhel6/msmc:$PATH

# put out the 30Mb largest 11 scaffolds to start with
msmc -o 112 \
-t 20 \
scaf590107106_112.txt \
scaf590094585_112.txt \
scaf590096804_112.txt \
scaf590106210_112.txt \
scaf590098591_112.txt \
scaf590100999_112.txt \
scaf590095696_112.txt \
scaf590091147_112.txt \
scaf590093474_112.txt \
scaf590100083_112.txt \
scaf590092363_112.txt

msmc -o 213 \
-t 20 \
scaf590107106_213.txt \
scaf590094585_213.txt \
scaf590096804_213.txt \
scaf590106210_213.txt \
scaf590098591_213.txt \
scaf590100999_213.txt \
scaf590095696_213.txt \
scaf590091147_213.txt \
scaf590093474_213.txt \
scaf590100083_213.txt \
scaf590092363_213.txt

msmc -o EGW \
-t 20 \
scaf590107106_EGW.txt \
scaf590094585_EGW.txt \
scaf590096804_EGW.txt \
scaf590106210_EGW.txt \
scaf590098591_EGW.txt \
scaf590100999_EGW.txt \
scaf590095696_EGW.txt \
scaf590091147_EGW.txt \
scaf590093474_EGW.txt \
scaf590100083_EGW.txt \
scaf590092363_EGW.txt

# END

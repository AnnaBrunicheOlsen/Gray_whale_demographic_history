#!/bin/sh

#PBS -N msmc_bootstraps
#PBS -q fnrgenetics
#PBS -l nodes=1:ppn=20,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

# export msmc path
export PATH=/apps/rhel6/msmc:$PATH

cat bootstraps_112.txt  | while read -r LINE

do

cd $LINE

msmc --fixedRecombination -o $LINE \
-i 300 -t 20 \
bootstrap_multihetsep.chr1.txt \
bootstrap_multihetsep.chr2.txt \
bootstrap_multihetsep.chr3.txt \
bootstrap_multihetsep.chr4.txt \
bootstrap_multihetsep.chr5.txt \
bootstrap_multihetsep.chr6.txt \
bootstrap_multihetsep.chr7.txt \
bootstrap_multihetsep.chr8.txt \
bootstrap_multihetsep.chr9.txt \
bootstrap_multihetsep.chr10.txt \
bootstrap_multihetsep.chr11.txt

cd..

done

# END

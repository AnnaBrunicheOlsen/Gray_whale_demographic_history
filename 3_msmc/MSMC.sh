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

python3 /depot/fnrdewoody/apps/msmc-tools-master/multihetsep_bootstrap.py -h 


# END

usage: multihetsep_bootstrap.py [-h] [-n NR_BOOTSTRAPS] [-s CHUNK_SIZE]
                                [--chunks_per_chromosome CHUNKS_PER_CHROMOSOME]
                                [--nr_chromosomes NR_CHROMOSOMES]
                                [--seed SEED]
                                out_dir_prefix files [files ...]

positional arguments:
  out_dir_prefix        directory-prefix to write bootstraps to
  files

optional arguments:
  -h, --help            show this help message and exit
  -n NR_BOOTSTRAPS, --nr_bootstraps NR_BOOTSTRAPS
                        nr of bootstraps [20]
  -s CHUNK_SIZE, --chunk_size CHUNK_SIZE
                        size of bootstrap chunks [5000000]
  --chunks_per_chromosome CHUNKS_PER_CHROMOSOME
                        nr of chunks to put on one chromosome in the bootstrap
                        [20]
  --nr_chromosomes NR_CHROMOSOMES
                        nr of chromosomes to write [30]
  --seed SEED           initialize the random number generator
  
  
python3 /multihetsep_bootstrap.py -n 100 -s 5000000 --chunks_per_chromosome 10 \
--nr_chromosomes 10 bootstrap 
scaf1.txt scaf2.txt scaf3.txt scaf4.txt scaf5.txt scaf6.txt scaf7.txt scaf8.txt scaf9.txt scaf10.txt

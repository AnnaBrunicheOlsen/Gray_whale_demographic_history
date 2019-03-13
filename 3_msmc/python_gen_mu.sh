#!/bin/sh

#PBS -N msmc_bootstraps
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=1:00:00
#PBS -m abe

module purge
module load bioinfo
module load python/2.7.8

# remember to change the mutation rate and generation time in the Python script
# here its mu=4.8e-10 and gen=18.9

cat filelist.txt  | while read -r LINE

do

python ./popSize_plot_GW.py $LINE out.$LINE

done

# END
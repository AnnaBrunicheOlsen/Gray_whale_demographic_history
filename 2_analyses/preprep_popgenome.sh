#!/bin/sh

#PBS -N popgenome
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=300:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools
module load tabix

cd $PBS_O_WORKDIR

# for each line in tenScaf.txt print the lines from the SNPs vcf to a new file

# grep vcf header
grep '##' no_pipe.vcf > header

cat tenScaf.txt | while read -r LINE

do

echo $LINE

cd $LINE

bgzip $LINE

tabix -p vcf $LINE.gz

cd ..

done


# END

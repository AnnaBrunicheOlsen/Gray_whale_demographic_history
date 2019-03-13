#!/bin/sh

#PBS -N generate_multihetsep.py
#PBS -q fnrdewoody
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=10:00:00
#PBS -m abe

module purge
module load bioinfo
module load samtools
module load bcftools
module load python/3.4.1
module load bwa

cd $PBS_O_WORKDIR


# generate mask-file 
### makeMappabilityMask.py
#This is a little script that converts a fasta file with a mappability mask \
#(see Heng Li's [SNPable](http://lh3lh3.users.sourceforge.net/snpable.shtml)) \
#to a bed file. Have a look at the script, you should change the path to the fasta file.
# dette er for at mappe reads tilbage til ref for at se om der er regioner som mapper
# med lav ss. Fx regioner af genomet som ikke er unikke

# needs python3
# make infile
###### scaf1 ######
./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf1_112.bed.gz \
                         --mask=scaf1.ref.mask.bed.gz \
                         scaf1_112.vcf.gz > scaf1_112.txt

./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf1_213.bed.gz \
                         --mask=scaf1.ref.mask.bed.gz \
                         scaf1_213.vcf.gz > scaf1_213.txt

./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf1_EGW.bed.gz \
                         --mask=scaf1.ref.mask.bed.gz \
                         scaf1_EGW.vcf.gz > scaf1_EGW.txt



###### scaf2 ######
./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf2_112.bed.gz \
                         --mask=scaf2.ref.mask.bed.gz \
                         scaf2_112.vcf.gz > scaf2_112.txt

./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf2_213.bed.gz \
                         --mask=scaf2.ref.mask.bed.gz \
                         scaf2_213.vcf.gz > scaf2_213.txt

./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf2_EGW.bed.gz \
                         --mask=scaf2.ref.mask.bed.gz \
                         scaf2_EGW.vcf.gz > scaf2_EGW.txt

                         
###### scaf3 ######
./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf3_112.bed.gz \
                         --mask=scaf3.ref.mask.bed.gz \
                         scaf3_112.vcf.gz > scaf3_112.txt

./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf3_213.bed.gz \
                         --mask=scaf3.ref.mask.bed.gz \
                         scaf3_213.vcf.gz > scaf3_213.txt

./msmc-tools-master/generate_multihetsep.py \
						 --mask=scaf3_EGW.bed.gz \
                         --mask=scaf3.ref.mask.bed.gz \
                         scaf3_EGW.vcf.gz > scaf3_EGW.txt

                                                                            
# END

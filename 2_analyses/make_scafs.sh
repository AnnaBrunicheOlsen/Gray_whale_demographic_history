#!/bin/sh

#PBS -N PLINK
#PBS -q standby
#PBS -l nodes=1:ppn=1,naccesspolicy=shared
#PBS -l walltime=0:30:00
#PBS -m abe

module purge
module load bioinfo

cd $PBS_O_WORKDIR

# replace all pipes
sed -i -e 's/|/_/g' no_pipe.vcf

# for each line in tenScaf.txt print the lines from the SNPs vcf to a new file

# grep vcf header
grep '##' no_pipe.vcf > header

cat tenScaf.txt | while read -r LINE

do

echo $LINE

grep $LINE no_pipe.vcf > file.vcf

# we only want the following columns
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample112_sample112	sample213_sample213	sampleEGW_sampleEGW
print 

# number of columns in file.vcf
awk '{print NF}' file.vcf | sort -nu | tail -n 1

# print only the first three characters (GT) from the three sample columns
# sample 112
awk '{ print $10 }' file.vcf | cut -c-3 > 112
# sample 112
awk '{ print $11 }' file.vcf | cut -c-3 > 213 
# sample EGW
awk '{ print $12 }' file.vcf | cut -c-3 > EGW

# make column with PR
cp file.vcf file

cut -d "\t" -f 1,2,3,4,5,6,3,3 file > newfile

# pick the columns of interests from the file.vcf
awk 'BEGIN {FS="\t"} ; { print $1,$2,$3,$4,$5,$6,$7,$3,$3 }' file > newfile

# put the vcf back together
paste newfile 112 213 EGW > $LINE.vcf
cat header $LINE.vcf > test.vcf

mkdir $LINE
mv $LINE.vcf /scratch/snyder/a/abruenic/grey_whale_project/REVISIONS/popgenome/$LINE/

done


# END

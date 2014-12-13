# Extract 23andme SNPs from 1000GP

# 23andme SNPs file name
CHR=$1
SNP_TXT=23ANDME_chr${CHR}_SNPs.txt
FILENAME=ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes

# directories
# root directory for IMPUTE2
ROOT_DIR=./
# data directories
DATA_DIR=${ROOT_DIR}data/
# reference directory
REF_DIR='/home/rexren/KGBIG/impReference/1000genomes/1000GP_Phase3/'


# PLINK executable (must be 1.9 or above)
PLINK_EXEC=/home/rexren/plink/plink
# input SNPs file
INPUT_SNPs_FILE=${DATA_DIR}${SNP_TXT}
# input vcf file
INPUT_VCF_FILE=${DATA_DIR}${FILENAME}.vcf.gz

# output filename
OUTPUT_FILE=${DATA_DIR}${FILENAME}

# # convert vfc to oxford format
# $PLINK_EXEC --vcf ${INPUT_VCF_FILE} --recode oxford --out ${OUTPUT_FILE}
# 
# convert vfc to bim ben fam format

# $PLINK_EXEC --vcf ${INPUT_VCF_FILE} --recode --out ${OUTPUT_FILE}



# extract 23andme SNPs, again with --snps-only no-DI option
$PLINK_EXEC --vcf ${INPUT_VCF_FILE} --extract ${INPUT_SNPs_FILE} --snps-only no-DI --make-bed --out ${OUTPUT_FILE}_23ANDME

# recode to oxford format
$PLINK_EXEC --bfile ${OUTPUT_FILE}_23ANDME --recode oxford --out ${OUTPUT_FILE}_23ANDME

# recode to vcf format
$PLINK_EXEC --bfile ${OUTPUT_FILE}_23ANDME --recode vcf --out ${OUTPUT_FILE}_23ANDME

# update 23ANDME_chr2_SNPs.txt
cut -d ' ' -f2 ${OUTPUT_FILE}_23ANDME.gen > $INPUT_SNPs_FILE


# gzip -c ${OUTPUT_FILE}_23ANDME.vcf > ${OUTPUT_FILE}_23ANDME.vcf.gz

# # alternative of using bfile
# $PLINK_EXEC --vcf ${INPUT_VCF_FILE} --out ${OUTPUT}
# # extract 23andme SNPs
# $PLINK_EXEC --bfile ${OUTPUT} --extract ${INPUT_SNPs_FILE} --out ${OUTPUT}_23ANDME
# # convert to oxford
# $PLINK_EXEC --bfile ${OUTPUT}_23ANDME --recode oxford --out ${OUTPUT}_23ANDME


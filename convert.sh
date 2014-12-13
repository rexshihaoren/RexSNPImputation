# convert a 23andme txt file to gen


# 23andme file name
ME_NAME=$1
CHR=$2
ME_NAME_TXT=${ME_NAME}.txt

# directories
# root directory for RexSNPImputation
ROOT_DIR=./
# data directories
DATA_DIR=${ROOT_DIR}data/
# reference directory
REF_DIR='/home/rexren/KGBIG/impReference/1000genomes/1000GP_Phase3/'
# helper directory
HELP_DIR=${ROOT_DIR}helper/

# PLINK executable (must be 1.9 or above), user must install
PLINK_EXEC=${HELP_DIR}plink/plink

# input file
INPUT_FILE=${DATA_DIR}${ME_NAME_TXT}

# output file
OUTPUT_FILE=${DATA_DIR}23ANDME_chr${CHR}

# convert 23file to oxford format
# # first convert 23 files to binary
# $PLINK_EXEC --23file ${DATA_DIR}${ME_NAME_TXT} --snps-only no-DI --chr ${CHR} --make-bed --out ${OUTPUT_FILE}
# # then merge
# $PLINK_EXEC --bfile ${OUTPUT_FILE} --bmerge ${OUTPUT_FILE}.bed ${OUTPUT_FILE}.bim ${OUTPUT_FILE}.fam --make-bed --out ${OUTPUT_FILE}_merge2
# # then convert to oxford

# --snps-only no-DI to make sure there is no multi-char allels and no DI
$PLINK_EXEC --23file ${DATA_DIR}${ME_NAME_TXT} --snps-only no-DI --recode oxford --chr ${CHR} --out ${OUTPUT_FILE}_${ME_NAME}
# Extract 23andme SNPS for this chromosome
cut -d' ' -f2 ${OUTPUT_FILE}_${ME_NAME}.gen > ${OUTPUT_FILE}_SNPs.txt
# cp ${OUTPUT_FILE}_SNPs.txt ${OUTPUT_FILE}.snps
# gzip -c ${OUTPUT_FILE}.snps > ${OUTPUT_FILE}.snps.gz


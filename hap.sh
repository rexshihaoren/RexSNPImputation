# Haplotyping

# 23andme SNPs file name
CHR=$1
FILENAME=ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes

# directories
# root directory for IMPUTE2
ROOT_DIR=./
# data directories
DATA_DIR=${ROOT_DIR}data/
# reference directory
REF_DIR='/home/rexren/KGBIG/impReference/1000genomes/1000GP_Phase3/'


# SHAPEIT executable
SHAPEIT_EXEC=${ROOT_DIR}shapeit/shapeit
# input GWAS file
INPUT_GWAS_FILE=${DATA_DIR}${FILENAME}_23ANDME

## reference data files
GENMAP_FILE=${REF_DIR}genetic_map_chr${CHR}_combined_b37.txt
HAPS_FILE=${REF_DIR}1000GP_Phase3_chr${CHR}.hap.gz
LEGEND_FILE=${REF_DIR}1000GP_Phase3_chr${CHR}.legend.gz
SAMPLE_FILE=${REF_DIR}1000GP_Phase3.sample

# alignments filename
ALIGNMENT_FILE=${INPUT_GWAS_FILE}.alignments
# output filename
OUTPUT_FILE=${INPUT_GWAS_FILE}.phased
# number of cores
CORE=$(grep -c processor /proc/cpuinfo)


# # CHECK Alignment
# $SHAPEIT_EXEC -check \
#         -B $INPUT_GWAS_FILE \
#         -M $GENMAP_FILE \
#         --input-ref $HAPS_FILE $LEGEND_FILE $SAMPLE_FILE \
#         -T $CORE \
#         --output-log $ALIGNMENT_FILE

# pre-phase with reference panel
$SHAPEIT_EXEC -B $INPUT_GWAS_FILE \
			-M $GENMAP_FILE \
			--input-ref $HAPS_FILE $LEGEND_FILE $SAMPLE_FILE \
			-O $OUTPUT_FILE \
			-T $CORE

# generate snps for minimac2
sed 's/\(^[0-9a-Z]*\) \([0-9a-Z]*\) \([0-9a-Z]*\) \(.*$\)/\1:\3/g' ${OUTPUT_FILE}.haps > ${OUTPUT_FILE}.snps
# gzip -c ${OUTPUT_FILE}.snps > ${OUTPUT_FILE}.snps.gz
# gzip -c ${OUTPUT_FILE}.haps > ${OUTPUT_FILE}.haps.gz
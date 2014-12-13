#!/bin/bash
#$ -cwd

# USE 1000GP to test always

# Inpute Parameters 
# 23andme filename
if [ -z $1 ]
then
	ME_NAME='hu500536'
else
	ME_NAME=$1
fi
# Chromosome
if [ -z $2 ]
then
	CHR=22
else
	CHR=$2
fi
# START Position
if [ -z $3 ]
then
	CHUNK_START=20.4e6
else
	CHUNK_START=$(printf "%.0f" $3)
fi
# END Position
if [ -z $4 ]
then
	CHUNK_END=20.5e6
else
	
	CHUNK_END=$(printf "%.0f" $4)
fi
# impute
sh ./impute2run.sh $CHR $CHUNK_START $CHUNK_END
#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=bowtie
#SBATCH --mem=40GB


bowtie2 -x hg19 -1 sample_R1.fq.gz -2 sample_R2.fq.gz -S sample_hg19.sam

echo "Enjoy slurm ! It's highly addictive.
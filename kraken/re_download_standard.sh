#!/bin/bash
#SBATCH --job-name=kraken_redownload_standard
#SBATCH --mem=100GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID

wget -nc -P /shared/projects/mudis4ls_is4_benchmark/BDs/kraken/standard https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20250402.tar.gz

tar -xvfz /shared/projects/mudis4ls_is4_benchmark/BDs/kraken/standard/k2_standard_20250402.tar.gz


sacct -j ${SLURM_JOB_ID} --format=JobID,JobName,Elapsed,TotalCPU,MaxRSS > slurm_stats_${SLURM_JOB_ID}.log
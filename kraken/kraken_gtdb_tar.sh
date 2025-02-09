#!/bin/bash
#SBATCH --job-name=kraken_gtdb_tar
#SBATCH --mem=400GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID
# Activer l'environnement Conda 
tar xvfz /shared/projects/mudis4ls_is4_benchmark/BDs/kraken/gtdb/k2_gtdb_genome_reps_20241109.tar.gz -C /shared/projects/mudis4ls_is4_benchmark/BDs/kraken/gtdb
sacct -j ${SLURM_JOB_ID} --format=JobID,JobName,Elapsed,TotalCPU,MaxRSS > slurm_stats_${SLURM_JOB_ID}.log

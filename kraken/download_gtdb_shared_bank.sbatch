#!/bin/bash
#SBATCH --job-name=kraken_install_db
#SBATCH --mem=500GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID


DB_DIR="/shared/bank/kraken/gtdb"


wget -nc -c -P $DB_DIR https://genome-idx.s3.amazonaws.com/kraken/k2_gtdb_genome_reps_20241109.tar.gz

tar -xzf $DB_DIR/k2_gtdb_genome_reps_20241109.tar.gz

sacct -j $SLURM_JOB_ID --format=JobID,JobName,Partition,AllocCPUs,State,ExitCode,Elapsed,NNodes,NTasks,MaxRSS > job_report_${SLURM_JOB_NAME}.txt

echo "Job finished."
#!/bin/bash
#SBATCH --job-name=metaphlan_test
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=10

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/metaphlan

# Définir les variables
fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
fastq_file="ERS12377136.fastq.gz"
fastq_file_path="${fastq_dir}${fastq_file}"

# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/re_metaphlan/"
metaphlan_output="$output_dir/profiled_metagenome.txt"
# Exécuter MetaPhlAn 
metaphlan "$fastq_file_path" --bowtie2out "$output_dir/metagenome.bowtie2.bz2" \
          --nproc "$SLURM_CPUS_PER_TASK" --input_type fastq \
          -o $metaphlan_output





sgb_to_gtdb_profile.py -i $metaphlan_output -o "$output_dir/metaphlan_output_gtdb.txt"

# Post-mapping arguments:
#   --tax_lev TAXONOMIC_LEVEL
#                         The taxonomic level for the relative abundance output:
#                         'a' : all taxonomic levels
#                         'k' : kingdoms
#                         'p' : phyla only
#                         'c' : classes only
#                         'o' : orders only
#                         'f' : families only
#                         'g' : genera only
#                         's' : species only
#                         't' : SGBs only
#                         [default 'a']

sacct -j $SLURM_JOB_ID --format=JobID,JobName,Elapsed,TotalCPU,MaxRSS,CPUTime,CPUTimeRAW > "$output_dir/logs/slurm_stats_${SLURM_JOB_NAME}.log"
#!/bin/bash
#SBATCH --job-name=meteor_fastq_mapping
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=5

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/meteor

# Définir les variables
meteor_bd_path="/shared/projects/mudis4ls_is4_benchmark/BDs/hs_10_4_gut"
# fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
# fastq_file="ERS12377136.fastq.gz"
# name="${fastq_file%.fastq.gz}"

fastq_file_path="${fastq_dir}${fastq_file}"

dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/only_one"
fastq_dir="$dir/fastq"
# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/meteor/mapping"
mkdir -p $output_dir



meteor fastq -i "$fastq_dir" \
-o "$fastq_dir"

# meteor veut dans -i le directory ou on a le fastq importe et le census8_stage.json.
#Ici dans le cas d'un fastq test le directory $fastq_dir/ERS12377136 est automatiquement crée par meteor
meteor mapping -i "$fastq_dir/ERS12377136" \
-r $meteor_bd_path \
-o $output_dir \
-t $SLURM_CPUS_PER_TASK

mamba env remove --name kraken
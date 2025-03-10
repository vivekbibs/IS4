#!/bin/bash
#SBATCH --job-name=tax_pasta_test
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=10

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/taxpasta

# Définir les variables
fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
fastq_file="ERS12377136.fastq.gz"
fastq_file_path="${fastq_dir}${fastq_file}"

# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/metaphlan"

# Exécuter MetaPhlAn 
# taxpasta merge -h
                                                                                                                                                                                    
#  Usage: taxpasta merge [OPTIONS] [PROFILE1 PROFILE2 [...]]                                                                                                                          
                                                                                                                                                                                    
#  Standardise and merge two or more taxonomic profiles.                                                                                                                              
                                                                                                                                                                                    
# ╭─ Arguments ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
# │   profiles      [PROFILE1 PROFILE2 [...]]  Two or more files containing taxonomic profiles. Required unless there is a sample sheet. Filenames will be parsed as sample names.   │
# ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
# ╭─ Options ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
# │ *  --profiler                     -p            [bracken|centrifuge|diamond|ganon|kaiju|kmcp|kraken2|krakenuniq  The taxonomic profiler used. All provided profiles must come    │
# │                                                 |megan6|metaphlan|motus]                                         from the same tool!                                             │
# │                                                                                                                  [required]                                                      │
# │    --samplesheet                  -s            FILE                                                             A table with a header and two columns: the first column named   │
# │                                                                                                                  'sample' which can be any string and the second column named    │
# │                                                                                                                  'profile' which must be a file path to an actual taxonomic      │
# │                                                                                                                  abundance profile. If this option is provided, any arguments    │
# │                                                                                                                  are ignored.                                                    │
# │                                                                                                                  [default: None]                                                 │
# │    --samplesheet-format                         [TSV|CSV|ODS|XLSX|arrow|parquet]                                 The file format of the sample sheet. Depending on the choice,   │
# │                                                                                                                  additional package dependencies may apply. Will be parsed from  │
# │                                                                                                                  the sample sheet file name but can be set explicitly.           │
# │                                                                                                                  [default: None]                                                 │
# │ *  --output                       -o            PATH                                                             The desired output file. By default, the file extension will be │
# │                                                                                                                  used to determine the output format, but when setting the       │
# │                                                                                                                  format explicitly using the --output-format option, automatic   │
# │                                                                                                                  detection is disabled.                                          │
# │                                                                                                                  [required]                                                      │
# │    --output-format                              [TSV|CSV|ODS|XLSX|arrow|parquet|BIOM]                            The desired output format. Depending on the choice, additional  │
# │                                                                                                                  package dependencies may apply. By default it will be parsed    │
# │                                                                                                                  from the output file name but it can be set explicitly and will │
# │                                                                                                                  then disable the automatic detection.                           │
# │                                                                                                                  [default: None]                                                 │
# │    --wide                             --long                                                                     Output merged abundance data in either wide or (tidy) long      │
# │                                                                                                                  format. Ignored when the desired output format is BIOM.         │
# │                                                                                                                  [default: wide]                                                 │
# │    --summarise-at,--summarize-at                TEXT                                                             Summarise abundance profiles at higher taxonomic rank. The      │
# │                                                                                                                  provided option must match a rank in the taxonomy exactly. This │
# │                                                                                                                  is akin to the clade assigned reads provided by, for example,   │
# │                                                                                                                  kraken2, where the abundances of a whole taxonomic branch are   │
# │                                                                                                                  assigned to a taxon at the desired rank. Please note that       │
# │                                                                                                                  abundances above the selected rank are simply ignored. No       │
# │                                                                                                                  attempt is made to redistribute those down to the desired rank. │
# │                                                                                                                  Some tools, like Bracken, were designed for this purpose but it │
# │                                                                                                                  doesn't seem like a problem we can generally solve here.        │
# │                                                                                                                  [default: None]                                                 │
# │    --taxonomy                                   PATH                                                             The path to a directory containing taxdump files. At least      │
# │                                                                                                                  nodes.dmp and names.dmp are required. A merged.dmp file is      │
# │                                                                                                                  optional.                                                       │
# │                                                                                                                  [default: None]                                                 │
# │    --add-name                                                                                                    Add the taxon name to the output.                               │
# │    --add-rank                                                                                                    Add the taxon rank to the output.                               │
# │    --add-lineage                                                                                                 Add the taxon's entire lineage to the output. These are taxon   │
# │                                                                                                                  names separated by semi-colons.                                 │
# │    --add-id-lineage                                                                                              Add the taxon's entire lineage to the output. These are taxon   │
# │                                                                                                                  identifiers separated by semi-colons.                           │
# │    --add-rank-lineage                                                                                            Add the taxon's entire rank lineage to the output. These are    │
# │                                                                                                                  taxon ranks separated by semi-colons.                           │
# │    --ignore-errors                                                                                               Ignore any metagenomic profiles with errors. Please note that   │
# │                                                                                                                  there must be at least two profiles without errors to merge.    │
# │    --help                         -h                                                                             Show this message and exit.                                     │
# ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
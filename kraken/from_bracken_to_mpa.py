import pandas as pd
import glob

# 📌 Définition des niveaux taxonomiques utilisés par Bracken et MetaPhlAn
taxonomy_levels = {
    "D": "d__",  # Domaine
    "P": "p__",  # Phylum
    "C": "c__",  # Classe
    "O": "o__",  # Ordre
    "F": "f__",  # Famille
    "G": "g__",  # Genre
    "S": "s__",  # Espèce
}

# 📌 Charger tous les fichiers Bracken d'un dossier
bracken_files = glob.glob("/chemin/vers/bracken_outputs/*.txt")  # Ajuste le chemin

# 📌 Dictionnaire pour stocker les taxons reconstruits
taxonomy_dict = {}

# 📌 Traitement de chaque fichier Bracken
for file in bracken_files:
    df = pd.read_csv(file, sep="\t")
    
    # Identifier le niveau taxonomique traité dans ce fichier
    tax_level = df["taxonomy_lvl"].iloc[0]  # Ex: "O" pour Ordre
    
    # Vérifier que le niveau est bien défini dans la correspondance
    if tax_level not in taxonomy_levels:
        continue

    level_prefix = taxonomy_levels[tax_level]  # Ex: "o__" pour Ordre
    
    # 📌 Construire les noms taxonomiques au format MetaPhlAn
    for _, row in df.iterrows():
        taxon_name = f"{level_prefix}{row['name']}"
        reads_fraction = row["fraction_total_reads"]

        # Si le taxon existe déjà, on ajoute les abondances
        if taxon_name in taxonomy_dict:
            taxonomy_dict[taxon_name] += reads_fraction
        else:
            taxonomy_dict[taxon_name] = reads_fraction

# 📌 Convertir le dictionnaire en DataFrame
final_df = pd.DataFrame(taxonomy_dict.items(), columns=["clade_name", "relative_abundance"])

# 📌 Ajouter l'en-tête au format MetaPhlAn
output_file = "/chemin/vers/output_bracken_metaphlan.txt"
with open(output_file, "w") as f:
    f.write("#mpa_vBracken\n#clade_name\trelative_abundance\n")
    final_df.to_csv(f, sep="\t", index=False, header=False)

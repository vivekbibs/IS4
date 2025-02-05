import pandas as pd

# Chemins des fichiers MetaPhlAn et Sylph
metaphlan_file = "metaphlan_output.tsv"
sylph_file = "sylph_output.tsv"

# Charger les fichiers en DataFrames
df_metaphlan = pd.read_csv(metaphlan_file, sep="\t", comment="#")
df_sylph = pd.read_csv(sylph_file, sep="\t", comment="#")

# Renommer la colonne relative_abundance pour chaque outil
df_metaphlan.rename(columns={"relative_abundance": "abundance_metaphlan"}, inplace=True)
df_sylph.rename(columns={"relative_abundance": "abundance_sylph"}, inplace=True)

# Fusion des deux tables sur la colonne clade_name
df_merged = pd.merge(df_metaphlan, df_sylph, on="clade_name", how="outer")

# Remplacer les valeurs NaN par 0 (si un clade est absent dans une des méthodes)
df_merged.fillna(0, inplace=True)

# Calculer la différence d'abondance entre les deux méthodes
df_merged["diff_abundance"] = df_merged["abundance_metaphlan"] - df_merged["abundance_sylph"]

# Trier par différence d'abondance (valeurs absolues)
df_merged = df_merged.sort_values(by="diff_abundance", key=abs, ascending=False)

# Sauvegarder le résultat
df_merged.to_csv("comparison_metaphlan_vs_sylph.tsv", sep="\t", index=False)

# Afficher un aperçu des plus grandes différences
print(df_merged.head(10))

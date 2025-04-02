import pandas as pd

#prend des sorties d'outils à taxonomie gtdb_207
#prend un output metaphlan4 gtdb et renvoie l'output en format cami_biobox pour l'outil de cami, OPAL
# format biobox https://github.com/bioboxes/rfc/blob/60263f34c57bc4137deeceec4c68a7f9f810f6a5/data-format/profiling.mkd  
def mpa_to_biobox(profile):
    #profile = tableau txt ou csv ou tsv peu importe : le path

    mpa_profile=pd.read_csv(
    profile, sep="\t",
    header=1
    )
    mpa_profile_species = mpa_profile[mpa_profile["#clade_name"].str.contains(r"s__.+$", na=False)]
    mpa_profile_species=mpa_profile.replace(r";", "|", regex=True)
    mpa_profile_species.rename(columns={"#clade_name":"gtdb_r220_classification"}, inplace=True)
    # gtdb_r220_classification	relative_abundance = les colonnes
    # mpa_profile_species['species'] = mpa_profile_species['gtdb_r220_classification'].str.extract(r's__([^;]+)')
    mpa_profile_species.drop(columns="level", inplace=True)
    # gtdb_mapping=pd.read_csv("/shared/projects/mudis4ls_is4_benchmark/gtdb/207_220_mapping_full.tsv", sep="\t")
    # on part du principe que tous les outils ont une taxonomie gtdb_207
    # gtdb_mapping['old_taxonomy'] = gtdb_mapping['old_taxonomy'].str.replace(';', '|', regex=False)
    # gtdb_mapping['new_taxonomy'] = gtdb_mapping['new_taxonomy'].str.replace(';', '|', regex=False)
    # metaphlan_species = pd.merge(metaphlan_species, gtdb_mapping, left_on='gtdb_r220_classification', right_on='old_taxonomy')
    # metaphlan_species.drop(columns=["old_taxonomy","gtdb_r220_classification"], inplace=True)
    # metaphlan_species.rename(columns={"new_taxonomy":"gtdb_r220_classification"}, inplace=True)
    mpa_profile_species['rank'] = 'species'
    mpa_profile_species["gtdb_ID"] = mpa_profile_species["gtdb_r220_classification"]
    mpa_profile_species["taxpath"] = mpa_profile_species["gtdb_r220_classification"]
    mpa_profile_species = mpa_profile_species[['gtdb_ID', 'rank','taxpath', 'relative_abundance']]
    mpa_profile_species.rename(columns={"gtdb_ID":"@@TAXID","rank": "RANK","taxpath": "TAXPATH","relative_abundance": "PERCENTAGE"}, inplace=True)
    new_column_order = ["@@TAXID", "RANK", "TAXPATH", "PERCENTAGE"]
    mpa_profile_species = mpa_profile_species[new_column_order]
    return mpa_profile_species

def sylph_to_biobox(profile):
    sylph_profile=pd.read_csv(profile, sep="\t", header=1)
    sylph_species=sylph_profile[sylph_profile["clade_name"].str.contains(r"s__.+$", na=False)]
    sylph_species.drop(columns=["sequence_abundance", "ANI (if strain-level)", " Coverage (if strain-level)"], inplace=True)    
    sylph_species.rename(columns={"clade_name":"gtdb_r220_classification"}, inplace=True)
    sylph_species['species'] = sylph_species['gtdb_r220_classification'].str.extract(r's__([^;]+)')
    sylph_species['rank'] = 'species'
    sylph_species["gtdb_ID"] = sylph_species["gtdb_r220_classification"]
    sylph_species["taxpath"] = sylph_species["gtdb_r220_classification"]    
    sylph_species = sylph_species[['gtdb_ID', 'rank', 'taxpath', 'relative_abundance']]
    sylph_species.rename(columns={"gtdb_ID":"@@TAXID","rank": "RANK","taxpath": "TAXPATH","relative_abundance": "PERCENTAGE"}, inplace=True)
    new_column_order = ["@@TAXID", "RANK", "TAXPATH", "PERCENTAGE"]
    sylph_species = sylph_species[new_column_order]
    return sylph_species

#prend en entrée un output bracken gtdb mais que avec les rangs espèces
def bracken_to_biobox(profile):
    bracken=pd.read_csv(profile, sep="\t")
    bracken=bracken[["name","fraction_total_reads"]]
    bracken.rename(columns={"name":"species"}, inplace=True)
    bracken['rank'] = 'species'
    bac120=pd.read_csv(
    "/shared/projects/mudis4ls_is4_benchmark/gtdb/bac120_taxonomy_r220.tsv",
    sep="\t",
    header=None
    )
    bac120.rename(columns={0: "gtdb_ID", 1: "gtdb_r220_classification"}, inplace=True)
    # Extraire les parties après g__ et s__
    # Extraire la partie après s__
    bac120['species'] = bac120['gtdb_r220_classification'].str.extract(r's__([^;]+)')
    bac120['gtdb_r220_classification'] = bac120['gtdb_r220_classification'].str.replace(';', '|', regex=False)
    ar54=pd.read_csv(
    "/shared/projects/mudis4ls_is4_benchmark/gtdb/ar53_taxonomy_r220.tsv",
    sep="\t",
    header=None
    )
    ar54.rename(columns={0: "gtdb_ID", 1: "gtdb_r220_classification"}, inplace=True)
    # Extraire les parties après g__ et s__
    # Extraire la partie après s__
    ar54['species'] = ar54['gtdb_r220_classification'].str.extract(r's__([^;]+)')
    ar54['gtdb_r220_classification'] = ar54['gtdb_r220_classification'].str.replace(';', '|', regex=False)
    ar_bac = pd.concat([bac120, ar54], ignore_index=True)
    bracken=bracken.merge(ar_bac, on="species", how="inner")
    bracken = bracken[['gtdb_r220_classification', 'rank', 'species', 'fraction_total_reads']]
    bracken['gtdb_ID'] = bracken['gtdb_r220_classification']
    bracken.rename(columns={"fraction_total_reads":"relative_abundance"}, inplace=True)
    bracken["relative_abundance"]=bracken["relative_abundance"]*100
    new_column_names=["@@TAXID", "RANK", "TAXPATHSN", "PERCENTAGE","TAXPATH"] 
    bracken.columns=new_column_names
    new_column_order = ["@@TAXID", "RANK", "TAXPATH", "TAXPATHSN", "PERCENTAGE"]
    bracken = bracken[new_column_order]
    return bracken

# def motus_to_biobox(profile):
    # problèmes dont parlait Florian : un mOTUs peut avoir plusieurs taxons associés

def meteor_to_biobox(profile):
    meteor=pd.read_csv(profile,sep="\t")
    msp_bd = pd.read_feather("/shared/projects/mudis4ls_is4_benchmark/BDs/hs_10_4_gut/database/hs_10_4_gut_1990MSPs_gtdb_r220.feather")
    msp_bd["gtdb_r220_classification"] = msp_bd["gtdb_r220_classification"].str.replace(";", "|", regex=False)
    meteor=meteor.merge(msp_bd)
    meteor=meteor[["value","gtdb_r220_classification"]]
    meteor['gtdb_ID'] = meteor['gtdb_r220_classification']
    meteor['species'] = meteor['gtdb_r220_classif
    meteor= meteor[meteor["value"] != 0]
    meteor.reset_index(drop=True)
    meteor.rename(columns={"value":"relative_abundance"}, inplace=True)
    meteor['rank'] = 'species'
    meteor = meteor[['gtdb_ID', 'rank', 'species', 'abundance']]
    meteor["relative_abundance"]=meteor["relative_abundance"]*100


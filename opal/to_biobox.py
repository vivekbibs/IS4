import pandas as pd


#prend un output metaphlan4 gtdb et renvoie l'output en format cami_biobox pour l'outil de cami, OPAL
def mpa_to_biobox(profile):
    #profile = tableau txt ou csv ou tsv peu importe : le path

    mpa_profile=pd.read_csv(
    profile, sep="\t",
    header=1
    )
    mpa_profile_species = mpa_profile[mpa_profile["#clade_name"].str.contains(r"s__.+$", na=False)]
    mpa_profile_species=mpa_profile.replace(r";", "|", regex=True)
    mpa_profile_species.rename(columns={"#clade_name":"gtdb_r220_classification"}, inplace=True)
    mpa_profile_species['rank'] = 'species'
    mpa_profile_species["gtdb_ID"] = mpa_profile_species["gtdb_r220_classification"]
    mpa_profile_species = mpa_profile_species[['gtdb_ID', 'rank', 'species', 'relative_abundance']]
    new_column_names=["@@TAXID", "RANK", "TAXPATHSN", "PERCENTAGE","TAXPATH"] 
    mpa_profile_species.columns=new_column_names
    new_column_order = ["@@TAXID", "RANK", "TAXPATH", "TAXPATHSN", "PERCENTAGE"]
    mpa_profile_species = mpa_profile_species[new_column_order]
    return mpa_profile_species

def sylph_to_biobox(profile):
    sylph_profile=pd.read_csv(profile, sep="\t", header=1)
    sylph_species=sylph_profile[sylph_profile["clade_name"].str.contains(r"s__.+$", na=False)]
    sylph_species.drop(columns=["sequence_abundance", "ANI (if strain-level)", " Coverage (if strain-level)"], inplace=True)    
    sylph_species.rename(columns={"clade_name":"gtdb_r220_classification"}, inplace=True)
    sylph_species['rank'] = 'species'
    sylph_species["gtdb_ID"] = sylph_species["gtdb_r220_classification"]
    sylph_species = sylph_species[['gtdb_ID', 'rank', 'species', 'relative_abundance']]
    new_column_names=["@@TAXID", "RANK", "TAXPATHSN", "PERCENTAGE","TAXPATH"] 
    sylph_species.columns=new_column_names
    new_column_order = ["@@TAXID", "RANK", "TAXPATH", "TAXPATHSN", "PERCENTAGE"]
    sylph_species = sylph_species[new_column_order]
    return sylph_species

#prend en entrée un output bracken gtdb mais que avec les rangs espèces
def bracken_to_biobox(profile):
    bracken=pd.read_csv(profile, sep="\t")
    bracken=bracken[["name","fraction_total_reads"]]
    bracken.rename(columns={"name":"species"}, inplace=True)
    bracken['rank'] = 'species'
    bracken = bracken[['gtdb_ID', 'rank', 'species', 'fraction_total_reads']]
    bracken.rename(columns={"fraction_total_reads":"relative_abundance"}, inplace=True)
    bracken["relative_abundance"]=bracken["relative_abundance"]*100
    new_column_names=["@@TAXID", "RANK", "TAXPATHSN", "PERCENTAGE","TAXPATH"] 
    bracken.columns=new_column_names
    new_column_order = ["@@TAXID", "RANK", "TAXPATH", "TAXPATHSN", "PERCENTAGE"]
    bracken = bracken[new_column_order]

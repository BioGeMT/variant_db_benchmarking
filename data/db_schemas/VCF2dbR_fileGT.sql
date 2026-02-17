CREATE TABLE `VEP` (
  `name` TEXT,
  `Value` TEXT
);
CREATE TABLE `fileDate` (
  `name` TEXT,
  `Value` TEXT
);
CREATE TABLE `fileformat` (
  `name` TEXT,
  `Value` TEXT
);
CREATE TABLE `reference` (
  `name` TEXT,
  `Value` TEXT
);
CREATE TABLE `source` (
  `name` TEXT,
  `Value` TEXT
);
CREATE TABLE `FILTER` (
  `name` TEXT,
  `Description` TEXT
);
CREATE TABLE `contig` (
  `name` TEXT,
  `assembly` TEXT,
  `length` TEXT
);
CREATE TABLE `ALT` (
  `name` TEXT,
  `Description` TEXT
);
CREATE TABLE `FORMAT` (
  `name` TEXT,
  `Number` TEXT,
  `Type` TEXT,
  `Description` TEXT
);
CREATE TABLE `INFO` (
  `name` TEXT,
  `Number` TEXT,
  `Type` TEXT,
  `Description` TEXT
);
CREATE TABLE `samples` (
  `name` INTEGER,
  `value` TEXT
);
CREATE TABLE `variant_impact` (
  `variant_id` INTEGER,
  `consequence` TEXT,
  `impact` TEXT,
  `symbol` TEXT,
  `gene` TEXT,
  `feature_type` TEXT,
  `feature` TEXT,
  `biotype` TEXT,
  `exon` TEXT,
  `intron` TEXT,
  `hgvsc` TEXT,
  `hgvsp` TEXT,
  `cdna_position` TEXT,
  `cds_position` TEXT,
  `protein_position` TEXT,
  `amino_acids` TEXT,
  `codons` TEXT,
  `existing_variation` TEXT,
  `distance` TEXT,
  `strand` TEXT,
  `flags` TEXT,
  `variant_class` TEXT,
  `symbol_source` TEXT,
  `hgnc_id` TEXT,
  `canonical` TEXT,
  `mane` TEXT,
  `mane_select` TEXT,
  `mane_plus_clinical` TEXT,
  `tsl` TEXT,
  `appris` TEXT,
  `ccds` TEXT,
  `ensp` TEXT,
  `swissprot` TEXT,
  `trembl` TEXT,
  `uniparc` TEXT,
  `uniprot_isoform` TEXT,
  `gene_pheno` TEXT,
  `sift` TEXT,
  `polyphen` TEXT,
  `domains` TEXT,
  `mirna` TEXT,
  `af` TEXT,
  `max_af_pops` TEXT,
  `motif_name` TEXT,
  `motif_pos` TEXT,
  `high_inf_pos` TEXT,
  `motif_score_change` TEXT,
  `transcription_factors` TEXT,
  `is_lof` INTEGER,
  `is_splicing` INTEGER,
  `is_exonic` INTEGER,
  `is_intronic` INTEGER
);
CREATE TABLE `variant_info` (
  `variant_id` INTEGER,
  `chr` TEXT,
  `start` INTEGER,
  `end` INTEGER,
  `ref` TEXT,
  `alt` TEXT,
  `qual` REAL,
  `filter` TEXT,
  `ciend` TEXT,
  `cipos` TEXT,
  `cs` TEXT,
  `imprecise` INTEGER,
  `mc` TEXT,
  `meinfo` TEXT,
  `mend` INTEGER,
  `mlen` INTEGER,
  `mstart` INTEGER,
  `svlen` TEXT,
  `svtype` TEXT,
  `tsd` TEXT,
  `ac` INTEGER,
  `af` REAL,
  `ns` INTEGER,
  `an` INTEGER,
  `eas_af` REAL,
  `eur_af` REAL,
  `afr_af` REAL,
  `amr_af` REAL,
  `sas_af` REAL,
  `dp` INTEGER,
  `aa` TEXT,
  `vt` TEXT,
  `ex_target` INTEGER,
  `multi_allelic` INTEGER,
  `old_variant` TEXT,
  `geno` TEXT
);
CREATE INDEX idx_info_variant_id ON variant_info (variant_id);
CREATE INDEX idx_impact_variant_id ON variant_impact (variant_id);
CREATE INDEX idx_impact_symbol ON variant_impact (symbol);
CREATE INDEX idx_impact_gene on variant_impact (gene);
CREATE INDEX idx_impact_consequence ON variant_impact (consequence);
CREATE INDEX idx_impact_lof ON variant_impact (is_lof);
CREATE INDEX idx_impact_exonic ON variant_impact (is_exonic);
CREATE INDEX idx_impact_splicing ON variant_impact (is_splicing);
CREATE INDEX idx_impact_biotype ON variant_impact (biotype);
CREATE INDEX idx_info_aaf ON variant_info (af);
CREATE INDEX idx_info_an ON variant_info (an);
CREATE INDEX idx_info_ac ON variant_info (ac);
CREATE TABLE `gene_map` (
  `symbol` TEXT,
  `symbol_source` TEXT,
  `gene` TEXT,
  `feature` TEXT,
  `canonical` TEXT,
  `ensp` TEXT,
  `ccds` TEXT,
  `motif_name` TEXT,
  `feature_type` TEXT
);
CREATE TABLE projects (key TEXT PRIMARY KEY, value TEXT);
CREATE TABLE metadatas (key TEXT PRIMARY KEY, value TEXT);
CREATE TABLE fields
        (id INTEGER PRIMARY KEY, name TEXT, category TEXT, type TEXT, description TEXT, UNIQUE(name, category));
CREATE TABLE variants (id INTEGER PRIMARY KEY, `chr` TEXT NOT NULL,`pos` INTEGER NOT NULL,`ref` TEXT NOT NULL,`alt` TEXT NOT NULL,`favorite` INTEGER DEFAULT 0,`comment` TEXT DEFAULT '',`classification` INTEGER DEFAULT 0,`tags` TEXT DEFAULT '',`count_hom` INTEGER DEFAULT 0,`count_het` INTEGER DEFAULT 0,`count_ref` INTEGER DEFAULT 0,`count_none` INTEGER DEFAULT 0,`count_tot` INTEGER DEFAULT 0,`count_var` INTEGER DEFAULT 0,`freq_var` REAL DEFAULT 0,`count_validation_positive` INTEGER DEFAULT 0,`count_validation_negative` INTEGER DEFAULT 0,`control_count_hom` INTEGER DEFAULT 0,`control_count_het` INTEGER DEFAULT 0,`control_count_ref` INTEGER DEFAULT 0,`case_count_hom` INTEGER DEFAULT 0,`case_count_het` INTEGER DEFAULT 0,`case_count_ref` INTEGER DEFAULT 0,`is_indel` INTEGER DEFAULT 0,`is_snp` INTEGER DEFAULT 0,`annotation_count` INTEGER DEFAULT 0,`rsid` TEXT ,`qual` INTEGER ,`filter` TEXT ,`ciend` INTEGER ,`cipos` INTEGER ,`cs` TEXT ,`end` INTEGER ,`imprecise` INTEGER ,`mc` TEXT ,`meinfo` TEXT ,`mend` INTEGER ,`mlen` INTEGER ,`mstart` INTEGER ,`svlen` INTEGER ,`svtype` TEXT ,`tsd` TEXT ,`ac` INTEGER ,`af` REAL ,`ns` INTEGER ,`an` INTEGER ,`eas_af` REAL ,`eur_af` REAL ,`afr_af` REAL ,`amr_af` REAL ,`sas_af` REAL ,`dp` INTEGER ,`aa` TEXT ,`vt` TEXT ,`ex_target` INTEGER ,`multi_allelic` INTEGER ,`old_variant` TEXT ,
        UNIQUE (chr,pos,ref,alt));
CREATE TABLE annotations (variant_id 
        INTEGER REFERENCES variants(id) ON UPDATE CASCADE,
         `allele` str,`consequence` str,`impact` str,`gene` str,`gene_id` str,`feature_type` str,`transcript` str,`biotype` str,`exon` str,`intron` str,`hgvs_c` str,`hgvs_p` str,`cdna_pos` str,`cds_pos` str,`aa_pos` str,`amino_acids` str,`codons` str,`existing_variation` str,`distance` str,`strand` str,`flags` str,`variant_class` str,`symbol_source` str,`hgnc_id` str,`canonical` str,`mane` str,`mane_select` str,`mane_plus_clinical` str,`tsl` str,`appris` str,`ccds` str,`ensp` str,`swissprot` str,`trembl` str,`uniparc` str,`uniprot_isoform` str,`gene_pheno` str,`sift` str,`polyphen` str,`domains` str,`mirna` str,`af` str,`afr_af` str,`amr_af` str,`eas_af` str,`eur_af` str,`sas_af` str,`gnomade_af` str,`gnomade_afr_af` str,`gnomade_amr_af` str,`gnomade_asj_af` str,`gnomade_eas_af` str,`gnomade_fin_af` str,`gnomade_mid_af` str,`gnomade_nfe_af` str,`gnomade_remaining_af` str,`gnomade_sas_af` str,`gnomadg_af` str,`gnomadg_afr_af` str,`gnomadg_ami_af` str,`gnomadg_amr_af` str,`gnomadg_asj_af` str,`gnomadg_eas_af` str,`gnomadg_fin_af` str,`gnomadg_mid_af` str,`gnomadg_nfe_af` str,`gnomadg_remaining_af` str,`gnomadg_sas_af` str,`max_af` str,`max_af_pops` str,`clin_sig` str,`somatic` str,`pheno` str,`pubmed` str,`motif_name` str,`motif_pos` str,`high_inf_pos` str,`motif_score_change` str,`transcription_factors` str);
CREATE TABLE samples (
        id INTEGER PRIMARY KEY ASC,
        name TEXT,
        family_id TEXT DEFAULT 'fam',
        father_id INTEGER DEFAULT 0,
        mother_id INTEGER DEFAULT 0,
        sex INTEGER DEFAULT 0,
        phenotype INTEGER DEFAULT 0,
        classification INTEGER DEFAULT 0,
        tags TEXT DEFAULT '',
        comment TEXT DEFAULT '',
        count_validation_positive_variant INTEGER DEFAULT 0,
        count_validation_negative_variant INTEGER DEFAULT 0,
        UNIQUE (name, family_id)
        );
CREATE TABLE genotypes  (
        sample_id INTEGER NOT NULL,
        variant_id INTEGER NOT NULL,
        `classification` int DEFAULT 0,`comment` str DEFAULT '',`tags` str DEFAULT '',`gt` int ,`cn` int ,`cnl` float ,`cnp` float ,`cnq` float ,`gp` float ,`gq` int ,`ft` str ,`pl` int ,
        PRIMARY KEY (sample_id, variant_id),
        FOREIGN KEY (sample_id) REFERENCES samples (id)
          ON DELETE CASCADE
          ON UPDATE NO ACTION
        );
CREATE TABLE selections (
        id INTEGER PRIMARY KEY ASC,
        name TEXT UNIQUE, count INTEGER, query TEXT, description TEXT
        );
CREATE TABLE selection_has_variant (
        variant_id INTEGER NOT NULL REFERENCES variants(id) ON DELETE CASCADE,
        selection_id INTEGER NOT NULL REFERENCES selections(id) ON DELETE CASCADE,
        PRIMARY KEY (variant_id, selection_id)
        );
CREATE TABLE wordsets (
        id INTEGER PRIMARY KEY ASC,
        name TEXT,
        value TEXT,
        UNIQUE (name, value)
        );
CREATE TABLE `history` (
        `id` INTEGER PRIMARY KEY ASC AUTOINCREMENT,
        `timestamp` TEXT DEFAULT (DATETIME('now')),
        `user` TEXT DEFAULT 'unknown',
        `table` TEXT DEFAULT '' NOT NULL,
        `table_rowid` INTEGER NOT NULL, 
        `field` TEXT DEFAULT '',
        `before` TEXT DEFAULT '',
        `after` TEXT DEFAULT '',
        UNIQUE (id)
        );
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE tags (
        id INTEGER PRIMARY KEY ASC,
        name TEXT,
        category TEXT DEFAULT 'variants',
        description TEXT,
        color TEXT DEFAULT 'red',
        UNIQUE (name, category)

        );
CREATE TRIGGER count_after_update_on_samples AFTER UPDATE ON samples
        WHEN new.phenotype <> old.phenotype
        BEGIN
            UPDATE variants
            SET 
                case_count_ref = case_count_ref + IIF( new.phenotype = 2 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=0) = 1, 1, 0 ) + IIF( old.phenotype = 2 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=0) = 1, -1, 0 ),
                
                case_count_het = case_count_het + IIF( new.phenotype = 2 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=1) = 1, 1, 0 ) + IIF( old.phenotype = 2 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=1) = 1, -1, 0 ),
                
                case_count_hom = case_count_hom + IIF( new.phenotype = 2 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=2) = 1, 1, 0 ) + IIF( old.phenotype = 2 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=2) = 1, -1, 0 ),

                control_count_ref = control_count_ref + IIF( new.phenotype = 1 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=0) = 1, 1, 0 ) + IIF( old.phenotype = 1 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=0) = 1, -1, 0 ),
                
                control_count_het = control_count_het + IIF( new.phenotype = 1 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=1) = 1, 1, 0 ) + IIF( old.phenotype = 1 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=1) = 1, -1, 0 ),
                
                control_count_hom = control_count_hom + IIF( new.phenotype = 1 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=2) = 1, 1, 0 ) + IIF( old.phenotype = 1 AND (SELECT count(shv.variant_id) FROM genotypes as shv WHERE sample_id=new.id AND variant_id=variants.id AND gt=2) = 1, -1, 0 )
                
            WHERE variants.id IN (SELECT shv2.variant_id FROM genotypes as shv2 WHERE shv2.sample_id=new.id) ;
        END;
CREATE TRIGGER count_validation_positive_negative_after_update_on_genotypes AFTER UPDATE ON genotypes
        WHEN new.classification <> old.classification
        BEGIN
            UPDATE variants
            SET count_validation_positive = (SELECT count(shv.sample_id) FROM genotypes as shv WHERE shv.variant_id=new.variant_id AND shv.classification>0), 
                count_validation_negative = (SELECT count(shv.sample_id) FROM genotypes as shv WHERE shv.variant_id=new.variant_id AND shv.classification<0)
            WHERE id=new.variant_id;
        END;
CREATE TRIGGER count_validation_positive_negative_variant_after_update_on_genotypes AFTER UPDATE ON genotypes
        WHEN new.classification <> old.classification
        BEGIN
            UPDATE samples
            SET count_validation_positive_variant = (SELECT count(shv.variant_id) FROM genotypes as shv WHERE shv.sample_id=new.sample_id AND shv.classification>0), 
                count_validation_negative_variant = (SELECT count(shv.variant_id) FROM genotypes as shv WHERE shv.sample_id=new.sample_id AND shv.classification<0)
            WHERE id = new.sample_id;
        END;
CREATE TRIGGER history_variants_favorite
                AFTER UPDATE ON variants
                WHEN old.favorite !=  new.favorite
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "variants",
                    new.rowid,
                    "favorite",
                    old.favorite,
                    new.favorite
                    ) ;
                END;
CREATE TRIGGER history_variants_classification
                AFTER UPDATE ON variants
                WHEN old.classification !=  new.classification
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "variants",
                    new.rowid,
                    "classification",
                    old.classification,
                    new.classification
                    ) ;
                END;
CREATE TRIGGER history_variants_tags
                AFTER UPDATE ON variants
                WHEN old.tags !=  new.tags
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "variants",
                    new.rowid,
                    "tags",
                    old.tags,
                    new.tags
                    ) ;
                END;
CREATE TRIGGER history_variants_comment
                AFTER UPDATE ON variants
                WHEN old.comment !=  new.comment
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "variants",
                    new.rowid,
                    "comment",
                    old.comment,
                    new.comment
                    ) ;
                END;
CREATE TRIGGER history_samples_classification
                AFTER UPDATE ON samples
                WHEN old.classification !=  new.classification
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "samples",
                    new.rowid,
                    "classification",
                    old.classification,
                    new.classification
                    ) ;
                END;
CREATE TRIGGER history_samples_tags
                AFTER UPDATE ON samples
                WHEN old.tags !=  new.tags
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "samples",
                    new.rowid,
                    "tags",
                    old.tags,
                    new.tags
                    ) ;
                END;
CREATE TRIGGER history_samples_comment
                AFTER UPDATE ON samples
                WHEN old.comment !=  new.comment
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "samples",
                    new.rowid,
                    "comment",
                    old.comment,
                    new.comment
                    ) ;
                END;
CREATE TRIGGER history_samples_family_id
                AFTER UPDATE ON samples
                WHEN old.family_id !=  new.family_id
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "samples",
                    new.rowid,
                    "family_id",
                    old.family_id,
                    new.family_id
                    ) ;
                END;
CREATE TRIGGER history_samples_father_id
                AFTER UPDATE ON samples
                WHEN old.father_id !=  new.father_id
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "samples",
                    new.rowid,
                    "father_id",
                    old.father_id,
                    new.father_id
                    ) ;
                END;
CREATE TRIGGER history_samples_mother_id
                AFTER UPDATE ON samples
                WHEN old.mother_id !=  new.mother_id
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "samples",
                    new.rowid,
                    "mother_id",
                    old.mother_id,
                    new.mother_id
                    ) ;
                END;
CREATE TRIGGER history_samples_sex
                AFTER UPDATE ON samples
                WHEN old.sex !=  new.sex
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "samples",
                    new.rowid,
                    "sex",
                    old.sex,
                    new.sex
                    ) ;
                END;
CREATE TRIGGER history_samples_phenotype
                AFTER UPDATE ON samples
                WHEN old.phenotype !=  new.phenotype
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "samples",
                    new.rowid,
                    "phenotype",
                    old.phenotype,
                    new.phenotype
                    ) ;
                END;
CREATE TRIGGER history_genotypes_classification
                AFTER UPDATE ON genotypes
                WHEN old.classification !=  new.classification
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "genotypes",
                    new.rowid,
                    "classification",
                    old.classification,
                    new.classification
                    ) ;
                END;
CREATE TRIGGER history_genotypes_tags
                AFTER UPDATE ON genotypes
                WHEN old.tags !=  new.tags
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "genotypes",
                    new.rowid,
                    "tags",
                    old.tags,
                    new.tags
                    ) ;
                END;
CREATE TRIGGER history_genotypes_comment
                AFTER UPDATE ON genotypes
                WHEN old.comment !=  new.comment
                BEGIN
                    INSERT INTO history (
                        `user`,
                        `table`,
                        `table_rowid`,
                        `field`,
                        `before`,
                        `after`
                    )
                VALUES
                    (
                    current_user(),
                    "genotypes",
                    new.rowid,
                    "comment",
                    old.comment,
                    new.comment
                    ) ;
                END;
CREATE INDEX `idx_annotations` ON annotations (`variant_id`);
CREATE UNIQUE INDEX idx_selections ON selections (name);
CREATE INDEX `idx_genotypes` ON genotypes (`variant_id`, `sample_id`);
CREATE INDEX `idx_genotypes_sample_id` ON genotypes (`sample_id`);
CREATE INDEX `idx_genotypes_variant_id` ON genotypes (`variant_id`);
CREATE INDEX `idx_genotypes_gt` ON genotypes (`gt`);
CREATE INDEX `idx_genotypes_classification` ON genotypes (`classification`);
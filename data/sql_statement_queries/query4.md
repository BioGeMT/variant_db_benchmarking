# Query4
## Description
Test genotype data retrieval and sample filtering

## vcf2db
```sql
SELECT s.sample_name, v.chromosome, v.position,
a.alt, g.genotype_hr
FROM samples s
JOIN genotypes g ON s.id = g.sample_id
JOIN alts a ON g.alt_id = a.id
JOIN variants_partitioned v ON a.variant_id = v.id
WHERE v.chromosome = '17'
AND v.position BETWEEN 41000000 AND 42000000;
```

## VCF2dbR tableGT
```sql
SELECT vg.sample AS sample_name, vi.chr AS chromosome, vi.start AS position,
vi.alt, vg.gt_raw AS genotype_hr
FROM variant_geno vg
JOIN variant_info vi ON vg.variant_id = vi.variant_id
WHERE vi.chr = '17'
AND vi.start BETWEEN 41000000 AND 42000000
AND vi.alt NOT LIKE '<INS:ME:%>';
```

## VCF2dbR fileGT
```R
library(DBI)
library(RSQLite)

get_genotypes_in_region <- function(db_path, chr = '17', start_pos = 41000000, end_pos = 42000000) {
  con <- dbConnect(RSQLite::SQLite(), db_path)
  
  variants_query <- "
    SELECT variant_id, chr, start, alt, geno
    FROM variant_info
    WHERE chr = ?
    AND start BETWEEN ? AND ?
    AND alt NOT LIKE '<INS:ME:%>'
  "
  
  variants_df <- dbGetQuery(con, variants_query, params = list(chr, start_pos, end_pos))
  
  results_list <- lapply(1:nrow(variants_df), function(i) {
    variant <- variants_df[i, ]
    geno_file <- as.character(variant$geno)
    
    if (!is.na(geno_file) && geno_file != "" && file.exists(geno_file)) {
      tryCatch({
        geno_data <- readRDS(geno_file)
        data.frame(
          sample_name = geno_data[, "sample"],
          chromosome = variant$chr,
          position = variant$start,
          alt = variant$alt,
          genotype_hr = geno_data[, "gt_raw"],
          stringsAsFactors = FALSE
        )
      }, error = function(e) NULL)
    } else {
      NULL
    }
  })
  
  dbDisconnect(con)
  
  results_list <- Filter(Negate(is.null), results_list)
  
  if (length(results_list) > 0) {
    do.call(rbind, results_list)
  } else {
    data.frame(
      sample_name = character(),
      chromosome = character(),
      position = integer(),
      alt = character(),
      genotype_hr = character()
    )
  }
}

results <- get_genotypes_in_region(
  'VCFdbR/variant_database_filegt.db',
  chr = '17',
  start_pos = 41000000,
  end_pos = 42000000
)
```

## cutevariant
```sql
SELECT s.name AS sample_name, v.chr AS chromosome, v.pos AS position,
v.alt, 
CASE 
  WHEN g.gt = 0 THEN '0/0'
  WHEN g.gt = 1 THEN '0/1'
  WHEN g.gt = 2 THEN '1/1'
  ELSE 'unknown'
END AS genotype_hr
FROM samples s
JOIN genotypes g ON s.id = g.sample_id
JOIN variants v ON g.variant_id = v.id
WHERE v.chr = '17'
AND v.pos BETWEEN 41000000 AND 42000000;
```

## vcf-miner
```mongo
db.variants.aggregate([
  {
    $match: {
      "CHROM": "5",
      "POS": { $gte: 41000000, $lte: 42000000 }
    }
  },
  {
    $project: {
      chromosome: "$CHROM",
      position: "$POS",
      alt: "$ALT",
      het_samples: { $ifNull: ["$FORMAT.HeterozygousList", []] },
      hom_samples: { $ifNull: ["$FORMAT.HomozygousList", []] },
      ref_samples: { $ifNull: ["$FORMAT.WildtypeList", []] },
      _id: 0
    }
  }
])
```
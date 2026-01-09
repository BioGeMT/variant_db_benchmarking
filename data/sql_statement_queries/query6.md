# Query6
## Description
Find the top 50 protein-coding genes with the most variants, showing how many variants and alternate alleles each gene has, along with average quality and a list of all the alternate alleles observed.

## vcf2db
```sql
SELECT ann.symbol as gene_name,
       v.chromosome,
       COUNT(DISTINCT v.id) as variant_count,
       COUNT(DISTINCT a.id) as allele_count,
       AVG(v.quality) as avg_quality,
       STRING_AGG(DISTINCT a.alt, ', ' ORDER BY a.alt) as observed_alts
FROM variants_partitioned v
JOIN alts a ON v.chromosome = a.variant_chromosome 
  AND v.position = a.variant_position 
  AND v.id = a.variant_id
JOIN variant_annotations va ON va.alt_id = a.id
JOIN annotations ann ON ann.id = va.annotation_id
WHERE ann.symbol IS NOT NULL
  AND ann.symbol != ''
  AND ann.biotype = 'protein_coding'
GROUP BY ann.symbol, v.chromosome
HAVING COUNT(DISTINCT v.id) > 5
ORDER BY variant_count DESC
LIMIT 50;
```

## VCFdbR fileGT & VCFdbR tableGT
```sql
SELECT vim.symbol as gene_name,
       vi.chr as chromosome,
       COUNT(DISTINCT vi.variant_id) as variant_count,
       COUNT(DISTINCT vi.variant_id || '-' || vi.alt) as allele_count,
       AVG(vi.qual) as avg_quality,
       GROUP_CONCAT(DISTINCT vi.alt) as observed_alts
FROM variant_info vi
JOIN variant_impact vim ON vi.variant_id = vim.variant_id
WHERE vim.symbol IS NOT NULL
  AND vim.symbol != ''
  AND vim.biotype = 'protein_coding'
GROUP BY vim.symbol, vi.chr
HAVING COUNT(DISTINCT vi.variant_id) > 5
ORDER BY variant_count DESC
LIMIT 50;
```

## cutevariant
```sql
SELECT ann.gene as gene_name,
       v.chr as chromosome,
       COUNT(DISTINCT v.id) as variant_count,
       COUNT(DISTINCT v.id || '-' || v.alt) as allele_count,
       AVG(v.qual) as avg_quality,
       GROUP_CONCAT(DISTINCT v.alt) as observed_alts
FROM variants v
JOIN annotations ann ON ann.variant_id = v.id
WHERE ann.gene IS NOT NULL
  AND ann.gene != ''
  AND ann.biotype = 'protein_coding'
GROUP BY ann.gene, v.chr
HAVING COUNT(DISTINCT v.id) > 5
ORDER BY variant_count DESC
LIMIT 50;
```

## vcf-miner
For the gene-based variant aggregation query, we encountered a technical limitation with VCF-Miner running on MongoDB version 3.0.3. This query required parsing the pipe-delimited CSQ (Consequence) annotation field to extract gene names and biotype information. MongoDB versions prior to 3.4 lack the $split operator necessary for efficient string parsing within aggregation pipelines. While workarounds exist using iterative $substr and $indexOfBytes operations, these approaches result in extremely verbose queries with poor performance characteristics, making them impractical for large-scale genomic datasets.
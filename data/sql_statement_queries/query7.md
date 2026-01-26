# Query 7

## Description
For each chromosome, give a summary of how many variants have annotation data, how many total annotation records exist, and what's the average quality score.

## vcf2db
```sql
WITH unique_variants AS (
  SELECT DISTINCT 
    v.id, 
    v.chromosome, 
    v.position,
    v.quality
  FROM variants_partitioned v
),
variant_annotations_summary AS (
  SELECT 
    uv.id,
    uv.chromosome,
    uv.quality,
    COUNT(DISTINCT va.annotation_id) as annotation_count,
    CASE WHEN COUNT(va.annotation_id) > 0 THEN 1 ELSE 0 END as has_annotations
  FROM unique_variants uv
  LEFT JOIN alts a ON a.variant_id = uv.id 
                   AND a.variant_chromosome = uv.chromosome 
                   AND a.variant_position = uv.position
  LEFT JOIN variant_annotations va ON va.alt_id = a.id
  GROUP BY uv.id, uv.chromosome, uv.quality
)
SELECT 
  chromosome, 
  COUNT(id) as total_variants,
  SUM(has_annotations) as variants_with_annotations,
  SUM(annotation_count) as total_annotation_records,
  AVG(quality) as avg_quality
FROM variant_annotations_summary
GROUP BY chromosome
ORDER BY chromosome;
```

## VCF2dbR fileGT
```sql
SELECT vi.chr,
       COUNT(DISTINCT vi.variant_id) as total_variants,
       COUNT(DISTINCT vim.variant_id) as variants_with_annotations,
       COUNT(vim.variant_id) as total_annotation_records,
       AVG(vi.qual) as avg_quality
FROM variant_info vi
LEFT JOIN variant_impact vim ON vi.variant_id = vim.variant_id
GROUP BY vi.chr         
ORDER BY vi.chr;
```


## VCF2dbR tableGT
```sql
SELECT vi.chr,
       COUNT(DISTINCT vi.variant_id) as total_variants,
       COUNT(DISTINCT vim.variant_id) as variants_with_annotations,
       COUNT(vim.variant_id) as total_annotation_records,
       AVG(vi.qual) as avg_quality
FROM variant_info vi
LEFT JOIN variant_impact vim ON vi.variant_id = vim.variant_id
GROUP BY vi.chr         
ORDER BY vi.chr;
```

## cutevariant
```sql
SELECT chr,
       COUNT(id) as total_variants,
       SUM(CASE WHEN annotation_count > 0 THEN 1 ELSE 0 END) as variants_with_annotations,
       SUM(annotation_count) as total_annotation_records,
       AVG(qual) as avg_quality
FROM variants
GROUP BY chr
ORDER BY chr;
```

## vcf-miner
```mongo
db.getCollection('variants').aggregate([
    {
        $match: {
            _type: "variant"
        }
    },
    {
        $project: {
            CHROM: 1,
            QUAL: 1,
            has_csq: { $ifNull: ["$INFO.CSQ", null] },
            csq_size: { $size: { $ifNull: ["$INFO.CSQ", []] } }
        }
    },
    {
        $project: {
            CHROM: 1,
            QUAL: 1,
            has_annotations: {
                $cond: [
                    { $gt: ["$csq_size", 0] },
                    1,
                    0
                ]
            },
            annotation_count: "$csq_size"
        }
    },
    {
        $group: {
            _id: "$CHROM",
            total_variants: { $sum: 1 },
            variants_with_annotations: { $sum: "$has_annotations" },
            total_annotation_records: { $sum: "$annotation_count" },
            total_quality: { $sum: "$QUAL" },
            count_quality: { $sum: 1 }
        }
    },
    {
        $project: {
            chromosome: "$_id",
            total_variants: 1,
            variants_with_annotations: 1,
            total_annotation_records: 1,
            avg_quality: { $divide: ["$total_quality", "$count_quality"] }
        }
    },
    {
        $sort: { chromosome: 1 }
    }
], { allowDiskUse: true });
```
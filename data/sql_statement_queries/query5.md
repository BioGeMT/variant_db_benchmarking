# Query5
## Description
Identify multi-allelic variants (positions where more than one alternative allele exists) that pass a quality threshold. This result of this will depend on whether our file has them although it is quite normal to have multi-allelic variants.

## vcf2db
```sql
SELECT v.chromosome, v.position, v.ref, v.quality, COUNT(a.alt) as alt_count
FROM variants_partitioned v
JOIN alts a ON v.chromosome = a.variant_chromosome 
  AND v.position = a.variant_position 
  AND v.id = a.variant_id
WHERE v.quality > 20
GROUP BY v.chromosome, v.position, v.ref, v.quality
HAVING COUNT(a.alt) > 1
ORDER BY v.chromosome, v.position;
```
## VCFdbR fileGT & VCFdbR tableGT
```sql
SELECT chr, start, ref
FROM variant_info
WHERE qual > 20
GROUP BY chr, start, ref
HAVING COUNT(*) > 1
ORDER BY chr, start;
```

## cutevariant
```sql
SELECT chr, pos, ref
FROM variants
WHERE qual > 20
GROUP BY chr, pos, ref
HAVING COUNT(*) > 1
ORDER BY chr, pos;
```

## vcf-miner
```mongo
db.getCollection('variants').aggregate([
    {
        $match: {
            QUAL: { $gt: 20 },
            _type: "variant"
        }
    },
    {
        $group: {
            _id: {
                chr: "$CHROM",
                pos: "$POS",
                ref: "$REF"
            },
            count: { $sum: 1 }
        }
    },
    {
        $match: {
            count: { $gt: 1 }
        }
    },
    {
        $sort: { "_id.chr": 1, "_id.pos": 1 }
    }
], { allowDiskUse: true });
```
# Query1

## Description
Test basic variant retrieval and indexing efficiency


## vcf2db
```sql
SELECT v.chromosome, v.position, v.ref, a.alt
FROM variants_partitioned v
JOIN alts a ON v.id = a.variant_id
WHERE v.chromosome = '1'
AND v.position BETWEEN 100000 AND 200000;
```

## VCF2dbR fileGT
```sql
SELECT chr AS chromosome, start AS position, ref, alt
FROM variant_info
WHERE chr = '1'
AND start BETWEEN 100000 AND 200000;
```

## VCF2dbR tableGT
```sql
SELECT chr AS chromosome, start AS position, ref, alt
FROM variant_info
WHERE chr = '1'
AND start BETWEEN 100000 AND 200000;
```

## cutevariant
```sql
SELECT chr AS chromosome, pos AS position, ref, alt
FROM variants
WHERE chr = '1'
AND pos BETWEEN 100000 AND 200000;
```

## vcf-miner
```mongo
db.variants.find(
  {
    "CHROM": "1",
    "POS": { $gte: 100000, $lte: 200000 }
  },
  {
    "CHROM": 1,
    "POS": 1, 
    "REF": 1,
    "ALT": 1,
    "_id": 0
  }
).explain("executionStats")
```
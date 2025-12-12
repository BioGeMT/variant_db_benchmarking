# Query2
## Description
Test gene annotation joins and filtering

## vcf2db
```sql
SELECT DISTINCT v.chromosome, v.position, v.ref, a.alt, ann.symbol, ann.consequence
FROM variants_partitioned v
JOIN alts a ON v.id = a.variant_id
JOIN variant_annotations va ON a.id = va.alt_id
JOIN annotations ann ON va.annotation_id= ann.id
WHERE ann.symbol = 'BRCA1'
AND ann.consequence = 'missense_variant';
```

## VCFdbR tableGT
```sql
SELECT DISTINCT vi.chr AS chromosome, vi.start AS position, vi.ref, vi.alt, vim.symbol, vim.consequence
FROM variant_info vi
JOIN variant_impact vim ON vi.variant_id = vim.variant_id
WHERE vim.symbol = 'BRCA1'
AND vim.consequence = 'missense_variant';
```

## VCFdbR fileGT
```sql
SELECT DISTINCT vi.chr AS chromosome, vi.start AS position, vi.ref, vi.alt, vim.symbol, vim.consequence
FROM variant_info vi
JOIN variant_impact vim ON vi.variant_id = vim.variant_id
WHERE vim.symbol = 'BRCA1'
AND vim.consequence = 'missense_variant';
```

## cutevariant
```sql
SELECT DISTINCT v.chr AS chromosome, v.pos AS position, v.ref, v.alt, a.gene AS symbol, a.consequence
FROM variants v
JOIN annotations a ON v.id = a.variant_id
WHERE a.gene = 'BRCA1'
AND a.consequence = 'missense_variant';
```

## vcf-miner
```mongo
db.variants.find({
  $where: function() {
    return this.INFO.CSQ.some(function(entry) {
      var fields = entry.split('|');
      return fields[3] === 'BRCA1' && fields[1] === 'missense_variant';
    });
  }
}, {
  "CHROM": 1,
  "POS": 1, 
  "REF": 1,
  "ALT": 1,
  "INFO.CSQ": 1,
  "_id": 0
})
```
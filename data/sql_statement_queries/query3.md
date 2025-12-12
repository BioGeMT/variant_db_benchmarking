# Query3
## Description
Test numeric filtering on annotation data

## vcf2db
```sql
SELECT v.chromosome, v.position, v.ref, a.alt,
ann.af, ann.consequence, ann.symbol
FROM variants_partitioned v
JOIN alts a ON v.id = a.variant_id
JOIN variant_annotations va ON a.id = va.alt_id
JOIN annotations ann ON va.annotation_id = ann.id
WHERE CAST(NULLIF(SPLIT_PART(ann.af, '&', 1), '') AS FLOAT) < 0.01
AND ann.impact = 'HIGH'
AND v.chromosome IN ('1', '2', '3');
```
## VCFdbR fileGT & VCFdbR tableGT
```sql
SELECT vi.chr AS chromosome, vi.start AS position, vi.ref, vi.alt,
vim.af, vim.consequence, vim.symbol
FROM variant_info vi
JOIN variant_impact vim ON vi.variant_id = vim.variant_id
WHERE CAST(NULLIF(vim.af, '') AS FLOAT) < 0.01
AND vim.impact = 'HIGH'
AND vi.chr IN ('1', '2', '3');
```
## cutevariant
```sql
SELECT v.chr AS chromosome, v.pos AS position, v.ref, v.alt,
a.af, a.consequence, a.gene AS symbol
FROM variants v
JOIN annotations a ON v.id = a.variant_id
WHERE CAST(NULLIF(a.af, '') AS FLOAT) < 0.01
AND a.impact = 'HIGH'
AND v.chr IN ('1', '2', '3');
```

## vcf-miner
```mongo
var results = [];
db.variants.find({
  "CHROM": { $in: ["1", "2", "3"] }
}).forEach(function(doc) {
  if (doc.INFO && doc.INFO.CSQ) {
    doc.INFO.CSQ.forEach(function(csq) {
      var fields = csq.split('|');
      var af = parseFloat(fields[41]);
      var impact = fields[2];
      var symbol = fields[3];
      var consequence = fields[1];
      
      if (!isNaN(af) && af < 0.01 && impact === 'HIGH') {
        results.push({
          chromosome: doc.CHROM,
          position: doc.POS,
          ref: doc.REF,
          alt: doc.ALT,
          af: af,
          consequence: consequence,
          symbol: symbol
        });
      }
    });
  }
});
```
--
-- PostgreSQL database dump
--
-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 18.0 (Ubuntu 18.0-1.pgdg24.04+3)

CREATE TABLE public.alts (
    id integer NOT NULL,
    variant_chromosome character varying(25) NOT NULL,
    variant_position integer NOT NULL,
    variant_id integer NOT NULL,
    alt text NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 24079)
-- Name: alts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3823 (class 0 OID 0)
-- Dependencies: 247
-- Name: alts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alts_id_seq OWNED BY public.alts.id;


--
-- TOC entry 250 (class 1259 OID 24172)
-- Name: annotations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.annotations (
    id integer NOT NULL,
    allele text,
    consequence text,
    impact text,
    symbol text,
    gene text,
    feature_type text,
    feature text,
    biotype text,
    exon text,
    intron text,
    hgvsc text,
    hgvsp text,
    cdna_position text,
    cds_position text,
    protein_position text,
    amino_acids text,
    codons text,
    existing_variation text,
    distance text,
    strand text,
    flags text,
    variant_class text,
    symbol_source text,
    hgnc_id text,
    canonical text,
    mane text,
    mane_select text,
    mane_plus_clinical text,
    tsl text,
    appris text,
    ccds text,
    ensp text,
    swissprot text,
    trembl text,
    uniparc text,
    uniprot_isoform text,
    gene_pheno text,
    sift text,
    polyphen text,
    domains text,
    mirna text,
    af text,
    afr_af text,
    amr_af text,
    eas_af text,
    eur_af text,
    sas_af text,
    gnomade_af text,
    gnomade_afr_af text,
    gnomade_amr_af text,
    gnomade_asj_af text,
    gnomade_eas_af text,
    gnomade_fin_af text,
    gnomade_mid_af text,
    gnomade_nfe_af text,
    gnomade_remaining_af text,
    gnomade_sas_af text,
    gnomadg_af text,
    gnomadg_afr_af text,
    gnomadg_ami_af text,
    gnomadg_amr_af text,
    gnomadg_asj_af text,
    gnomadg_eas_af text,
    gnomadg_fin_af text,
    gnomadg_mid_af text,
    gnomadg_nfe_af text,
    gnomadg_remaining_af text,
    gnomadg_sas_af text,
    max_af text,
    max_af_pops text,
    clin_sig text,
    somatic text,
    pheno text,
    pubmed text,
    motif_name text,
    motif_pos text,
    high_inf_pos text,
    motif_score_change text,
    transcription_factors text
);


--
-- TOC entry 249 (class 1259 OID 24171)
-- Name: annotations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.annotations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3824 (class 0 OID 0)
-- Dependencies: 249
-- Name: annotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.annotations_id_seq OWNED BY public.annotations.id;


--
-- TOC entry 254 (class 1259 OID 24198)
-- Name: genotypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genotypes (
    id bigint NOT NULL,
    alt_id integer NOT NULL,
    sample_id integer NOT NULL,
    genotype character varying(255),
    genotype_hr character varying(255),
    is_phased boolean NOT NULL,
    dp integer,
    gq integer,
    ad jsonb,
    pl jsonb
);


--
-- TOC entry 253 (class 1259 OID 24197)
-- Name: genotypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.genotypes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3825 (class 0 OID 0)
-- Dependencies: 253
-- Name: genotypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.genotypes_id_seq OWNED BY public.genotypes.id;


--
-- TOC entry 218 (class 1259 OID 23860)
-- Name: sample_class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sample_class (
    id integer NOT NULL,
    grp_class character varying(50) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 23859)
-- Name: sample_class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sample_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3826 (class 0 OID 0)
-- Dependencies: 217
-- Name: sample_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sample_class_id_seq OWNED BY public.sample_class.id;


--
-- TOC entry 256 (class 1259 OID 24217)
-- Name: sample_relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sample_relationships (
    id integer NOT NULL,
    sample_id1 integer NOT NULL,
    sample_id2 integer NOT NULL,
    relationship character varying(255) NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 24216)
-- Name: sample_relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sample_relationships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3827 (class 0 OID 0)
-- Dependencies: 255
-- Name: sample_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sample_relationships_id_seq OWNED BY public.sample_relationships.id;


--
-- TOC entry 216 (class 1259 OID 23850)
-- Name: samples; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.samples (
    id integer NOT NULL,
    sample_name character varying(255) NOT NULL,
    sample_grp integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 23849)
-- Name: samples_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.samples_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3828 (class 0 OID 0)
-- Dependencies: 215
-- Name: samples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.samples_id_seq OWNED BY public.samples.id;


--
-- TOC entry 252 (class 1259 OID 24181)
-- Name: variant_annotations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variant_annotations (
    id integer NOT NULL,
    alt_id integer NOT NULL,
    annotation_id integer NOT NULL
);


--
-- TOC entry 251 (class 1259 OID 24180)
-- Name: variant_annotations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variant_annotations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3829 (class 0 OID 0)
-- Dependencies: 251
-- Name: variant_annotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variant_annotations_id_seq OWNED BY public.variant_annotations.id;


--
-- TOC entry 220 (class 1259 OID 23865)
-- Name: variants_partitioned; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_partitioned (
    id integer NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
)
PARTITION BY LIST (chromosome);


--
-- TOC entry 219 (class 1259 OID 23864)
-- Name: variants_partitioned_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variants_partitioned_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3830 (class 0 OID 0)
-- Dependencies: 219
-- Name: variants_partitioned_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variants_partitioned_id_seq OWNED BY public.variants_partitioned.id;


--
-- TOC entry 221 (class 1259 OID 23871)
-- Name: variants_chr1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr1 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 230 (class 1259 OID 23943)
-- Name: variants_chr10; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr10 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 231 (class 1259 OID 23951)
-- Name: variants_chr11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr11 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 232 (class 1259 OID 23959)
-- Name: variants_chr12; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr12 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 233 (class 1259 OID 23967)
-- Name: variants_chr13; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr13 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 234 (class 1259 OID 23975)
-- Name: variants_chr14; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr14 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 235 (class 1259 OID 23983)
-- Name: variants_chr15; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr15 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 236 (class 1259 OID 23991)
-- Name: variants_chr16; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr16 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 237 (class 1259 OID 23999)
-- Name: variants_chr17; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr17 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 238 (class 1259 OID 24007)
-- Name: variants_chr18; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr18 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 239 (class 1259 OID 24015)
-- Name: variants_chr19; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr19 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 222 (class 1259 OID 23879)
-- Name: variants_chr2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr2 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 240 (class 1259 OID 24023)
-- Name: variants_chr20; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr20 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 241 (class 1259 OID 24031)
-- Name: variants_chr21; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr21 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 242 (class 1259 OID 24039)
-- Name: variants_chr22; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr22 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 223 (class 1259 OID 23887)
-- Name: variants_chr3; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr3 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 224 (class 1259 OID 23895)
-- Name: variants_chr4; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr4 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 225 (class 1259 OID 23903)
-- Name: variants_chr5; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr5 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 226 (class 1259 OID 23911)
-- Name: variants_chr6; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr6 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 227 (class 1259 OID 23919)
-- Name: variants_chr7; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr7 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 228 (class 1259 OID 23927)
-- Name: variants_chr8; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr8 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 229 (class 1259 OID 23935)
-- Name: variants_chr9; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chr9 (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 245 (class 1259 OID 24063)
-- Name: variants_chrm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chrm (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 243 (class 1259 OID 24047)
-- Name: variants_chrx; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chrx (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 244 (class 1259 OID 24055)
-- Name: variants_chry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_chry (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 246 (class 1259 OID 24071)
-- Name: variants_default; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variants_default (
    id integer DEFAULT nextval('public.variants_partitioned_id_seq'::regclass) NOT NULL,
    chromosome character varying(25) NOT NULL,
    "position" integer NOT NULL,
    ref text NOT NULL,
    quality double precision,
    filter character varying(255)
);


--
-- TOC entry 3389 (class 0 OID 0)
-- Name: variants_chr1; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr1 FOR VALUES IN ('chr1', '1');


--
-- TOC entry 3398 (class 0 OID 0)
-- Name: variants_chr10; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr10 FOR VALUES IN ('chr10', '10');


--
-- TOC entry 3399 (class 0 OID 0)
-- Name: variants_chr11; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr11 FOR VALUES IN ('chr11', '11');


--
-- TOC entry 3400 (class 0 OID 0)
-- Name: variants_chr12; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr12 FOR VALUES IN ('chr12', '12');


--
-- TOC entry 3401 (class 0 OID 0)
-- Name: variants_chr13; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr13 FOR VALUES IN ('chr13', '13');


--
-- TOC entry 3402 (class 0 OID 0)
-- Name: variants_chr14; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr14 FOR VALUES IN ('chr14', '14');


--
-- TOC entry 3403 (class 0 OID 0)
-- Name: variants_chr15; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr15 FOR VALUES IN ('chr15', '15');


--
-- TOC entry 3404 (class 0 OID 0)
-- Name: variants_chr16; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr16 FOR VALUES IN ('chr16', '16');


--
-- TOC entry 3405 (class 0 OID 0)
-- Name: variants_chr17; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr17 FOR VALUES IN ('chr17', '17');


--
-- TOC entry 3406 (class 0 OID 0)
-- Name: variants_chr18; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr18 FOR VALUES IN ('chr18', '18');


--
-- TOC entry 3407 (class 0 OID 0)
-- Name: variants_chr19; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr19 FOR VALUES IN ('chr19', '19');


--
-- TOC entry 3390 (class 0 OID 0)
-- Name: variants_chr2; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr2 FOR VALUES IN ('chr2', '2');


--
-- TOC entry 3408 (class 0 OID 0)
-- Name: variants_chr20; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr20 FOR VALUES IN ('chr20', '20');


--
-- TOC entry 3409 (class 0 OID 0)
-- Name: variants_chr21; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr21 FOR VALUES IN ('chr21', '21');


--
-- TOC entry 3410 (class 0 OID 0)
-- Name: variants_chr22; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr22 FOR VALUES IN ('chr22', '22');


--
-- TOC entry 3391 (class 0 OID 0)
-- Name: variants_chr3; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr3 FOR VALUES IN ('chr3', '3');


--
-- TOC entry 3392 (class 0 OID 0)
-- Name: variants_chr4; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr4 FOR VALUES IN ('chr4', '4');


--
-- TOC entry 3393 (class 0 OID 0)
-- Name: variants_chr5; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr5 FOR VALUES IN ('chr5', '5');


--
-- TOC entry 3394 (class 0 OID 0)
-- Name: variants_chr6; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr6 FOR VALUES IN ('chr6', '6');


--
-- TOC entry 3395 (class 0 OID 0)
-- Name: variants_chr7; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr7 FOR VALUES IN ('chr7', '7');


--
-- TOC entry 3396 (class 0 OID 0)
-- Name: variants_chr8; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr8 FOR VALUES IN ('chr8', '8');


--
-- TOC entry 3397 (class 0 OID 0)
-- Name: variants_chr9; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chr9 FOR VALUES IN ('chr9', '9');


--
-- TOC entry 3413 (class 0 OID 0)
-- Name: variants_chrm; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chrm FOR VALUES IN ('chrM', 'M');


--
-- TOC entry 3411 (class 0 OID 0)
-- Name: variants_chrx; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chrx FOR VALUES IN ('chrX', 'X');


--
-- TOC entry 3412 (class 0 OID 0)
-- Name: variants_chry; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_chry FOR VALUES IN ('chrY', 'Y');


--
-- TOC entry 3414 (class 0 OID 0)
-- Name: variants_default; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ATTACH PARTITION public.variants_default DEFAULT;


--
-- TOC entry 3445 (class 2604 OID 24083)
-- Name: alts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alts ALTER COLUMN id SET DEFAULT nextval('public.alts_id_seq'::regclass);


--
-- TOC entry 3446 (class 2604 OID 24175)
-- Name: annotations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annotations ALTER COLUMN id SET DEFAULT nextval('public.annotations_id_seq'::regclass);


--
-- TOC entry 3448 (class 2604 OID 24201)
-- Name: genotypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genotypes ALTER COLUMN id SET DEFAULT nextval('public.genotypes_id_seq'::regclass);


--
-- TOC entry 3417 (class 2604 OID 23863)
-- Name: sample_class id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_class ALTER COLUMN id SET DEFAULT nextval('public.sample_class_id_seq'::regclass);


--
-- TOC entry 3449 (class 2604 OID 24220)
-- Name: sample_relationships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_relationships ALTER COLUMN id SET DEFAULT nextval('public.sample_relationships_id_seq'::regclass);


--
-- TOC entry 3415 (class 2604 OID 23853)
-- Name: samples id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.samples ALTER COLUMN id SET DEFAULT nextval('public.samples_id_seq'::regclass);


--
-- TOC entry 3447 (class 2604 OID 24184)
-- Name: variant_annotations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_annotations ALTER COLUMN id SET DEFAULT nextval('public.variant_annotations_id_seq'::regclass);


--
-- TOC entry 3418 (class 2604 OID 23868)
-- Name: variants_partitioned id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned ALTER COLUMN id SET DEFAULT nextval('public.variants_partitioned_id_seq'::regclass);


--
-- TOC entry 3565 (class 2606 OID 24087)
-- Name: alts alts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alts
    ADD CONSTRAINT alts_pkey PRIMARY KEY (id);


--
-- TOC entry 3571 (class 2606 OID 24179)
-- Name: annotations annotations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annotations
    ADD CONSTRAINT annotations_pkey PRIMARY KEY (id);


--
-- TOC entry 3579 (class 2606 OID 24205)
-- Name: genotypes genotypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genotypes
    ADD CONSTRAINT genotypes_pkey PRIMARY KEY (id);


--
-- TOC entry 3587 (class 2606 OID 24222)
-- Name: sample_relationships sample_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_relationships
    ADD CONSTRAINT sample_relationships_pkey PRIMARY KEY (id);


--
-- TOC entry 3589 (class 2606 OID 24224)
-- Name: sample_relationships sample_relationships_sample_id1_sample_id2_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_relationships
    ADD CONSTRAINT sample_relationships_sample_id1_sample_id2_key UNIQUE (sample_id1, sample_id2);


--
-- TOC entry 3452 (class 2606 OID 23856)
-- Name: samples samples_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.samples
    ADD CONSTRAINT samples_pkey PRIMARY KEY (id);


--
-- TOC entry 3454 (class 2606 OID 23858)
-- Name: samples samples_sample_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.samples
    ADD CONSTRAINT samples_sample_name_key UNIQUE (sample_name);


--
-- TOC entry 3577 (class 2606 OID 24186)
-- Name: variant_annotations variant_annotations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_annotations
    ADD CONSTRAINT variant_annotations_pkey PRIMARY KEY (id);


--
-- TOC entry 3458 (class 2606 OID 23870)
-- Name: variants_partitioned variants_partitioned_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_partitioned
    ADD CONSTRAINT variants_partitioned_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3499 (class 2606 OID 23948)
-- Name: variants_chr10 variants_chr10_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr10
    ADD CONSTRAINT variants_chr10_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3503 (class 2606 OID 23956)
-- Name: variants_chr11 variants_chr11_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr11
    ADD CONSTRAINT variants_chr11_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3507 (class 2606 OID 23964)
-- Name: variants_chr12 variants_chr12_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr12
    ADD CONSTRAINT variants_chr12_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3511 (class 2606 OID 23972)
-- Name: variants_chr13 variants_chr13_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr13
    ADD CONSTRAINT variants_chr13_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3515 (class 2606 OID 23980)
-- Name: variants_chr14 variants_chr14_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr14
    ADD CONSTRAINT variants_chr14_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3519 (class 2606 OID 23988)
-- Name: variants_chr15 variants_chr15_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr15
    ADD CONSTRAINT variants_chr15_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3523 (class 2606 OID 23996)
-- Name: variants_chr16 variants_chr16_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr16
    ADD CONSTRAINT variants_chr16_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3527 (class 2606 OID 24004)
-- Name: variants_chr17 variants_chr17_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr17
    ADD CONSTRAINT variants_chr17_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3531 (class 2606 OID 24012)
-- Name: variants_chr18 variants_chr18_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr18
    ADD CONSTRAINT variants_chr18_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3535 (class 2606 OID 24020)
-- Name: variants_chr19 variants_chr19_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr19
    ADD CONSTRAINT variants_chr19_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3463 (class 2606 OID 23876)
-- Name: variants_chr1 variants_chr1_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr1
    ADD CONSTRAINT variants_chr1_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3539 (class 2606 OID 24028)
-- Name: variants_chr20 variants_chr20_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr20
    ADD CONSTRAINT variants_chr20_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3543 (class 2606 OID 24036)
-- Name: variants_chr21 variants_chr21_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr21
    ADD CONSTRAINT variants_chr21_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3547 (class 2606 OID 24044)
-- Name: variants_chr22 variants_chr22_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr22
    ADD CONSTRAINT variants_chr22_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3467 (class 2606 OID 23884)
-- Name: variants_chr2 variants_chr2_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr2
    ADD CONSTRAINT variants_chr2_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3471 (class 2606 OID 23892)
-- Name: variants_chr3 variants_chr3_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr3
    ADD CONSTRAINT variants_chr3_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3475 (class 2606 OID 23900)
-- Name: variants_chr4 variants_chr4_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr4
    ADD CONSTRAINT variants_chr4_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3479 (class 2606 OID 23908)
-- Name: variants_chr5 variants_chr5_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr5
    ADD CONSTRAINT variants_chr5_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3483 (class 2606 OID 23916)
-- Name: variants_chr6 variants_chr6_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr6
    ADD CONSTRAINT variants_chr6_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3487 (class 2606 OID 23924)
-- Name: variants_chr7 variants_chr7_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr7
    ADD CONSTRAINT variants_chr7_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3491 (class 2606 OID 23932)
-- Name: variants_chr8 variants_chr8_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr8
    ADD CONSTRAINT variants_chr8_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3495 (class 2606 OID 23940)
-- Name: variants_chr9 variants_chr9_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chr9
    ADD CONSTRAINT variants_chr9_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3559 (class 2606 OID 24068)
-- Name: variants_chrm variants_chrm_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chrm
    ADD CONSTRAINT variants_chrm_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3551 (class 2606 OID 24052)
-- Name: variants_chrx variants_chrx_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chrx
    ADD CONSTRAINT variants_chrx_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3555 (class 2606 OID 24060)
-- Name: variants_chry variants_chry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_chry
    ADD CONSTRAINT variants_chry_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3563 (class 2606 OID 24076)
-- Name: variants_default variants_default_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variants_default
    ADD CONSTRAINT variants_default_pkey PRIMARY KEY (chromosome, "position", id);


--
-- TOC entry 3566 (class 1259 OID 24362)
-- Name: idx_alts_alt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alts_alt_id ON public.alts USING btree (id);


--
-- TOC entry 3567 (class 1259 OID 24363)
-- Name: idx_alts_variant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alts_variant ON public.alts USING btree (variant_chromosome, variant_position, variant_id);


--
-- TOC entry 3568 (class 1259 OID 24429)
-- Name: idx_alts_variant_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alts_variant_id ON public.alts USING btree (variant_id);


--
-- TOC entry 3569 (class 1259 OID 24430)
-- Name: idx_alts_variant_id_covering; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_alts_variant_id_covering ON public.alts USING btree (variant_id) INCLUDE (id, alt);


--
-- TOC entry 3572 (class 1259 OID 24364)
-- Name: idx_annotations_consequence; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_annotations_consequence ON public.annotations USING btree (consequence);


--
-- TOC entry 3573 (class 1259 OID 24365)
-- Name: idx_annotations_symbol; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_annotations_symbol ON public.annotations USING btree (symbol);


--
-- TOC entry 3459 (class 1259 OID 24428)
-- Name: idx_chr1_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_chr1_position ON public.variants_chr1 USING btree ("position");


--
-- TOC entry 3580 (class 1259 OID 24423)
-- Name: idx_genotypes_alt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_genotypes_alt_id ON public.genotypes USING btree (alt_id);


--
-- TOC entry 3581 (class 1259 OID 24431)
-- Name: idx_genotypes_alt_id_covering; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_genotypes_alt_id_covering ON public.genotypes USING btree (alt_id) INCLUDE (sample_id, genotype_hr);


--
-- TOC entry 3582 (class 1259 OID 24424)
-- Name: idx_genotypes_alt_id_gt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_genotypes_alt_id_gt ON public.genotypes USING btree (alt_id, genotype_hr);


--
-- TOC entry 3583 (class 1259 OID 24425)
-- Name: idx_genotypes_gt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_genotypes_gt ON public.genotypes USING btree (genotype_hr);


--
-- TOC entry 3584 (class 1259 OID 24426)
-- Name: idx_genotypes_sample_alt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_genotypes_sample_alt ON public.genotypes USING btree (sample_id, alt_id);


--
-- TOC entry 3585 (class 1259 OID 24427)
-- Name: idx_genotypes_sample_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_genotypes_sample_id ON public.genotypes USING btree (sample_id);


--
-- TOC entry 3450 (class 1259 OID 24366)
-- Name: idx_samples_grp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_samples_grp ON public.samples USING btree (sample_grp, id, sample_name);


--
-- TOC entry 3574 (class 1259 OID 24367)
-- Name: idx_variant_annotations_alt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_variant_annotations_alt_id ON public.variant_annotations USING btree (alt_id);


--
-- TOC entry 3575 (class 1259 OID 24368)
-- Name: idx_variant_annotations_annotation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_variant_annotations_annotation_id ON public.variant_annotations USING btree (annotation_id);


--
-- TOC entry 3455 (class 1259 OID 24369)
-- Name: idx_variants_partitioned_chrom_pos; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_variants_partitioned_chrom_pos ON ONLY public.variants_partitioned USING btree (chromosome, "position");


--
-- TOC entry 3456 (class 1259 OID 24396)
-- Name: idx_variants_partitioned_id_chrom_pos; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_variants_partitioned_id_chrom_pos ON ONLY public.variants_partitioned USING btree (id, chromosome, "position");


--
-- TOC entry 3496 (class 1259 OID 24371)
-- Name: variants_chr10_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr10_chromosome_position_idx ON public.variants_chr10 USING btree (chromosome, "position");


--
-- TOC entry 3497 (class 1259 OID 24398)
-- Name: variants_chr10_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr10_id_chromosome_position_idx ON public.variants_chr10 USING btree (id, chromosome, "position");


--
-- TOC entry 3500 (class 1259 OID 24372)
-- Name: variants_chr11_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr11_chromosome_position_idx ON public.variants_chr11 USING btree (chromosome, "position");


--
-- TOC entry 3501 (class 1259 OID 24399)
-- Name: variants_chr11_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr11_id_chromosome_position_idx ON public.variants_chr11 USING btree (id, chromosome, "position");


--
-- TOC entry 3504 (class 1259 OID 24373)
-- Name: variants_chr12_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr12_chromosome_position_idx ON public.variants_chr12 USING btree (chromosome, "position");


--
-- TOC entry 3505 (class 1259 OID 24400)
-- Name: variants_chr12_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr12_id_chromosome_position_idx ON public.variants_chr12 USING btree (id, chromosome, "position");


--
-- TOC entry 3508 (class 1259 OID 24374)
-- Name: variants_chr13_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr13_chromosome_position_idx ON public.variants_chr13 USING btree (chromosome, "position");


--
-- TOC entry 3509 (class 1259 OID 24401)
-- Name: variants_chr13_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr13_id_chromosome_position_idx ON public.variants_chr13 USING btree (id, chromosome, "position");


--
-- TOC entry 3512 (class 1259 OID 24375)
-- Name: variants_chr14_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr14_chromosome_position_idx ON public.variants_chr14 USING btree (chromosome, "position");


--
-- TOC entry 3513 (class 1259 OID 24402)
-- Name: variants_chr14_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr14_id_chromosome_position_idx ON public.variants_chr14 USING btree (id, chromosome, "position");


--
-- TOC entry 3516 (class 1259 OID 24376)
-- Name: variants_chr15_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr15_chromosome_position_idx ON public.variants_chr15 USING btree (chromosome, "position");


--
-- TOC entry 3517 (class 1259 OID 24403)
-- Name: variants_chr15_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr15_id_chromosome_position_idx ON public.variants_chr15 USING btree (id, chromosome, "position");


--
-- TOC entry 3520 (class 1259 OID 24377)
-- Name: variants_chr16_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr16_chromosome_position_idx ON public.variants_chr16 USING btree (chromosome, "position");


--
-- TOC entry 3521 (class 1259 OID 24404)
-- Name: variants_chr16_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr16_id_chromosome_position_idx ON public.variants_chr16 USING btree (id, chromosome, "position");


--
-- TOC entry 3524 (class 1259 OID 24378)
-- Name: variants_chr17_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr17_chromosome_position_idx ON public.variants_chr17 USING btree (chromosome, "position");


--
-- TOC entry 3525 (class 1259 OID 24405)
-- Name: variants_chr17_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr17_id_chromosome_position_idx ON public.variants_chr17 USING btree (id, chromosome, "position");


--
-- TOC entry 3528 (class 1259 OID 24379)
-- Name: variants_chr18_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr18_chromosome_position_idx ON public.variants_chr18 USING btree (chromosome, "position");


--
-- TOC entry 3529 (class 1259 OID 24406)
-- Name: variants_chr18_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr18_id_chromosome_position_idx ON public.variants_chr18 USING btree (id, chromosome, "position");


--
-- TOC entry 3532 (class 1259 OID 24380)
-- Name: variants_chr19_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr19_chromosome_position_idx ON public.variants_chr19 USING btree (chromosome, "position");


--
-- TOC entry 3533 (class 1259 OID 24407)
-- Name: variants_chr19_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr19_id_chromosome_position_idx ON public.variants_chr19 USING btree (id, chromosome, "position");


--
-- TOC entry 3460 (class 1259 OID 24370)
-- Name: variants_chr1_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr1_chromosome_position_idx ON public.variants_chr1 USING btree (chromosome, "position");


--
-- TOC entry 3461 (class 1259 OID 24397)
-- Name: variants_chr1_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr1_id_chromosome_position_idx ON public.variants_chr1 USING btree (id, chromosome, "position");


--
-- TOC entry 3536 (class 1259 OID 24382)
-- Name: variants_chr20_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr20_chromosome_position_idx ON public.variants_chr20 USING btree (chromosome, "position");


--
-- TOC entry 3537 (class 1259 OID 24409)
-- Name: variants_chr20_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr20_id_chromosome_position_idx ON public.variants_chr20 USING btree (id, chromosome, "position");


--
-- TOC entry 3540 (class 1259 OID 24383)
-- Name: variants_chr21_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr21_chromosome_position_idx ON public.variants_chr21 USING btree (chromosome, "position");


--
-- TOC entry 3541 (class 1259 OID 24410)
-- Name: variants_chr21_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr21_id_chromosome_position_idx ON public.variants_chr21 USING btree (id, chromosome, "position");


--
-- TOC entry 3544 (class 1259 OID 24384)
-- Name: variants_chr22_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr22_chromosome_position_idx ON public.variants_chr22 USING btree (chromosome, "position");


--
-- TOC entry 3545 (class 1259 OID 24411)
-- Name: variants_chr22_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr22_id_chromosome_position_idx ON public.variants_chr22 USING btree (id, chromosome, "position");


--
-- TOC entry 3464 (class 1259 OID 24381)
-- Name: variants_chr2_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr2_chromosome_position_idx ON public.variants_chr2 USING btree (chromosome, "position");


--
-- TOC entry 3465 (class 1259 OID 24408)
-- Name: variants_chr2_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr2_id_chromosome_position_idx ON public.variants_chr2 USING btree (id, chromosome, "position");


--
-- TOC entry 3468 (class 1259 OID 24385)
-- Name: variants_chr3_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr3_chromosome_position_idx ON public.variants_chr3 USING btree (chromosome, "position");


--
-- TOC entry 3469 (class 1259 OID 24412)
-- Name: variants_chr3_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr3_id_chromosome_position_idx ON public.variants_chr3 USING btree (id, chromosome, "position");


--
-- TOC entry 3472 (class 1259 OID 24386)
-- Name: variants_chr4_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr4_chromosome_position_idx ON public.variants_chr4 USING btree (chromosome, "position");


--
-- TOC entry 3473 (class 1259 OID 24413)
-- Name: variants_chr4_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr4_id_chromosome_position_idx ON public.variants_chr4 USING btree (id, chromosome, "position");


--
-- TOC entry 3476 (class 1259 OID 24387)
-- Name: variants_chr5_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr5_chromosome_position_idx ON public.variants_chr5 USING btree (chromosome, "position");


--
-- TOC entry 3477 (class 1259 OID 24414)
-- Name: variants_chr5_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr5_id_chromosome_position_idx ON public.variants_chr5 USING btree (id, chromosome, "position");


--
-- TOC entry 3480 (class 1259 OID 24388)
-- Name: variants_chr6_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr6_chromosome_position_idx ON public.variants_chr6 USING btree (chromosome, "position");


--
-- TOC entry 3481 (class 1259 OID 24415)
-- Name: variants_chr6_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr6_id_chromosome_position_idx ON public.variants_chr6 USING btree (id, chromosome, "position");


--
-- TOC entry 3484 (class 1259 OID 24389)
-- Name: variants_chr7_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr7_chromosome_position_idx ON public.variants_chr7 USING btree (chromosome, "position");


--
-- TOC entry 3485 (class 1259 OID 24416)
-- Name: variants_chr7_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr7_id_chromosome_position_idx ON public.variants_chr7 USING btree (id, chromosome, "position");


--
-- TOC entry 3488 (class 1259 OID 24390)
-- Name: variants_chr8_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr8_chromosome_position_idx ON public.variants_chr8 USING btree (chromosome, "position");


--
-- TOC entry 3489 (class 1259 OID 24417)
-- Name: variants_chr8_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr8_id_chromosome_position_idx ON public.variants_chr8 USING btree (id, chromosome, "position");


--
-- TOC entry 3492 (class 1259 OID 24391)
-- Name: variants_chr9_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr9_chromosome_position_idx ON public.variants_chr9 USING btree (chromosome, "position");


--
-- TOC entry 3493 (class 1259 OID 24418)
-- Name: variants_chr9_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chr9_id_chromosome_position_idx ON public.variants_chr9 USING btree (id, chromosome, "position");


--
-- TOC entry 3556 (class 1259 OID 24392)
-- Name: variants_chrm_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chrm_chromosome_position_idx ON public.variants_chrm USING btree (chromosome, "position");


--
-- TOC entry 3557 (class 1259 OID 24419)
-- Name: variants_chrm_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chrm_id_chromosome_position_idx ON public.variants_chrm USING btree (id, chromosome, "position");


--
-- TOC entry 3548 (class 1259 OID 24393)
-- Name: variants_chrx_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chrx_chromosome_position_idx ON public.variants_chrx USING btree (chromosome, "position");


--
-- TOC entry 3549 (class 1259 OID 24420)
-- Name: variants_chrx_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chrx_id_chromosome_position_idx ON public.variants_chrx USING btree (id, chromosome, "position");


--
-- TOC entry 3552 (class 1259 OID 24394)
-- Name: variants_chry_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chry_chromosome_position_idx ON public.variants_chry USING btree (chromosome, "position");


--
-- TOC entry 3553 (class 1259 OID 24421)
-- Name: variants_chry_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_chry_id_chromosome_position_idx ON public.variants_chry USING btree (id, chromosome, "position");


--
-- TOC entry 3560 (class 1259 OID 24395)
-- Name: variants_default_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_default_chromosome_position_idx ON public.variants_default USING btree (chromosome, "position");


--
-- TOC entry 3561 (class 1259 OID 24422)
-- Name: variants_default_id_chromosome_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variants_default_id_chromosome_position_idx ON public.variants_default USING btree (id, chromosome, "position");


--
-- TOC entry 3617 (class 0 OID 0)
-- Name: variants_chr10_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr10_chromosome_position_idx;


--
-- TOC entry 3618 (class 0 OID 0)
-- Name: variants_chr10_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr10_id_chromosome_position_idx;


--
-- TOC entry 3619 (class 0 OID 0)
-- Name: variants_chr10_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr10_pkey;


--
-- TOC entry 3620 (class 0 OID 0)
-- Name: variants_chr11_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr11_chromosome_position_idx;


--
-- TOC entry 3621 (class 0 OID 0)
-- Name: variants_chr11_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr11_id_chromosome_position_idx;


--
-- TOC entry 3622 (class 0 OID 0)
-- Name: variants_chr11_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr11_pkey;


--
-- TOC entry 3623 (class 0 OID 0)
-- Name: variants_chr12_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr12_chromosome_position_idx;


--
-- TOC entry 3624 (class 0 OID 0)
-- Name: variants_chr12_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr12_id_chromosome_position_idx;


--
-- TOC entry 3625 (class 0 OID 0)
-- Name: variants_chr12_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr12_pkey;


--
-- TOC entry 3626 (class 0 OID 0)
-- Name: variants_chr13_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr13_chromosome_position_idx;


--
-- TOC entry 3627 (class 0 OID 0)
-- Name: variants_chr13_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr13_id_chromosome_position_idx;


--
-- TOC entry 3628 (class 0 OID 0)
-- Name: variants_chr13_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr13_pkey;


--
-- TOC entry 3629 (class 0 OID 0)
-- Name: variants_chr14_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr14_chromosome_position_idx;


--
-- TOC entry 3630 (class 0 OID 0)
-- Name: variants_chr14_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr14_id_chromosome_position_idx;


--
-- TOC entry 3631 (class 0 OID 0)
-- Name: variants_chr14_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr14_pkey;


--
-- TOC entry 3632 (class 0 OID 0)
-- Name: variants_chr15_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr15_chromosome_position_idx;


--
-- TOC entry 3633 (class 0 OID 0)
-- Name: variants_chr15_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr15_id_chromosome_position_idx;


--
-- TOC entry 3634 (class 0 OID 0)
-- Name: variants_chr15_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr15_pkey;


--
-- TOC entry 3635 (class 0 OID 0)
-- Name: variants_chr16_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr16_chromosome_position_idx;


--
-- TOC entry 3636 (class 0 OID 0)
-- Name: variants_chr16_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr16_id_chromosome_position_idx;


--
-- TOC entry 3637 (class 0 OID 0)
-- Name: variants_chr16_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr16_pkey;


--
-- TOC entry 3638 (class 0 OID 0)
-- Name: variants_chr17_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr17_chromosome_position_idx;


--
-- TOC entry 3639 (class 0 OID 0)
-- Name: variants_chr17_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr17_id_chromosome_position_idx;


--
-- TOC entry 3640 (class 0 OID 0)
-- Name: variants_chr17_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr17_pkey;


--
-- TOC entry 3641 (class 0 OID 0)
-- Name: variants_chr18_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr18_chromosome_position_idx;


--
-- TOC entry 3642 (class 0 OID 0)
-- Name: variants_chr18_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr18_id_chromosome_position_idx;


--
-- TOC entry 3643 (class 0 OID 0)
-- Name: variants_chr18_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr18_pkey;


--
-- TOC entry 3644 (class 0 OID 0)
-- Name: variants_chr19_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr19_chromosome_position_idx;


--
-- TOC entry 3645 (class 0 OID 0)
-- Name: variants_chr19_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr19_id_chromosome_position_idx;


--
-- TOC entry 3646 (class 0 OID 0)
-- Name: variants_chr19_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr19_pkey;


--
-- TOC entry 3590 (class 0 OID 0)
-- Name: variants_chr1_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr1_chromosome_position_idx;


--
-- TOC entry 3591 (class 0 OID 0)
-- Name: variants_chr1_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr1_id_chromosome_position_idx;


--
-- TOC entry 3592 (class 0 OID 0)
-- Name: variants_chr1_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr1_pkey;


--
-- TOC entry 3647 (class 0 OID 0)
-- Name: variants_chr20_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr20_chromosome_position_idx;


--
-- TOC entry 3648 (class 0 OID 0)
-- Name: variants_chr20_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr20_id_chromosome_position_idx;


--
-- TOC entry 3649 (class 0 OID 0)
-- Name: variants_chr20_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr20_pkey;


--
-- TOC entry 3650 (class 0 OID 0)
-- Name: variants_chr21_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr21_chromosome_position_idx;


--
-- TOC entry 3651 (class 0 OID 0)
-- Name: variants_chr21_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr21_id_chromosome_position_idx;


--
-- TOC entry 3652 (class 0 OID 0)
-- Name: variants_chr21_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr21_pkey;


--
-- TOC entry 3653 (class 0 OID 0)
-- Name: variants_chr22_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr22_chromosome_position_idx;


--
-- TOC entry 3654 (class 0 OID 0)
-- Name: variants_chr22_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr22_id_chromosome_position_idx;


--
-- TOC entry 3655 (class 0 OID 0)
-- Name: variants_chr22_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr22_pkey;


--
-- TOC entry 3593 (class 0 OID 0)
-- Name: variants_chr2_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr2_chromosome_position_idx;


--
-- TOC entry 3594 (class 0 OID 0)
-- Name: variants_chr2_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr2_id_chromosome_position_idx;


--
-- TOC entry 3595 (class 0 OID 0)
-- Name: variants_chr2_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr2_pkey;


--
-- TOC entry 3596 (class 0 OID 0)
-- Name: variants_chr3_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr3_chromosome_position_idx;


--
-- TOC entry 3597 (class 0 OID 0)
-- Name: variants_chr3_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr3_id_chromosome_position_idx;


--
-- TOC entry 3598 (class 0 OID 0)
-- Name: variants_chr3_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr3_pkey;


--
-- TOC entry 3599 (class 0 OID 0)
-- Name: variants_chr4_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr4_chromosome_position_idx;


--
-- TOC entry 3600 (class 0 OID 0)
-- Name: variants_chr4_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr4_id_chromosome_position_idx;


--
-- TOC entry 3601 (class 0 OID 0)
-- Name: variants_chr4_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr4_pkey;


--
-- TOC entry 3602 (class 0 OID 0)
-- Name: variants_chr5_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr5_chromosome_position_idx;


--
-- TOC entry 3603 (class 0 OID 0)
-- Name: variants_chr5_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr5_id_chromosome_position_idx;


--
-- TOC entry 3604 (class 0 OID 0)
-- Name: variants_chr5_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr5_pkey;


--
-- TOC entry 3605 (class 0 OID 0)
-- Name: variants_chr6_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr6_chromosome_position_idx;


--
-- TOC entry 3606 (class 0 OID 0)
-- Name: variants_chr6_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr6_id_chromosome_position_idx;


--
-- TOC entry 3607 (class 0 OID 0)
-- Name: variants_chr6_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr6_pkey;


--
-- TOC entry 3608 (class 0 OID 0)
-- Name: variants_chr7_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr7_chromosome_position_idx;


--
-- TOC entry 3609 (class 0 OID 0)
-- Name: variants_chr7_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr7_id_chromosome_position_idx;


--
-- TOC entry 3610 (class 0 OID 0)
-- Name: variants_chr7_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr7_pkey;


--
-- TOC entry 3611 (class 0 OID 0)
-- Name: variants_chr8_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr8_chromosome_position_idx;


--
-- TOC entry 3612 (class 0 OID 0)
-- Name: variants_chr8_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr8_id_chromosome_position_idx;


--
-- TOC entry 3613 (class 0 OID 0)
-- Name: variants_chr8_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr8_pkey;


--
-- TOC entry 3614 (class 0 OID 0)
-- Name: variants_chr9_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chr9_chromosome_position_idx;


--
-- TOC entry 3615 (class 0 OID 0)
-- Name: variants_chr9_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chr9_id_chromosome_position_idx;


--
-- TOC entry 3616 (class 0 OID 0)
-- Name: variants_chr9_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chr9_pkey;


--
-- TOC entry 3662 (class 0 OID 0)
-- Name: variants_chrm_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chrm_chromosome_position_idx;


--
-- TOC entry 3663 (class 0 OID 0)
-- Name: variants_chrm_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chrm_id_chromosome_position_idx;


--
-- TOC entry 3664 (class 0 OID 0)
-- Name: variants_chrm_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chrm_pkey;


--
-- TOC entry 3656 (class 0 OID 0)
-- Name: variants_chrx_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chrx_chromosome_position_idx;


--
-- TOC entry 3657 (class 0 OID 0)
-- Name: variants_chrx_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chrx_id_chromosome_position_idx;


--
-- TOC entry 3658 (class 0 OID 0)
-- Name: variants_chrx_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chrx_pkey;


--
-- TOC entry 3659 (class 0 OID 0)
-- Name: variants_chry_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_chry_chromosome_position_idx;


--
-- TOC entry 3660 (class 0 OID 0)
-- Name: variants_chry_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_chry_id_chromosome_position_idx;


--
-- TOC entry 3661 (class 0 OID 0)
-- Name: variants_chry_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_chry_pkey;


--
-- TOC entry 3665 (class 0 OID 0)
-- Name: variants_default_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_chrom_pos ATTACH PARTITION public.variants_default_chromosome_position_idx;


--
-- TOC entry 3666 (class 0 OID 0)
-- Name: variants_default_id_chromosome_position_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_variants_partitioned_id_chrom_pos ATTACH PARTITION public.variants_default_id_chromosome_position_idx;


--
-- TOC entry 3667 (class 0 OID 0)
-- Name: variants_default_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.variants_partitioned_pkey ATTACH PARTITION public.variants_default_pkey;


--
-- TOC entry 3668 (class 2606 OID 24088)
-- Name: alts alts_variant_chromosome_variant_position_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alts
    ADD CONSTRAINT alts_variant_chromosome_variant_position_variant_id_fkey FOREIGN KEY (variant_chromosome, variant_position, variant_id) REFERENCES public.variants_partitioned(chromosome, "position", id) ON DELETE CASCADE;


--
-- TOC entry 3671 (class 2606 OID 24206)
-- Name: genotypes genotypes_alt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genotypes
    ADD CONSTRAINT genotypes_alt_id_fkey FOREIGN KEY (alt_id) REFERENCES public.alts(id) ON DELETE CASCADE;


--
-- TOC entry 3672 (class 2606 OID 24211)
-- Name: genotypes genotypes_sample_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genotypes
    ADD CONSTRAINT genotypes_sample_id_fkey FOREIGN KEY (sample_id) REFERENCES public.samples(id) ON DELETE CASCADE;


--
-- TOC entry 3673 (class 2606 OID 24225)
-- Name: sample_relationships sample_relationships_sample_id1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_relationships
    ADD CONSTRAINT sample_relationships_sample_id1_fkey FOREIGN KEY (sample_id1) REFERENCES public.samples(id) ON DELETE CASCADE;


--
-- TOC entry 3674 (class 2606 OID 24230)
-- Name: sample_relationships sample_relationships_sample_id2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sample_relationships
    ADD CONSTRAINT sample_relationships_sample_id2_fkey FOREIGN KEY (sample_id2) REFERENCES public.samples(id) ON DELETE CASCADE;


--
-- TOC entry 3669 (class 2606 OID 24187)
-- Name: variant_annotations variant_annotations_alt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_annotations
    ADD CONSTRAINT variant_annotations_alt_id_fkey FOREIGN KEY (alt_id) REFERENCES public.alts(id) ON DELETE CASCADE;


--
-- TOC entry 3670 (class 2606 OID 24192)
-- Name: variant_annotations variant_annotations_annotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_annotations
    ADD CONSTRAINT variant_annotations_annotation_id_fkey FOREIGN KEY (annotation_id) REFERENCES public.annotations(id) ON DELETE CASCADE;
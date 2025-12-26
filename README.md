# Demultiplexing_NovaSeq_X_Plus

Nextflow DSL2 workflow to demultiplex shared NovaSeq X Plus runs and generate
project-specific deliverables:

- bcl-convert demultiplexing
- FastQC per FASTQ
- md5 checksums per FASTQ
- MultiQC report per Project

## Requirements
- Nextflow (recommended: >= 23.x)
- Docker or Singularity
- NovaSeq X Plus run folder (BCL output)
- SampleSheet.csv containing a `Project` column

## Run (Docker)
```bash
nextflow run main.nf \
  -profile docker \
  --run_dir /path/to/run_folder \
  --samplesheet /path/to/SampleSheet.csv \
  --outdir /path/to/output

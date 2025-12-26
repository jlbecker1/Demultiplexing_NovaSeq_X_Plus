nextflow.enable.dsl = 2

include { DEMULTIPLEX_BCLCONVERT } from './modules/demultiplex_bclconvert'
include { FASTQC }                 from './modules/fastqc'
include { MD5SUM }                 from './modules/md5sum'
include { MULTIQC_BY_PROJECT }     from './modules/multiqc_by_project'

workflow {

    if( !params.run_dir )      error "Missing required --run_dir"
    if( !params.samplesheet )  error "Missing required --samplesheet"
    if( !params.outdir )       error "Missing required --outdir"

    Channel
        .fromPath(params.samplesheet)
        .set { samplesheet_ch }

    /*
     * Demultiplex: emits tuples (project, fastq)
     * NOTE: requires SampleSheet with Project column so bcl-convert creates per-project directories.
     */
    demux_ch = DEMULTIPLEX_BCLCONVERT(params.run_dir, samplesheet_ch).out.fastq

    FASTQC(demux_ch)
    MD5SUM(demux_ch)

    // MultiQC per project using the FastQC outputs
    MULTIQC_BY_PROJECT(FASTQC.out.fastqc_by_project)
}

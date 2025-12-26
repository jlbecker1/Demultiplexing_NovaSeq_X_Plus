process DEMULTIPLEX_BCLCONVERT {

    tag "bcl-convert"

    publishDir "${params.outdir}", mode: 'copy'

    input:
    path run_dir
    path samplesheet

    /*
     * We expect bcl-convert to create:
     *   <Project>/fastq/*.fastq.gz
     * This output channel emits tuples: (project, fastq)
     */
    output:
    tuple val(project), path("${project}/fastq/*.fastq.gz"), emit: fastq

    script:
    """
    bcl-convert \
      --input-directory ${run_dir} \
      --output-directory . \
      --sample-sheet ${samplesheet} \
      --force
    """
}

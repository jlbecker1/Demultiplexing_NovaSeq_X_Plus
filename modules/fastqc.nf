process FASTQC {

    tag "${project}:${fastq.baseName}"

    publishDir "${params.outdir}/${project}/fastqc", mode: 'copy'

    input:
    tuple val(project), path(fastq)

    output:
    // keep single-fastq outputs
    tuple val(project), path("*_fastqc.zip"), emit: fastqc

    // also emit a grouped channel for MultiQC (one tuple per project)
    tuple val(project), path("*_fastqc.zip"), emit: fastqc_raw

    script:
    """
    fastqc ${fastq}
    """
}

workflow {

    take: fastq

    main:
    FASTQC(fastq)

    /*
     * Group FastQC zips by project for per-project MultiQC.
     * Output: (project, [zip1, zip2, ...])
     */
    emit:
    fastqc_by_project = FASTQC.out.fastqc.groupTuple(by: 0)
}

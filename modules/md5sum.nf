process MD5SUM {

    tag "${project}:${fastq.baseName}"

    publishDir "${params.outdir}/${project}/md5", mode: 'copy'

    input:
    tuple val(project), path(fastq)

    output:
    path "${fastq.simpleName}.md5"

    script:
    """
    md5sum ${fastq} > ${fastq.simpleName}.md5
    """
}

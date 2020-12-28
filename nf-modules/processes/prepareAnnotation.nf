/**************************************
 * Feature counts
 */

process prepareAnnotation{
  label 'unix'
  label 'minCpu'
  label 'minMem'
  publishDir "${params.outDir}/featCounts/", mode: "copy"

  when:
  !params.skipFeatCounts

  input:
  path(bed)

  output:
  path("*tss.bed")

  script:
  prefix = bed.toString() - ~/(.bed)?$/
  """
  awk -F"\t" -v win=${params.tssSize} 'BEGIN{OFS="\t"} \$6=="+"{s=\$2-win;e=\$2+win;if(s<0){s=0}; print \$1,s,e,\$4,\$5,\$6} \$6=="-"{print \$1,\$3-win,\$3+win,\$4,\$5,\$6}' ${bed} > ${prefix}_tss.bed
  """
}

/* 
 * define the data analysis workflow 
 */

/* 
 * include requires tasks 
 */
include { checkDesign } from '../processes/checkDesign'
include { fastQC } from '../processes/fastQC'

workflow qcFlow {
    // required inputs
    take:
      design
      samplePlan
      reads 
    // workflow implementation
    main:
      checkDesign(design, samplePlan)
      fastQC(reads)
    emit:
      mqc = fastQC.out.mqc           // channel: [ path *_fastqc.{zip,html} ]
      version = fastQC.out.version   // channel: [ path v_fastqc.txt ]
}


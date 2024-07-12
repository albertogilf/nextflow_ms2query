#!/usr/bin/env nextflow
nextflow.enable.dsl=2


params.library_path = "default"

// Workflow Boiler Plate
params.OMETALINKING_YAML = "flow_filelinking.yaml"
params.OMETAPARAM_YAML = "job_parameters.yaml"

TOOL_FOLDER = "$baseDir/bin"

process processMS2query {
    publishDir "./nf_output", mode: 'copy'
    conda "$TOOL_FOLDER/conda_env.yml"
    input:
    val spectra_path
    val library_path
    val ion_mode
    val additional_metadata

    output:
    path 'results/*.csv', emit: annotations
    path 'ms2query_results.zip', emit: compressed_results
    
    script: 
    def commandline_call = "--spectra ${spectra_path} --library ${library_path} --ionmode ${ion_mode} --additional_metadata ${additional_metadata} --results ./results"
    
    """
    ms2query ${commandline_call}
    zip -r ms2query_results.zip ./results
    """
}



workflow{
    processMS2query(params.spectra_path, params.library_path, params.ion_mode, params.additional_metadata) 
}

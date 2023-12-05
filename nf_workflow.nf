#!/usr/bin/env nextflow
nextflow.enable.dsl=2


params.library_path = "default"
params.publishdir = "./nf_output"

// Workflow Boiler Plate
params.OMETALINKING_YAML = "flow_filelinking.yaml"
params.OMETAPARAM_YAML = "job_parameters.yaml"

TOOL_FOLDER = "$baseDir/bin"

process processMS2query {
    publishDir "$params.publishdir", mode: 'copy'
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
    def library = ${library_path}
    if (library == "default") {
        if(ion_mode == "positive") {
            library = "USERUPLOAD/shared/ms2query/positiveim_model"
        }
        else if(ion_mode == "negative") {
            library = "USERUPLOAD/shared/ms2query/negativeim_model"
        }
    }
    def commandline_call = "--spectra ${spectra_path} --library ${library} --ionmode ${ion_mode} --additional_metadata ${additional_metadata} --results ./results"
    
    """    
    ms2query ${commandline_call}
    zip -r ms2query_results.zip ./results
    """
}



workflow{
    processMS2query(params.spectra_path, params.library_path, params.ion_mode, params.additional_metadata) 
}

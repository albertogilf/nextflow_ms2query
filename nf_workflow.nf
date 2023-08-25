#!/usr/bin/env nextflow
nextflow.enable.dsl=2



params.publishdir = "./nf_output"

// Workflow Boiler Plate
params.OMETALINKING_YAML = "flow_filelinking.yaml"
params.OMETAPARAM_YAML = "job_parameters.yaml"

TOOL_FOLDER = "$baseDir/bin"

process processMS2query {
    publishDir "$params.publishdir", mode: 'copy', overwrite: false
    conda "$TOOL_FOLDER/conda_env.yml"
    input:
    val spectra_path
    val library_path
    val download_last_model
    val ion_mode
    val ion_mode_exclusion
    val additional_metadata

    output:
    path "ms2queryresults.zip", emit: zip
    
    script: 
    def commandline_call = "--spectra ${spectra_path} --library ${library_path} --ionmode ${ion_mode} --additional_metadata ${additional_metadata} --results ${params.publishdir}"
    if (download_last_model == "yes" || download_last_model == "true" ) {
        commandline_call += " --download"
    }
    if (ion_mode_exclusion == "yes" || ion_mode_exclusion == "true") {
        commandline_call += " --filter_ionmode"
    }
    """    
    ms2query ${commandline_call}
    
    """
}



workflow{
    processMS2query(params.spectra_path, params.library_path, params.download_last_model, params.ion_mode, params.ion_mode_exclusion, params.additional_metadata) 
}

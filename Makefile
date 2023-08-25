clean:
	rm -Rf .nextflow* work bin/*__pycache__* nf_output/*

run:
	nextflow run ./nf_workflow.nf --spectra_path "$(spectra_path)" --library_path "$(library_path)" --download_last_model "$(download_last_model)" --ion_mode "$(ion_mode)" --ion_mode_exclusion "$(ion_mode_exclusion)" -resume -c nextflow.config

run_hpcc:
	nextflow run ./nf_workflow.nf --spectra_path "$(spectra_path)" --library_path "$(library_path)" --download_last_model "$(download_last_model)" --ion_mode "$(ion_mode)" --ion_mode_exclusion "$(ion_mode_exclusion)" -resume -c nextflow_hpcc.config

run_docker:
	nextflow run ./nf_workflow.nf --spectra_path "$(spectra_path)" --library_path "$(library_path)" --download_last_model "$(download_last_model)" --ion_mode "$(ion_mode)" --ion_mode_exclusion "$(ion_mode_exclusion)" -resume -with-docker <CONTAINER NAME>

library_path="default"

clean:
	rm -Rf .nextflow* work bin/*__pycache__* nf_output/*

run:
	nextflow run ./nf_workflow.nf --spectra_path "$(spectra_path)" --library_path "$(library_path)" --ion_mode "$(ion_mode)" --additional_metadata "$(additional_metadata)" -resume -c nextflow.config

run_hpcc:
	nextflow run ./nf_workflow.nf --spectra_path "$(spectra_path)" --library_path "$(library_path)" --ion_mode "$(ion_mode)" --additional_metadata "$(additional_metadata)" -resume -c nextflow_hpcc.config

run_docker:
	nextflow run ./nf_workflow.nf --spectra_path "$(spectra_path)" --library_path "$(library_path)" --ion_mode "$(ion_mode)" --additional_metadata "$(additional_metadata)" -resume -with-docker <CONTAINER NAME>

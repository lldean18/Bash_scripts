#!/bin/bash
# create the ABBA BABA file preparation function
ABBA_BABA_file_prep () {
	# reattatch to the abbababa screen or create one and attach to it if it doesn't exist
	# not currently working as I want it to
	#screen -D -R abbababa
	#batch_number="value"
	#number_of_threads="value"
	#input populations="value"
	ref_map.pl \
-b $1\
-T $number_of_threads \
-O /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/ABBA_BABA/Populations_$input_populations/popmap_population_$input_populations.txt \
-o /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/ABBA_BABA/Populations_$input_populations \
--samples /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/Isabels_data/BAM_files \
-S \
-m 3

}

ABBA_BABA_file_prep 9 8 OBSE_OBSM_SCAD_BEPA

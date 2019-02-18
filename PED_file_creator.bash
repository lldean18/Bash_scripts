#!/bin/bash
# running this file creates a PED file from a VCF file
# written by Laura Dean on 13th Feb 2019

# filter the VCF file to remove the sex chromosomes and quality control unlinked loci
#vcftools \
--vcf /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20/batch_20.FORMATTED.vcf \
--out /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/batch_20.FORMATTED.filtered \
--not-chr groupIX \
--not-chr groupXIX \
--min-meanDP 6 \
--max-meanDP 200 \
--max-missing 0.75 \
--mac 2 \
--recode \
--recode-INFO-all

# convert the VCF file to PED format using PGDspider
java -Xmx1024m -Xms512m \
-jar /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/PGDspider_file_conversion/PGDSpider2-cli.jar \
-inputfile /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/batch_20.FORMATTED.filtered.recode.vcf \
-inputformat VCF \
-outputfile /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_data_files/batch_20.FORMATTED.filtered.recode.ped \
-outputformat PED \
-spid /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/PGDspider_file_conversion/VCF_to_PED.spid

# Edit the map file to be readable by Haploview (br removing the uncesessary columns that have been output by PGDspider
sed -i 's/ .* 0 / /' /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_data_files/map.file.map
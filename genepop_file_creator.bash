#!/bin/bash
# running this file creates a genepop file
# written by Laura Dean on 28th Jan 2019

# run the ref map program in STACKS to call all of the BAM files into a single file
ref_map.pl -b 20 -T 8 -O /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20/popmap.txt -o /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20 --samples /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/Isabels_data/BAM_files -S

# run the populations program in STACKS to filter the data and produce a VCF file
populations -P /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20 --popmap /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20/popmap.txt -t 8 -O /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20 --min_maf 0.05 -p 3 -r 0.8 --vcf --ordered_export

# change the scaffold names in the VCF file to groupUn to match the BED repeated regions filtering file
sed 's/scaffold_[0-9][0-9][0-9][0-9]/groupUn/g; s/scaffold_[0-9][0-9][0-9]/groupUn/g; s/scaffold_[0-9][0-9]/groupUn/g; s/scaffold_[0-9]/groupUn/g' </home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20/batch_20.vcf >/home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20/batch_20.FORMATTED.vcf

# filter the VCF file to remove the sex chromosomes and quality control unlinked loci
vcftools --vcf /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/temp_20/batch_20.FORMATTED.vcf --out /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/batch_20.FORMATTED.filtered --not-chr groupIX --not-chr groupXIX --min-meanDP 6 --max-meanDP 200 --max-missing 0.75 --mac 2 --recode --recode-INFO-all

# convert the VCF file to genepop format using PGDspider
java -Xmx1024m -Xms512m -jar /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/PGDspider_file_conversion/PGDSpider2-cli.jar -inputfile /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/batch_20.FORMATTED.filtered.recode.vcf -inputformat VCF -outputfile /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/batch_20.FORMATTED.filtered.recode.GENEPOP.gen -outputformat GENEPOP -spid /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/PGDspider_file_conversion/VCF_to_GENEPOP.spid

# add some ID text to the first line of the Genepop file output from PGD spider, otherwise the file is not read propperly by adegenet
sed -i "1s/.*/# Genepop SNP data file/" /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/batch_20.FORMATTED.filtered.recode.GENEPOP.gen


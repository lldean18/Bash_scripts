# bash file to convert a VCF file to nexus format
# written to make a nexus file for splitstree input
# written on 30th Jan 19 by Laura Dean

# convert the VCF file to nexus format using PGDspider
java -Xmx1024m -Xms512m -jar /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/PGDspider_file_conversion/PGDSpider2-cli.jar \
-inputfile /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/adegenet/batch_20.FORMATTED.filtered.recode.vcf \
-inputformat VCF \
-outputfile /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/splitstree/batch_20.FORMATTED.filtered.recode.nex \
-outputformat NEXUS \
-spid /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/PGDspider_file_conversion/VCF_to_NEXUS.spid

# change the datatype = SNP to DNA so it can be read by splitstree
sed -i 's/SNP/STANDARD/; /BEGIN SETS;/Q; s/MISSING=?;/MISSING=?/; /MISSING=?/ a SYMBOLS="012";' /home/mbzlld/lauras_files/Post-doc_work_2018/RAD_analysis/my_RAD_analysis/splitstree/batch_20.FORMATTED.filtered.recode.nex
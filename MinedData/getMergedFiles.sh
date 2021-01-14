#!/bin/bash

unzip listeners-new.zip
unzip listeners-old.zip

cd listeners-new
readlink -f `ls *_*.json` > new_query_proj_list.out
cd ../listeners-old
readlink -f `ls *_*.json` > old_query_proj_list.out

python parse_query_output_into_csv.py new_query_proj_list.out merged_data_withFile.out
python parse_query_output_into_csv.py old_query_proj_list.out merged_data_withFile_noAliasRemoval.out

python fake_external_data_allData.py merged_data_withFile.out new_externalData.qll
python fake_external_data_allData.py merged_data_withFile_noAliasRemoval.out old_externalData.qll

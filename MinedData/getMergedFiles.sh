#!/bin/bash    
    
cd listeners-and-emitters    
readlink -f `ls *_*.json` > ../query_proj_list.out    
cd ..    
    
python parse_query_output_into_csv.py query_proj_list.out listen_merged_data_withFile.out    
    
python fake_external_data_allData.py merged_data_withFile.out externalData.qll    


#!/bin/bash

alias python=python3
alias ipython=ipython3
rm -r local_mount
rm build.sh
rm Dockerfile
rm runDocker.sh

mkdir -p /home/codeql_home

mv /home/playground/codeql-linux64.zip /home/codeql_home/ 
cd /home/codeql_home
unzip codeql-linux64.zip 
git clone https://github.com/github/codeql.git codeql-repo

export PATH=/home/codeql_home/codeql:$PATH

cd /home/playground

cd GroundTruthGeneration
unzip old_externalData.qll.zip
rm old_externalData.qll.zip
unzip new_externalData.qll.zip
rm new_externalData.qll.zip

cd ../MinedData 
unzip merged_data.out.zip
rm merged_data.out.zip
unzip merged_data_withFile.out.zip
rm merged_data_withFile.out.zip

cd ..
tar -xzvf data_exps.tgz
tar -xzvf data_exps_noAliasRemoval.tgz
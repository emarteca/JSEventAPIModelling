#!/bin/bash

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
unzip externalData.qll.zip
rm externalData.qll.zip

cd ../MinedData 
unzip listen_merged_data.out.zip
rm listen_merged_data.out.zip
unzip listen_merged_data_withFile.out.zip
rm listen_merged_data_withFile.out.zip
unzip listeners-and-emitters.zip
rm listeners-and-emitters.zip

cd ..
tar -xzvf data_exps.tgz
rm data_exps.tgz

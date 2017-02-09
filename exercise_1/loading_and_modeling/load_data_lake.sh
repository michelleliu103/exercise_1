#!/bin/bash

# save my current directory
MY_CWD=$(pwd)

# creating staging directories
mkdir ~/staging
mkdir ~/staging/exercise_1

# change to staging dir
cd ~/staging/exercise_1

# get file from data.medicare.gov
wget "https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"  -O file.zip

# unzip the medicare data
unzip file.zip 

# remove first line of files and rename 
mkdir hospital_compare
mv Timely\ and\ Effective\ Care\ -\ Hospital.csv hospital_compare/effective_care_orig.csv
mv Readmissions\ and\ Deaths\ -\ Hospital.csv hospital_compare/readmissions_orig.csv
mv Hospital\ General\ Information.csv hospital_compare/hospitals_orig.csv
mv Measure\ Dates.csv hospital_compare/measures_orig.csv
mv hvbp_hcahps_11_10_2016.csv hospital_compare/survey_responses_orig.csv
cd hospital_compare/

tail -n +2 effective_care_orig.csv >  effective_care.csv
tail -n +2 hospitals_orig.csv > hospitals.csv
tail -n +2 readmissions_orig.csv > readmissions.csv
tail -n +2 measures_orig.csv > measures.csv
tail -n +2 survey_responses_orig.csv > survey_responses.csv

#create hdfs directory
hdfs dfs -mkdir /user/w205/hospital_compare

#copy the files to hdfs
hdfs dfs -put effective_care.csv hospitals.csv readmissions.csv measures.csv survey_responses.csv /user/w205/hospital_compare
hdfs dfs -ls /user/w205/hospital_compare/

# change directory back to the original
cd $MY_CWD

# clean exit
exit

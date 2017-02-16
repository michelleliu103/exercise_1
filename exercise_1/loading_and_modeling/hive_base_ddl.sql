DROP TABLE hospitals_all;
CREATE EXTERNAL TABLE hospitals_all 
(Provider_ID INT, 
Hospital_Name STRING, 
Address STRING,
City STRING,
State STRING,
Zip_Code INT,
County_Name STRING,
Phone_Number INT,
Hospital_Type STRING,
Hospital_Ownership STRING,
Emergency_Services STRING,
Meets_criteria_for_meaningful_use_of_EHRs STRING,
Hospital_overall_rating INT,
Hospital_overall_rating_footnote STRING,
Mortality_national_comparison STRING,
Mortality_national_comparison_footnote STRING,
Safety_of_care_national_comparison STRING,
Safety_of_care_national_comparison_footnote STRING,
Readmission_national_comparison STRING,
Readmission_national_comparison_footnote STRING,
Patient_experience_national_comparison STRING,
Patient_experience_national_comparison_footnote STRING,
Effectiveness_of_care_national_comparison STRING,
Effectiveness_of_care_national_comparison_footnote STRING,
Timeliness_of_care_national_comparison STRING,
Timeliness_of_care_national_comparison_footnote STRING,
Efficient_use_of_medical_imaging_national_comparison STRING,
Efficient_use_of_medical_imaging_national_comparison_footnote STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
"separatorChar" = ",", 
"quoteChar" = '"', 
"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

DROP TABLE effective_care_all;
CREATE EXTERNAL TABLE effective_care_all 
(Provider_ID INT, 
Hospital_Name STRING,
Address STRING,
City STRING,
State STRING,
ZIP_Code INT,
County_Name STRING,
Phone_Number INT,
Condition STRING,
Measure_ID INT,
Measure_Name STRING,
Score INT,
Sample INT,
Footnote STRING,
Measure_Start_Date STRING,
Measure_End_Date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
"separatorChar" = ",", 
"quoteChar" = '"', 
"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

DROP TABLE readmissions_all;
CREATE EXTERNAL TABLE readmissions_all 
(Provider_ID INT,
Hospital_Name STRING,
Address STRING,
City STRING,
State STRING,
ZIP_Code INT,
County_Name STRING,
Phone_Number INT,
Measure_Name STRING,
Measure_ID INT,
Compared_to_National STRING,
Denominator INT,
Score INT,
Lower_Estimate INT,
Higher_Estimate INT,
Footnote STRING,
Measure_Start_Date STRING,
Measure_End_Date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
"separatorChar" = ",", 
"quoteChar" = '"', 
"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

DROP TABLE measures_all;
CREATE EXTERNAL TABLE measures_all 
(Measure_Name STRING,
Measure_ID INT,
Measure_Start_Quarter STRING,
Measure_Start_Date STRING,
Measure_End_Quarter STRING,
Measure_End_Date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
"separatorChar" = ",", 
"quoteChar" = '"', 
"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures';

DROP TABLE surveys_responses_all;
CREATE EXTERNAL TABLE surveys_responses_all 
(Provider_ID INT,
Hospital_Name STRING,
Address STRING,
City STRING,
State STRING,
ZIP_Code INT,
County_Name STRING,
Communication_with_Nurses_Floor INT,
Communication_with_Nurses_Achievement_Threshold INT,
Communication_with_Nurses_Benchmark INT,
Communication_with_Nurses_Baseline_Rate INT,
Communication_with_Nurses_Performance_Rate INT,
Communication_with_Nurses_Achievement_Points INT,
Communication_with_Nurses_Improvement_Points INT,
Communication_with_Nurses_Dimension_Score INT,
Communication_with_Doctors_Floor INT,
Communication_with_Doctors_Achievement_Threshold INT,
Communication_with_Doctors_Benchmark INT,
Communication_with_Doctors_Baseline_Rate INT,
Communication_with_Doctors_Performance_Rate INT,
Communication_with_Doctors_Achievement_Points INT,
Communication_with_Doctors_Improvement_Points INT,
Communication_with_Doctors_Dimension_Score INT,
Responsiveness_of_Hospital_Staff_Floor INT,
Responsiveness_of_Hospital_Staff_Achievement_Threshold INT,
Responsiveness_of_Hospital_Staff_Benchmark INT,
Responsiveness_of_Hospital_Staff_Baseline_Rate INT,
Responsiveness_of_Hospital_Staff_Performance_Rate INT,
Responsiveness_of_Hospital_Staff_Achievement_Points INT,
Responsiveness_of_Hospital_Staff_Improvement_Points INT,
Responsiveness_of_Hospital_Staff_Dimension_Score INT,
Pain_Management_Floor INT,
Pain_Management_Achievement_Threshold INT,
Pain_Management_Benchmark INT,
Pain_Management_Baseline_Rate INT,
Pain_Management_Performance_Rate INT,
Pain_Management_Achievement_Points INT,
Pain_Management_Improvement_Points INT,
Pain_Management_Dimension_Score INT,
Communication_about_Medicines_Floor INT,
Communication_about_Medicines_Achievement_Threshold INT,
Communication_about_Medicines_Benchmark INT,
Communication_about_Medicines_Baseline_Rate INT,
Communication_about_Medicines_Performance_Rate INT,
Communication_about_Medicines_Achievement_Points INT,
Communication_about_Medicines_Improvement_Points INT,
Communication_about_Medicines_Dimension_Score INT,
Cleanliness_and_Quietness_of_Hospital_Environment_Floor INT,
Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Threshold INT,
Cleanliness_and_Quietness_of_Hospital_Environment_Benchmark INT,
Cleanliness_and_Quietness_of_Hospital_Environment_Baseline_Rate INT,
Cleanliness_and_Quietness_of_Hospital_Environment_Performance_Rate INT,
Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points INT,
Cleanliness_and_Quietness_of_Hospital_Environment_Improvement_Points INT,
Cleanliness_and_Quietness_of_Hospital_Environment_Dimension_Score INT,
Discharge_Information_Floor INT,
Discharge_Information_Achievement_Threshold INT,
Discharge_Information_Benchmark INT,
Discharge_Information_Baseline_Rate INT,
Discharge_Information_Performance_Rate INT,
Discharge_Information_Achievement_Points INT,
Discharge_Information_Improvement_Points INT,
Discharge_Information_Dimension_Score INT,
Overall_Rating_of_Hospital_Floor INT,
Overall_Rating_of_Hospital_Achievement_Threshold INT,
Overall_Rating_of_Hospital_Benchmark INT,
Overall_Rating_of_Hospital_Baseline_Rate INT,
Overall_Rating_of_Hospital_Performance_Rate INT,
Overall_Rating_of_Hospital_Achievement_Points INT,
Overall_Rating_of_Hospital_Improvement_Points INT,
Overall_Rating_of_Hospital_Dimension_Score INT,
HCAHPS_Base_Score INT,
HCAHPS_Consistency_Score INT)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
"separatorChar" = ",", 
"quoteChar" = '"', 
"escapeChar" = '\\' )
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses';

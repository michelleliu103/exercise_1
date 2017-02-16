DROP TABLE hospitals;
CREATE TABLE hospitals AS 
SELECT 
  provider_id, 
  hospital_name, 
  state, 
  CAST(hospital_overall_rating AS DECIMAL(1,0)) rating
FROM hospitals_all
WHERE hospital_overall_rating NOT LIKE 'Not%';

DROP TABLE effective_care;
CREATE TABLE effective_care AS
SELECT 
  provider_id, 
  measure_id, 
  CAST(score AS DECIMAL) score_num 
FROM effective_care_all 
WHERE length(score) < 10;

DROP TABLE measures;
CREATE TABLE measures AS
SELECT
  measure_name,
  measure_id
FROM measures_all;

DROP TABLE readmissions;
CREATE TABLE readmissions AS
SELECT
  provider_id,
  measure_id,
  CAST(score AS DECIMAL) score_num
FROM readmissions_all 
WHERE length(score) < 10;

DROP TABLE surveys_responses;
CREATE TABLE surveys_responses AS
SELECT
  provider_id,
  CAST(overall_rating_of_hospital_performance_rate AS DECIMAL(4,2)) rating,
  CAST(hcahps_base_score AS DECIMAL) base_score,
  CAST(hcahps_consistency_score AS DECIMAL) consistency_score
FROM surveys_responses_all
WHERE overall_rating_of_hospital_performance_rate NOT LIKE 'Not%';

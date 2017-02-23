DROP TABLE procedure_variance;
CREATE TABLE procedure_variance AS SELECT measure_id, variance(score_num) AS var FROM effective_care_v3 GROUP BY measure_id;

SELECT procedure_variance.measure_id, procedure_variance.var, measures.measure_name FROM procedure_variance INNER JOIN measures ON measures.measure_id=procedure_variance.measure_id ORDER BY var DESC LIMIT 10;

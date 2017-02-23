DROP TABLE measure_count_readmission;
CREATE TABLE measure_count_readmission AS SELECT provider_id, count(*) AS mynum FROM readmissions GROUP BY provider_id;

DROP TABLE hosp_readmission_thres;
CREATE TABLE hosp_readmission_thres AS SELECT provider_id FROM measure_count_readmission WHERE mynum > 10;

DROP TABLE readmission_v2;
CREATE TABLE readmission_v2 AS SELECT hosp_readmission_thres.provider_id,measure_id, score_num FROM readmissions INNER JOIN hosp_readmission_thres ON readmissions.provider_id=hosp_readmission_thres.provider_id;

DROP TABLE measure_count_effectivecare;
CREATE TABLE measure_count_effectivecare AS SELECT provider_id, count(*) AS mynum FROM effective_care GROUP BY provider_id;

DROP TABLE hosp_effectivecare_thres;
CREATE TABLE hosp_effectivecare_thres AS SELECT provider_id FROM measure_count_effectivecare WHERE mynum > 12;

DROP TABLE effective_care_v2;
CREATE TABLE effective_care_v2 AS SELECT hosp_effectivecare_thres.provider_id, measure_id, score_num FROM effective_care INNER JOIN hosp_effectivecare_thres ON effective_care.provider_id=hosp_effectivecare_thres.provider_id;

DROP TABLE joint_table;
CREATE TABLE joint_table AS SELECT effective_care_v2.provider_id
FROM effective_care_v2 
INNER JOIN readmission_v2
ON effective_care_v2.provider_id=readmission_v2.provider_id;

DROP TABLE joint_provider_id;
CREATE TABLE joint_provider_id AS SELECT distinct(provider_id) FROM joint_TABLE;

DROP TABLE effective_care_v3;
CREATE TABLE effective_care_v3 AS SELECT joint_provider_id.provider_id, measure_id, score_num FROM effective_care INNER JOIN joint_provider_id ON effective_care.provider_id=joint_provider_id.provider_id;

DROP TABLE ed_1b;
CREATE TABLE ed_1b AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num ASC)) AS percentile FROM effective_care_v3 WHERE measure_id='ED_1b';

DROP TABLE ed_2b;
CREATE TABLE ed_2b AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num ASC)) AS percentile FROM effective_care_v3 WHERE measure_id='ED_2b';

DROP TABLE imm_3;
CREATE TABLE imm_3 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num DESC)) AS percentile FROM effective_care_v3 WHERE measure_id='IMM_3_OP_27_FAC_ADHPCT';

DROP TABLE op_18;
CREATE TABLE op_18 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num ASC)) AS percentile FROM effective_care_v3 WHERE measure_id='OP_18b';
DROP TABLE op_20;
CREATE TABLE op_20 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num ASC)) AS percentile FROM effective_care_v3 WHERE measure_id='OP_20';

DROP TABLE op_21;
CREATE TABLE op_21 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num ASC)) AS percentile FROM effective_care_v3 WHERE measure_id='OP_21';

DROP TABLE op_22;
CREATE TABLE op_22 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num ASC)) AS percentile FROM effective_care_v3 WHERE measure_id='OP_22';

DROP TABLE op_29;
CREATE TABLE op_29 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num DESC)) AS percentile FROM effective_care_v3 WHERE measure_id='OP_29';

DROP TABLE op_30;
CREATE TABLE op_30 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num DESC)) AS percentile FROM effective_care_v3 WHERE measure_id='OP_30';

DROP TABLE pc_01;
CREATE TABLE pc_01 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num ASC)) AS percentile FROM effective_care_v3 WHERE measure_id='PC_01';

DROP TABLE stk_4;
CREATE TABLE stk_4 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num DESC)) AS percentile FROM effective_care_v3 WHERE measure_id='STK_4';

DROP TABLE vte_5;
CREATE TABLE vte_5 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num DESC)) AS percentile FROM effective_care_v3 WHERE measure_id='VTE_5';

DROP TABLE vte_6;
CREATE TABLE vte_6 AS SELECT provider_id, measure_id, score_num, (rank() OVER (ORDER BY score_num ASC)) AS percentile FROM effective_care_v3 WHERE measure_id='VTE_6';

DROP TABLE ultimate_table;
CREATE TABLE ultimate_table AS SELECT ed_1b.provider_id, ed_1b.percentile AS p1, ed_2b.percentile AS p2, imm_2.percentile AS p3, imm_3.percentile AS p4, op_18.percentile AS p5, op_20.percentile AS p6, op_21.percentile AS p7, op_22.percentile AS p8, op_29.percentile AS p9, op_30.percentile AS p10, pc_01.percentile AS p11, stk_4.percentile AS p12, vte_5.percentile AS p13, vte_6.percentile AS p14 
FROM ed_1b 
JOIN ed_2b ON ed_2b.provider_id=ed_1b.provider_id 
JOIN imm_2 ON imm_2.provider_id=ed_1b.provider_id 
JOIN imm_3 ON imm_3.provider_id=ed_1b.provider_id 
JOIN op_18 ON op_18.provider_id=ed_1b.provider_id 
JOIN op_21 ON op_21.provider_id=ed_1b.provider_id 
JOIN op_20 ON op_20.provider_id=ed_1b.provider_id
JOIN op_22 ON op_22.provider_id=ed_1b.provider_id 
JOIN op_29 ON op_29.provider_id=ed_1b.provider_id 
JOIN op_30 ON op_30.provider_id=ed_1b.provider_id 
JOIN pc_01 ON pc_01.provider_id=ed_1b.provider_id 
JOIN stk_4 ON stk_4.provider_id=ed_1b.provider_id 
JOIN vte_5 ON vte_5.provider_id=ed_1b.provider_id 
JOIN vte_6 ON vte_6.provider_id=ed_1b.provider_id;

DROP TABLE final_table;
CREATE TABLE final_table AS SELECT provider_id, (p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12+p13+14) AS Total FROM ultimate_table;

SELECT final_table.provider_id, final_table.Total, hospitals.hospital_name FROM final_table INNER JOIN hospitals ON final_table.provider_id=hospitals.provider_id ORDER BY Total ASC LIMIT 10;


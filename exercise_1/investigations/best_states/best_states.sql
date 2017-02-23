DROP TABLE state_table;
CREATE TABLE state_table AS SELECT final_table.provider_id, final_table.Total, hospitals.hospital_name, hospitals.state FROM final_table INNER JOIN hospitals ON final_table.provider_id=hospitals.provider_id ORDER BY Total ASC LIMIT 100;

DROP TABLE top_state;
CREATE TABLE top_state AS SELECT state, count(*) AS hosp_count FROM state_table GROUP BY state;

SELECT * FROM top_state ORDER BY hosp_count DESC LIMIT 10;

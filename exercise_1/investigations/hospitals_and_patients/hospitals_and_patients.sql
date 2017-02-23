DROP TABLE rank_corr;
CREATE TABLE rank_corr AS SELECT final_table.provider_id, final_table.total AS total_rank, (surveys_responses.base_score+surveys_responses.consistency_score) AS total_score FROM final_table JOIN surveys_responses WHERE surveys_responses.provider_id=final_table.provider_id ORDER BY final_table.provider_id;

SELECT corr(total_rank, total_score) FROM rank_corr;

DROP TABLE procedural_var;
CREATE TABLE procedural_var AS SELECT provider_id, variance(score_num) var_score FROM effective_care_v3 GROUP BY provider_id ORDER BY provider_id;

DROP TABLE procedural_var_corr;
CREATE TABLE procedural_var_corr AS SELECT procedural_var.provider_id, procedural_var.var_score, (surveys_responses.base_score+surveys_responses.consistency_score) AS total_score FROM procedural_var JOIN surveys_responses WHERE procedural_var.provider_id=surveys_responses.provider_id ORDER BY procedural_var.provider_id;

SELECT corr(var_score, total_score) FROM procedural_var_corr;

CREATE TABLE VANDAL (
	wiki_db STRING,
	event_entity STRING,
	event_type STRING,
	event_timestamp STRING,
	event_comment STRING,
	event_user_id BIGINT,
	event_user_text_historical STRING,
	event_user_text STRING,
	event_user_blocks_historical array<STRING>,
	event_user_blocks array<STRING>,
	event_user_groups_historical array<STRING>,
	event_user_groups array<STRING>,
	event_user_is_bot_by_historical array<STRING>,
	event_user_is_bot_by array<STRING>,
	event_user_is_created_by_self BOOLEAN,
	event_user_is_created_by_system BOOLEAN,
	event_user_is_created_by_peer BOOLEAN,
	event_user_is_anonymous BOOLEAN,
	event_user_registration_timestamp STRING,
	event_user_creation_timestamp STRING,
	event_user_first_edit_timestamp STRING,
	event_user_revision_count BIGINT,
	event_user_seconds_since_previous_revision BIGINT,
 	page_id BIGINT,
 	page_title_historical STRING,
 	page_title STRING,
 	page_namespace_historical INT,
 	page_namespace_is_content_historical BOOLEAN,
 	page_namespace INT,
 	page_namespace_is_content BOOLEAN,
 	page_is_redirect BOOLEAN,
 	page_is_deleted BOOLEAN,
 	page_creation_timestamp STRING,
 	page_first_edit_timestamp STRING,
 	page_revision_count BIGINT,
 	page_seconds_since_previous_revision BIGINT,
 	user_id BIGINT,
 	user_text_historical STRING,
 	user_text STRING,
 	user_blocks_historical array<string>,	
 	user_blocks array<string>,	
 	user_groups_historical array<string>,
 	user_groups array<string>,	
 	user_is_bot_by_historical array<string>,	
 	user_is_bot_by array<string>,
 	user_is_created_by_self BOOLEAN,
 	user_is_created_by_system BOOLEAN,
 	user_is_created_by_peer BOOLEAN,
 	user_is_anonymous BOOLEAN,
 	user_registration_timestamp STRING,
 	user_creation_timestamp STRING,
 	user_first_edit_timestamp STRING,
 	revision_id BIGINT,
 	revision_parent_id BIGINT,
 	revision_minor_edit BOOLEAN,
 	revision_deleted_parts array<string>,
 	revision_deleted_parts_are_suppressed BOOLEAN,
 	revision_text_bytes BIGINT,
 	revision_text_bytes_diff BIGINT,
 	revision_text_sha1 STRING,
 	revision_content_model STRING,
 	revision_content_format STRING,
 	revision_is_deleted_by_page_deletion BOOLEAN,
 	revision_deleted_by_page_deletion_timestamp STRING,
 	revision_is_identity_reverted BOOLEAN,
 	revision_first_identity_reverting_revision_id BIGINT,
 	revision_seconds_to_identity_revert BIGINT,
 	revision_is_identity_revert BOOLEAN,
 	revision_is_from_before_page_creation BOOLEAN,
 	revision_tags array<string>	
) ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH '/home/eunicelee/2020-12.enwiki.2020-12.tsv' INTO TABLE VANDAL;

SELECT COUNT(*) FROM vandal 
WHERE event_comment LIKE '%vandal%'; --51682

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q5-vandal'
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t'
SELECT event_timestamp, event_comment, page_seconds_since_previous_revision 
FROM vandal 
WHERE event_comment LIKE "%vandal%";

CREATE EXTERNAL TABLE q5_vandal_average (
	event_timestamp STRING,
	event_comment STRING,
	page_seconds_since_previous_revision BIGINT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q5-vandal';

SELECT AVG(page_seconds_since_previous_revision) AS revision_average
FROM q5_vandal_average; --332444.66 seconds = 3.85 days 

--INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q5-1'
--ROW FORMAT DELIMITED
--FIELDS TERMINATED BY '\t'
--SELECT event_entity, page_title, event_timestamp, revision_is_identity_reverted, revision_seconds_to_identity_revert
--FROM vandal  
--WHERE event_entity = 'revision' AND revision_is_identity_reverted = true
--ORDER BY revision_seconds_to_identity_revert desc;
--
--CREATE EXTERNAL TABLE q5_avg_revision (
--	event_entity STRING,
--	page_title STRING,
--	event_timestamp STRING,
--	revision_is_identity_reverted BOOLEAN,
--	revision_seconds_to_identity_revert BIGINT
--) ROW FORMAT DELIMITED
--FIELDS TERMINATED BY '\t'
--LOCATION '/user/hive/wikioutput/q5-1';

-- Use pageview_q2_en to get views and pages on December
SELECT (SUM(count_views)*5) AS totalview
FROM pageview_q2_en; -- 240,600,200/day

SELECT COUNT(page_title) AS totalpage
FROM pageview_q2_en; -- 9,939,768 

-- Average view per page: 240600200/9939768 = 24.02 views/day on each page
-- 3.85 * 24.02 = 92 people view vandalized page before reversed



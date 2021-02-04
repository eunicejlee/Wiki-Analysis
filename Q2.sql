-- Create table for pageview_q2 
-- pageview_q2: pageview from December 2020
CREATE TABLE pageview_q2 (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

-- Load files to pageview_q2 
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20201206-080000' INTO TABLE pageview_q2;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20201212-180000' INTO TABLE pageview_q2;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20201218-010000' INTO TABLE pageview_q2;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20201224-100000' INTO TABLE pageview_q2;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20201231-180000' INTO TABLE pageview_q2;

-- pageview_q2_en: domain_code='en','en.m'
CREATE TABLE pageview_q2_en (
	page_title STRING,
	count_views INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ' ';

INSERT INTO pageview_q2_en PARTITION (domain_code = 'en')
SELECT page_title, count_views FROM pageview_q2 WHERE domain_code = 'en';
INSERT INTO pageview_q2_en PARTITION (domain_code = 'en.m')
SELECT page_title, count_views FROM pageview_q2 WHERE domain_code = 'en.m';


INSERT OVERWRITE DIRECTORY '/user/hive/wikioutout/q2-pageview-sum'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, ((SUM(count_views)*5)*31) AS totalcount
FROM pageview_q2_en
GROUP BY page_title
ORDER BY totalcount DESC;

CREATE EXTERNAL TABLE q2_pageview_final(
	page_title STRING,
	totalcount INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutout/q2-pageview-sum';
  
-- Create link view table 
-- internal_view: partitioned by type = link
CREATE TABLE internal_view (
	prev STRING,
	curr STRING,
	numpair INT
) PARTITIONED BY (type STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

INSERT INTO internal_view PARTITION(type = 'link')
SELECT prev, curr, numpair FROM clickstream WHERE type = 'link';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutout/q2-internal-count'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT prev, SUM(numpair) AS linkcount
FROM internal_view 
GROUP BY prev
ORDER BY linkcount DESC;

CREATE EXTERNAL TABLE q2_link_final (
	prev STRING,
	linkcount INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutout/q2-internal-count';

-- query for result
SELECT pageview.page_title, linkview.linkcount, pageview.totalcount AS total, 
ROUND(linkview.linkcount/pageview.totalcount, 5) AS fraction
FROM q2_pageview_final AS pageview
INNER JOIN q2_link_final AS linkview
ON pageview.page_title = linkview.prev
WHERE pageview.totalcount > 5000
ORDER BY fraction DESC;

-- To get counts of fraction < 1 and fraction > 1

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q2-experiment'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT pageview.page_title, linkview.linkcount,, pageview.totalcount AS total, 
ROUND(linkview.linkcount/pageview.totalcount, 5) AS fraction
FROM q2_pageview_final AS pageview
INNER JOIN q2_link_final AS linkview
ON pageview.page_title = linkview.prev
WHERE pageview.totalcount > 100000
ORDER BY fraction DESC;
 
CREATE EXTERNAL TABLE q2_experiment (
	page_title STRING,
	linkcount INT,
	total INT,
	fraction DOUBLE
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q2-experiment';

SELECT COUNT(fraction)
FROM q2_experiment 
WHERE fraction > 1; --fraction<1: 6629 fraction>1: 217

CREATE TABLE PAGEVIEW (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
)ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '; 

LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20210120-000000' INTO TABLE pageview;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20210120-100000' INTO TABLE pageview;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20210120-120000' INTO TABLE pageview;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20210120-140000' INTO TABLE pageview;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20210120-160000' INTO TABLE pageview;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20210120-180000' INTO TABLE pageview;

SELECT * FROM pageview
where domain_code='en';

CREATE TABLE PAGEVIEW_EN (
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

INSERT INTO PAGEVIEW_EN PARTITION(domain_code = 'en')
SELECT page_title, count_views, total_response_size FROM PAGEVIEW WHERE domain_code = 'en';

INSERT INTO PAGEVIEW_EN PARTITION(domain_code = 'en.m')
SELECT page_title, count_views, total_response_size FROM PAGEVIEW WHERE domain_code = 'en.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM pageview_en 
GROUP BY page_title
ORDER BY views DESC 
LIMIT 10;

CREATE EXTERNAL TABLE q1_final (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q1';


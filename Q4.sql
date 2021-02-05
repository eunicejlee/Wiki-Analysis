CREATE TABLE q4_pageview (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

LOAD LOCAL DATA INPATH '/home/eunicelee/pageviews-20210120-140000' INTO TABLE q4_pageview;
LOAD LOCAL DATA INPATH '/home/eunicelee/pageviews-20210120-150000' INTO TABLE q4_pageview;
LOAD LOCAL DATA INPATH '/home/eunicelee/pageviews-20210120-190000' INTO TABLE q4_pageview;
LOAD LOCAL DATA INPATH '/home/eunicelee/pageviews-20210120-210000' INTO TABLE q4_pageview;
LOAD LOCAL DATA INPATH '/home/eunicelee/pageviews-20210120-220000' INTO TABLE q4_pageview;

CREATE TABLE q4_pageview_en (
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

INSERT INTO q4_pageview_en PARTITION(domain_code = 'en')
SELECT page_title, count_views, total_response_size FROM q4_pageview WHERE domain_code = 'en';
INSERT INTO q4_pageview_en PARTITION(domain_code = 'en.m')
SELECT page_title, count_views, total_response_size FROM q4_pageview WHERE domain_code = 'en.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q4-result'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS page_views
FROM q4_pageview_en
GROUP BY page_title
ORDER BY page_views DESC
LIMIT 15;




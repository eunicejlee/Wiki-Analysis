CREATE TABLE q6_pageview (
	domain_code STRING,
	page_title STRING,
	count_views INT,
	total_response_size INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20201212-150000' INTO TABLE q6_pageview;
LOAD DATA LOCAL INPATH '/home/eunicelee/pageviews-20201212-160000' INTO TABLE q6_pageview;

  
-- USA

CREATE TABLE q6_pageview_en(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

INSERT INTO q6_pageview_en PARTITION(domain_code = 'en')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'en';
INSERT INTO q6_pageview_en PARTITION(domain_code = 'en.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'en.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_en'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_en 
GROUP BY page_title
ORDER BY views DESC 
LIMIT 10;

CREATE EXTERNAL TABLE q6_en (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_en';

SELECT page_title, SUM(views) AS totalview
FROM q6_en
GROUP BY page_title
ORDER BY totalview DESC;


-- Germany

CREATE TABLE q6_pageview_de(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '; 

INSERT INTO q6_pageview_de PARTITION(domain_code = 'de')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'de';
INSERT INTO q6_pageview_de PARTITION(domain_code = 'de.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'de.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_de'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_de 
GROUP BY page_title
ORDER BY views DESC;

CREATE EXTERNAL TABLE q6_de (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_de';

SELECT page_title, SUM(views) AS totalview
FROM q6_de
GROUP BY page_title
ORDER BY totalview DESC;

-- France

CREATE TABLE q6_pageview_fr(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

INSERT INTO q6_pageview_fr PARTITION(domain_code = 'fr')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'fr';
INSERT INTO q6_pageview_fr PARTITION(domain_code = 'fr.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'fr.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_fr'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_fr 
GROUP BY page_title
ORDER BY views DESC;

CREATE EXTERNAL TABLE q6_fr (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_fr';

SELECT page_title, SUM(views) AS totalview
FROM q6_fr
GROUP BY page_title
ORDER BY totalview DESC;

-- Japan

CREATE TABLE q6_pageview_ja(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '; 

INSERT INTO q6_pageview_ja PARTITION(domain_code = 'ja')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'ja';
INSERT INTO q6_pageview_ja PARTITION(domain_code = 'ja.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'ja.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_ja'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_ja 
GROUP BY page_title
ORDER BY views DESC;

CREATE EXTERNAL TABLE q6_ja (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_ja';

SELECT page_title, SUM(views) AS totalview
FROM q6_ja
GROUP BY page_title
ORDER BY totalview DESC;

-- Spain

CREATE TABLE q6_pageview_es(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '; 

INSERT INTO q6_pageview_es PARTITION(domain_code = 'es')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'es';
INSERT INTO q6_pageview_es PARTITION(domain_code = 'es.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'es.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_es'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_es 
GROUP BY page_title
ORDER BY views DESC;

CREATE EXTERNAL TABLE q6_es (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_es';

SELECT page_title, SUM(views) AS totalview
FROM q6_es
GROUP BY page_title
ORDER BY totalview DESC;

-- Korea

CREATE TABLE q6_pageview_ko(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '; 

INSERT INTO q6_pageview_ko PARTITION(domain_code = 'ko')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'ko';
INSERT INTO q6_pageview_ko PARTITION(domain_code = 'ko.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'ko.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_ko'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_ko 
GROUP BY page_title
ORDER BY views DESC;

CREATE EXTERNAL TABLE q6_ko (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_ko';

SELECT page_title, SUM(views) AS totalview
FROM q6_ko
GROUP BY page_title
ORDER BY totalview DESC;

-- Taiwan

CREATE TABLE q6_pageview_zh(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '; 

INSERT INTO q6_pageview_zh PARTITION(domain_code = 'zh')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'zh';
INSERT INTO q6_pageview_zh PARTITION(domain_code = 'zh.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'zh.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_zh'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_zh 
GROUP BY page_title
ORDER BY views DESC;

CREATE EXTERNAL TABLE q6_zh (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_zh';

SELECT page_title, SUM(views) AS totalview
FROM q6_zh
GROUP BY page_title
ORDER BY totalview DESC;

-- Brazil

CREATE TABLE q6_pageview_pt(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '; 

INSERT INTO q6_pageview_pt PARTITION(domain_code = 'pt')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'pt';
INSERT INTO q6_pageview_pt PARTITION(domain_code = 'pt.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'pt.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_pt'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_pt 
GROUP BY page_title
ORDER BY views DESC;

CREATE EXTERNAL TABLE q6_pt (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_pt';

SELECT page_title, SUM(views) AS totalview
FROM q6_pt
GROUP BY page_title
ORDER BY totalview DESC;

-- Italy

CREATE TABLE q6_pageview_it(
	page_title STRING,
	count_views INT,
	total_response_size INT
) PARTITIONED BY (domain_code STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' '; 

INSERT INTO q6_pageview_it PARTITION(domain_code = 'it')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'it';
INSERT INTO q6_pageview_it PARTITION(domain_code = 'it.m')
SELECT page_title, count_views, total_response_size FROM q6_pageview WHERE domain_code = 'it.m';

INSERT OVERWRITE DIRECTORY '/user/hive/wikioutput/q6_it'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, SUM(count_views) AS views
FROM q6_pageview_it 
GROUP BY page_title
ORDER BY views DESC;

CREATE EXTERNAL TABLE q6_it (
	page_title STRING,
	views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutput/q6_it';

SELECT page_title, SUM(views) AS totalview
FROM q6_it
GROUP BY page_title
ORDER BY totalview DESC;

-- To get total views for each country
SELECT SUM(views) AS view from q6_<country domain_code goes here>;




INSERT OVERWRITE DIRECTORY '/user/hive/wikioutout/q3-pageview'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT page_title, count_views 
FROM pageview_q2_en
ORDER BY count_views DESC

-- pageview data from #2 with SUM(count_views)
CREATE EXTERNAL TABLE q3_pageview(
	page_title STRING,
	count_views INT
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutout/q3-pageview';

-- Start from Hotel_California
INSERT OVERWRITE DIRECTORY '/user/hive/wikioutout/q3-hc-1'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT pageview.page_title AS referrer, link.curr AS requested, link.linkcount AS link_click, pageview.pageviewcount AS page_views, 
ROUND(link.linkcount/pageview.pageviewcount, 4) AS fraction
FROM
(SELECT page_title, ((SUM(count_views*5)*31)) AS pageviewcount
FROM q3_pageview 
GROUP BY page_title) AS pageview 
JOIN
(SELECT prev, curr, SUM(numpair) AS linkcount
FROM internal_view
GROUP BY prev, curr) AS link
ON page_title = link.prev
WHERE pageview.page_title = 'Hotel_California'
ORDER BY fraction DESC
LIMIT 10;

CREATE EXTERNAL TABLE q3_hc(
	referrer STRING,
	requested STRING,
	link_clicked INT,
	page_views INT,
	fraction DOUBLE
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutout/q3-hc-1';
 
-- Next Series: Hotel_California_(Eagles_album)
INSERT OVERWRITE DIRECTORY '/user/hive/wikioutout/q3-hc-2'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT pageview.page_title AS referrer, link.curr AS requested, link.linkcount AS link_click, pageview.pageviewcount AS page_views,   
ROUND(link.linkcount/pageview.pageviewcount, 4) AS fraction
FROM
(SELECT page_title, ((SUM(count_views)*5)*31) AS pageviewcount
FROM q3_pageview 
GROUP BY page_title) AS pageview 
JOIN
(SELECT prev, curr, SUM(numpair) AS linkcount
FROM internal_view
GROUP BY prev, curr) AS link
ON pageview.page_title = link.prev
WHERE pageview.page_title = 'ARTICLE TITLE GOES HERE'
ORDER BY fraction DESC
LIMIT 10;

CREATE EXTERNAL TABLE q3_hc_eagles(
	referrer STRING,
	requested STRING,
	link_clicked INT,
	page_views INT,
	fraction DOUBLE
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutout/q3-hc-2';

-- Next Series: The_Long_Run_(album)
-- The next article that had largest for readers to click on internal links
INSERT OVERWRITE DIRECTORY '/user/hive/wikioutout/q3-hc-3'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
SELECT pageview.page_title AS referrer, link.curr AS requested, link.linkcount AS link_click, pageview.pageviewcount AS page_views,   
ROUND(link.linkcount/pageview.pageviewcount, 4) AS fraction
FROM
(SELECT page_title, (SUM(count_views*5)*31) AS pageviewcount
FROM q3_pageview 
GROUP BY page_title) AS pageview 
JOIN
(SELECT prev, curr, SUM(numpair) AS linkcount
FROM internal_view
GROUP BY prev, curr) AS link
ON pageview.page_title = link.prev
WHERE pageview.page_title = 'The_Long_Run_(album)'
ORDER BY fraction DESC
LIMIT 10;

CREATE EXTERNAL TABLE q3_hc_longrun(
	page_title STRING,
	curr STRING,
	linkcount INT,
	pageviewcount INT,
	fraction DOUBLE
) ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hive/wikioutout/q3-hc-3';
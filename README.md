# Wiki-Analysis
- Project 1 will consist of using big data tools to answer questions about datasets from Wikipedia. There are a series of basic analysis questions.
- The questions should be answered using Hive or MapReduce. Feel free to use whichever tool seems best to you given the question or a combination of the two. For each question you should have a repeatable process that would work on a larger dataset, not just an ad hoc calculation.
- You will have to make some assumptions and simplfications in order to answer these questions. Make sure those assumptions/simplifications and the reasoning for them are included in your answer. At the very least, restricting the time period of your analyses will make some of these questions easier to answer.
- You may find it useful to produce intermediate results from the input datasets. Include a brief overview of these transformations and the intermediate results you produce in your presentation.

1. Which English wikipedia article got the most traffic on January 20, 2021?
2. What English wikipedia article has the largest fraction of its readers follow an internal link to another wikipedia article?
3. What series of wikipedia articles, starting with Hotel California, keeps the largest fraction of its readers clicking on internal links? This is similar to (2), but you should continue the analysis past the first article. There are multiple ways you can count this fraction, be careful to be clear about the method you find most appropriate.
4. Find an example of an English wikipedia article that is relatively more popular in the Americas than elsewhere. There is no location data associated with the wikipedia pageviews data, but there are timestamps. You'll need to make some assumptions about internet usage over the hours of the day.
5. Analyze how many users will see the average vandalized wikipedia page before the offending edit is reversed.
6. Run an analysis you find interesting on the wikipedia datasets we're using.

## Links for data
- Pageviews Filtered to Human Traffic
https://wikitech.wikimedia.org/wiki/Analytics/Data_Lake/Traffic/Pageviews
- Page Revision and User History
https://wikitech.wikimedia.org/wiki/Analytics/Data_Lake/Edits/Mediawiki_history_dumps#Technical_Documentation
- Monthly Clickstream
https://meta.wikimedia.org/wiki/Research:Wikipedia_clickstream

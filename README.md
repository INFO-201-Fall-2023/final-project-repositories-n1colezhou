# final-project-repositories-n1colezhou
final-project-repositories-n1colezhou created by GitHub Classroom

STORY PITCH:

For students, parents, and teachers in recent years, campus safety has become an increasingly urgent worry, and for good reason. The rise in campus shootings and other violent crimes has brought the safety of universities into question, forcing us to examine whether these are truly safe places to live and study. That's why our project aims to provide a comprehensive analysis of the safety of universities by comparing their crime rates with those of their surrounding areas.

We won't stop at just looking at the numbers. Our investigation will delve deeper, examining different types of crimes, including theft, assault, sexual offenses, and drug-related incidents. We will analyze crime statistics and reports from various universities across the United States, comparing the crime rates in universities with the overall crime rates of their respective areas. By doing so, we will provide a data-driven analysis of the safety of universities that goes beyond just the numbers.

Our mission is to empower individuals to make informed decisions about their safety and well-being while attending university. We want to spark a conversation about campus safety and encourage universities to prioritize the safety of their students and faculty. By examining the measures universities are taking to address campus safety, we can identify best practices that other universities can adopt. Our investigation aims to highlight the effectiveness of safety measures and identify areas where improvements are needed.

Our story will be of interest to anyone concerned about campus safety, including students, parents, and educators. We believe that our investigation will provide valuable insights into the safety of universities and help individuals make informed decisions about where to attend university. We know that a safe environment is crucial for students to thrive, and our investigation aims to make that a reality.

In conclusion, our investigation into the safety of universities is a timely and crucial topic that demands attention. By providing a comprehensive analysis of the safety of universities and their surrounding communities, we hope to empower individuals to make informed decisions about their safety and well-being while attending university. Ultimately, we believe that by highlighting the importance of campus safety, we can help universities create safer environments for their students and faculty, paving the way for a brighter future.


DATA SOURCES:

Crime in the United States, Offense and Population Percent Distribution by Region, 2018 - we will use the FBI's Uniform Crime Reporting (UCR) Program data to obtain crime rates in universities and surrounding areas. We will download the data from the FBI's website: https://www.fbi.gov/services/cjis/ucr
  - Downloaded data from a web URL
  - Data is collected by the FBI UCR division. It contains a compilation of the volume and rate of violent and property crime offenses for the nation and by state using Summary Reporting System data and summarized data from the National Incident-Based Reporting System (NIBRS). Data at the level of local law enforcement agencies are also provided for those contributors supplying 12 months of complete offense data. This report includes arrests, clearances, trends, and law enforcement employee data.
  - 4 observations
  - 11 features

Campus Safety and Security Data - we will use data collected by the U.S. Department of Education's Campus Safety and Security (CSS) Program to obtain information on campus safety policies and procedures. https://www2.ed.gov/admins/lead/safety/campus.html
  - Downloaded data from a web URL
  - Data files include all data submitted through the Campus Safety and Security Survey during 2016-2018. Each annual survey collects data for the previous three calendar years which allows institutions to correct previously submitted data in a subsequent collection year. Data files are created immediately following each data collection and therefore do not include any corrections made following the close of the selected collection year. The data is taken from the US Department of Education, and the data is about reported crimes on university campus's across America.
  - 11,011 observations
  - 3 features

BACKGROUND RESEARCH/INSPIRATION:

"The Top 10 Safest Colleges in America in 2021" - an article by SafeWise that ranks the safest colleges in the United States: https://www.safewise.com/blog/safest-college-towns-america/
  - This article lists the safest and most dangerous college towns in this country, which provides a reference to our analysis
  - This article presents an opinion that small towns may not equal to safety

“College Campus Safety: Questions to Ask” - an article by US News listing safety-related questions college should consider:
https://www.usnews.com/education/best-colleges/applying/articles/college-campus-safety-questions-to-ask
  - The article lists safety-related questions that universities should consider, which is also part of our study as we are looking for both safety problems and      responses
  - This article is not a statistical report, so there is no data mentioned, but we will make analysis based on the crime data

“Campus Safety Guide” - an blog by BestColleges.com demonstrates the common crimes on college campus and tips for students to saty safe:
https://www.bestcolleges.com/resources/campus-safety-guide/
  - This article uses dataset from one of the same sources as we do, but we are on different analysis
  - The safety tips can be helpful as we are also looking at the universities response on safety concerns

“The Safest College in the US is in the Midwest, According to a New Ranking” - a news report by NBC Chicago lists the 10 safest colleges in the United States:
https://www.nbcchicago.com/news/local/the-safest-college-in-the-us-is-in-the-midwest-according-to-a-new-ranking/2953742/
  - This report finds out that the most safest college sits in the Midwest, which gives us a hint that suburban and rural campuses are likely to be safer than urban areas, we can make our own analysis and compare our results to this list for further study
  - The list in the article comes from a third party source, which we may use it as a external references to enhance our understanding of the topic

“Students Mostly Feel Safe on College Campuses, but Not Equally So” - an article by InsideHigherEd.com reports whether students feel safe on campus and their concerns:
https://www.insidehighered.com/news/2022/06/22/survey-campuses-perceived-safe-some-students-not-all 
  - This article collects its own data and takes geospatial factors into account, which is also a point we plan to dive in
  - The article discusses other factors like police intervention which may affects its conclusion, creating a different perspective to our study

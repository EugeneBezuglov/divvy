# Divvy (Cyclistic)

These are parts of my final project on the road to getting the Google Data Analytics Professional Certificate.

## Notes:

1. The entire project was initially done in R; however I chose to create a PostgreSQL 15 database on my PC and clean and wrangle data using SQL, too.

2. The final report is composed as if I reported to the head of analytics — the report is long. If I were to report to stakeholders who prefer shorter reports, I would obviously create a shorter report.

# Review

I analyzed the data of a bike-sharing company, Cyclistic, which is a fictional name for [Divvy](https://divvybikes.com/about), a real Chicago-based bike-sharing company. I was given the 12 months of their ridership data and had to find how Divvy annual members use bikes differently from the casual riders.

The analysis report is available in [PDF](https://github.com/EugeneBezuglov/divvy/blob/main/R/Divvy_markdown.pdf). Additional Tableau visualization are available [here](https://public.tableau.com/app/profile/eugene8546/viz/Story_Divvy/StoryDivvy).

The report covers my process of wrangling, cleaning, analysing, and visualizing data. Also, in the very last section I share recommendations for the stakeholders.

This report is also available on [Kaggle](https://www.kaggle.com/code/johncornish/divvy) as RMarkdown script. (However, the spatial analysis part isn't available on Kaggle due to Kaggle current limitations with Stamen Maps)

# Data

The data for this project is a [public data set](https://divvy-tripdata.s3.amazonaws.com/index.html) provided by Divvy. It
has been made available by Motivate International Inc. under this [license](https://ride.divvybikes.com/data-license-agreement).

No riders’ personally identifiable information is provided.

# Folders and files

R code is in the "R" folder, SQL code is in the "SQL" folders. 

* Divvy_markdown.pdf is a final report file.
* DivvyBikes_v2_script.R is the script I used for this project. A huge part of the script has already been deleted, including filling NA values, because it wasn't relevant for the project. Yet, not all the code from the script went into the final report.
* SQL.sql holds all the SQL code for this project in the right order of execution. Separate queries are in separate files, too; they are self-evident so I won't describe them.




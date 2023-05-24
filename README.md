# first_project

This project uses data about video games rated on metacritic.com in terms of scores from the meta's rating system and the number of user ratings. Through the parameters in the dataset, a data analysis process is performed to retrieve important information and evaluate the video games market in the period 1995 - 2021.

#The Video Games Dataset 1995 - 2021 Metacritic
https://www.kaggle.com/datasets/deepcontractor/top-video-games-19952021-metacritic

#SQL
Starting with SQL, data queries will be performed to find the insights needed for data analysis. 
The procedure is performed as follows:
•	Total number of games on different platforms.
•	Ranking games by year, assessed by meta score and user score.
•	The scores of the games in each platform are different, so an average score will be taken to aggregate the scores and drop duplicates.
•	Comparison between meta score and user score.
•	Sort the games that are underrated by the meta score by ranking the games that are below average and have the biggest difference between the meta score and the user score.
•	Do the same thing with the user score. Save to an excel file to continue with the next visualization.

#Tableau
Visualize the previously mentioned queries.

•	The first sheet shows the size of each platform during the period.
•	The next sheet describes the number of games released for the period 1995 - 2021 and the forecast to 2024. Where the release year is converted to quarters to indicate trends over the period.
•	The scores of the games in each platform are different, so an average score will be taken to aggregate the scores and drop duplicates.
•	The third sheet visually compares the mean scores of the two parameters, the meta score and the user review, over the mentioned time period.
•	The final sheet uses data of underrated games from the user's point of view and the trends of such games over the time period in question.
•	Consolidate all the sheets into a dashboard for a complete dashboard.

#Python
Analysis of available data and their data correlation
•	import the necessary packages for programming
•	Clean up information and convert data types to facilitate data analysis.
•	Run a scatter plot to analyze the correlation between meta score and user review.
•	Convert the data to the appropriate type to facilitate correlation analysis.
•	Correlation matrix is set to show the correlation of the whole dataset.
•	In order not to affect the data platform, the boxplot of the average meta score and the user score is displayed afterwards.

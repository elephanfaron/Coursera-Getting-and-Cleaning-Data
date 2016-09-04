---
output: html_document
---
#Coursera: Getting and Cleaning Data
#End course project

##raw data
The raw data can be downloaded at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Then refer to readme.txt for details on the data. 

The following link contains information on the data set. 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


##run_analysis.R
The script performs the following actions:  
* Reads the train and test dataset into R and merges them to create one data set (named dataset)  
* Extracts only the measurements on the mean and standard deviation for each measurement  
Note that "meanfreq"" and "angle" measurements were not kept.   
* Uses descriptive activity names to name the activities in the data set  
* Appropriately labels the data set with descriptive variable names  
Mainly removing parenthesis and "-"  
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject (named meanDS)    
* Exports both data sets to txt files in a new folder named "tidy data"   

##requirements
unzip the data, set "UCI HAR Dataset" as the working directory in R and run the R script.   
The script requires the dplyr package. 

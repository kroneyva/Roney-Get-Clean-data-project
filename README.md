# Roney-Getting-Cleaning-data-project
End of class project for Coursea Getting & Cleaning Data Course presented by John Hopkins University.
This project consists of developing an R script that produced a tidy data file representing the mean and standard deviation of data representing a smart phone body worn digital activity meter.  The data was obtained at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  
The R script
  1.  Downloads the data file into a directory on the users computer.
  2.  Unzips the file into a folder.
  3.  The test and training unzipped files of the user digital activity data is read into 3 data frames for each file set.  Only the variable data respresenting mean and standard deviation is selected.
  4.  The 3 data frames for each test and training are combined into respectively combined data frame.
  5.  The rssulting test and training combined data frame is merge into a single data frame.
  6.  Using this single data frame a tidy.txt file is generate that averagesthe variable data for each activity and subject.  

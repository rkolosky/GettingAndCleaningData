---
title: "CodeBook.md"
author: "Rob Kolosky"
date: "Saturday, November 22, 2014"
output: html_document
---


The script run_analysis.R is an R script that downloads a data set and then extracts a tidy data set that contains the averages for each kind of activity in the original data.

##Data:
The original data set is from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script creates a local working directory, data, and downloads the dataset there. It then unzips the dataset and changes to that directory for the remainder of the run.

The dataset contains activity_labels.txt and features.txt which are used to apply to the data. The actual data is from two directories, test and train, which each contain an X and Y dataset as well as a dataset describing the activities.

##Variables
The X, Y, and subject datasets are loaded from the files downloaded. Each dataset is loaded from the test and train folders, then they are combined into a single dataset by using rbind().

After some transformations to remove unwated data, X, Y, and Subject datasets are combined into a single large dataset by using cbind().

##Transformations
The X dataset was initally loaded with all of the columns. But, it was trimmed to just the columns that contains the word "mean" or "std" in the column name. 

The final tidy dataset was created using the ddply() command to output the colMeans() for each column in the dataset.
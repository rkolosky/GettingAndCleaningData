######################################################
# Getting and CLeaning Data Peer Assignment
#
# Download data set from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Datas# et.zip 
#
# Create an R script that dos the following:
# - Merges the training and the test sets to create one data set.
# - Extracts only the measurements on the mean and standard deviation for each
#    measurement. 
# - Uses descriptive activity names to name the activities in the data set
# - Appropriately labels the data set with descriptive variable names. 
# - From the data set in step 4, creates a second, independent tidy data set with
#    the average of each variable for each activity and each subject.
#
#####################################################

#Step 0 
#Load the plyr library
library(plyr)

#Download file and extract
if(!file.exists("./data")){
  dir.create("./data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="./data/dataset.zip")
setwd("./data")
unzip("dataset.zip")
setwd("./UCI HAR Dataset")

#Setp 1
#Merge the datasets to create one data set
#Grab the training data
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
sub_train <- read.table("train/subject_train.txt")

#Grab the test data
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
sub_test <- read.table("test/subject_test.txt")

#Merge X data
x <- rbind(x_train,x_test)

#Merge y data
y <- rbind(y_train,y_test)

#Merge subject data
subject <- rbind(sub_train,sub_test)

#Step 2
#Extract only the measurements for mean and standard deviation
#Load features
features <- read.table("features.txt")

#Grab only the columns with "mean" or "std" in the name
meanStd <- grep("-(mean|std)\\(\\)",features[,2])

#Subset the X data
x <- x[,meanStd]

#Correct column names
names(x) <- features[meanStd,2]

#Step 3
#Use descriptive activity names to name the activities in the data set
#Grab the activity names
activity <- read.table("activity_labels.txt")

#Update values with activity names
y[,1] <- activity[y[,1],2]

#Correct coloumn name
names(y) <- "activity"

#Step 4
#Appropriately labels the data set with descriptive variable names
#Correct column name
names(subject) <- "subject"

#Corral everything into a single data block
all <- cbind(x,y,subject)

#Step 5
#From the data set in step 4, creates a second, independent tidy data set with
#the average of each variable for each activity and each subject.
avg_data <- ddply(all, .(subject, activity), function(x) colMeans(x[, 1:66]))

#Write the data out
write.table(avg_data, "avg_data.txt", row.name=FALSE)
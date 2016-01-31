#this is the project for the Data Cleaning Class.
# Scott Alberts, January 2016

#add packages
library(dplyr)
library(tidyr)

#set stuff up - use "wearable" as the general name for things
# variables to handle path, dir and file names
dir.wearable <- paste(getwd(),"wearable")
training.csv <- paste(dir.wearable,"training.csv")
test.cscv <- paste(dir.wearable,"test.csv")
zipFile <- paste(dir.wearable,"UCI HAR Dataset.zip")

# if data folder does not exist, create it and make it the workign directory
if(!file.exists(dir.wearable)) {dir.create(dir.wearable)}

#set the working directory, if needed
#setwd(paste(getwd(),"/Wearable",sep=""))
setwd("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable")

#Get the data from here
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# if you haven't downloaded it yet, download the file.
if(!file.exists(zipFile)) {
      WHAurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(WHAurl, exdir=dir.wearable, destfile=zipFile)
      }

# unzip it if you haven't already
if(!file.exists(training.csv)){
      unzip(zipFile, exdir="")
}

# read the tables into R
activity_labels <- read.table("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable/UCI HAR Dataset/activity_labels.txt")
features <- read.table("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable/UCI HAR Dataset/features.txt")
X_train <- read.table("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable/UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
X_test  <- read.table("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable/UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
y_train <- read.table("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable/UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("C:/Users/salberts/Google Drive/My Documents/R stuff/Coursera/Wearable/UCI HAR Dataset/test/subject_test.txt")

# Extract only the data on mean and standard deviation
featuresDesired <- grep(".*mean.*|.*std.*", features[,2])
featuresNames <- features[featuresDesired,2]
featuresDesired.names = gsub('-mean', 'Mean', featuresNames)
featuresDesired.names = gsub('-std', 'Std', featuresDesired.names)

#smush the full dataset together
traindesired <- X_train[featuresDesired]
testdesired<- X_test[featuresDesired]
train <-cbind(subject_train, y_train, traindesired)
test <- cbind(subject_test, y_test, testdesired)
merged_full <-rbind(test,train)
colnames(merged_full) <- c("subject", "activity", featuresDesired.names)

#make subjects and activities into factors
merged_full$activity <- factor(merged_full$activity, levels = activity_labels[,1], labels = activity_labels[,2])
merged_full$subject <- as.factor(merged_full$subject)

#Create the tidy data set; save it to a file
write.table(merged_full, "tidy.txt", row.names = FALSE, quote = FALSE)

#Create the summary data of means for each subject and activity
by_subject <- merged_full %>% select(-activity) %>% group_by(subject) %>% summarize_each(funs(mean))
by_activity <- merged_full %>% select(-subject) %>% group_by(activity) %>% summarize_each(funs(mean))

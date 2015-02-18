library(reshape2)

# set the current working directory;  assume that the dataset was exploded into the same directory
# as the code
setwd("C:/Users/eshneken/Coursera/Cleaning Data/getting_and_cleaning_data_project/UCI HAR Dataset");

## Common feature and activity label data
#
# read the features and activity labels into dataframes and provide proper labels to the columns
activityLabels <- read.table("activity_labels.txt"); colnames(activityLabels) <- c("activityCode", "activityDesc")
featureLabels <- read.table("features.txt"); colnames(featureLabels) <- c("featureId", "featureDesc")

## Read in and process the test data
#
# read the raw test data, subject codes, and activity codes and apply human readable column labels
setwd("./test")
subjectCodesTest <- read.table("subject_test.txt"); colnames(subjectCodesTest) <- c("subjectCode")
activityCodesTest <- read.table("y_test.txt"); colnames(activityCodesTest) <- c("activityCode")
dataTest <- read.table("x_test.txt"); colnames(dataTest) <- featureLabels$featureDesc;

# prepend each row with the subject code as well as string indicating that this is a test data set.
# then merge the activity descriptions in by the activity code and 
# once the activity description is in we can remove the activity code since it is a duplicate
sampleType <- rep("TEST", each=nrow(dataTest))
dataTest <- cbind(sampleType, dataTest)

dataTest <- cbind (subjectCodesTest, dataTest)

dataTest <- cbind (dataTest, activityCodesTest)
dataTest <- merge(dataTest, activityLabels, by.x="activityCode", by.y="activityCode")
dataTest$activityCode <- NULL

## Read in and process the training data
#
# read the raw test data, subject codes, and activity codes and apply human readable column labels
setwd("../train")
subjectCodesTrain <- read.table("subject_train.txt"); colnames(subjectCodesTrain) <- c("subjectCode")
activityCodesTrain <- read.table("y_train.txt"); colnames(activityCodesTrain) <- c("activityCode")
dataTrain <- read.table("x_train.txt"); colnames(dataTrain) <- featureLabels$featureDesc;

# prepend each row with the subject code as well as string indicating that this is a training data set.
# then merge the activity descriptions in by the activity code and 
# once the activity description is in we can remove the activity code since it is a duplicate
sampleType <- rep("TRAIN", each=nrow(dataTrain))
dataTrain <- cbind(sampleType, dataTrain)

dataTrain <- cbind (subjectCodesTrain, dataTrain)

dataTrain <- cbind (dataTrain, activityCodesTrain)
dataTrain <- merge(dataTrain, activityLabels, by.x="activityCode", by.y="activityCode")
dataTrain$activityCode <- NULL

## Combine the training and testing dataset into a single dataset
tidyDataSet <- rbind(dataTest, dataTrain)

## Remove all the measurements which are not means or standard deviations
for(x in colnames(tidyDataSet)) {
  if(!grepl("-mean()", x) & !grepl("-std()", x) & x != "activityDesc" & x != "subjectCode" & x != "sampleType")
    tidyDataSet[x] <- NULL
}

## create the summary dataset by melting it and then taking the mean according to the subject & activity
meltedData <- melt(tidyDataSet, id = c("activityDesc", "subjectCode", "sampleType"))
summaryData <- dcast(meltedData, subjectCode + activityDesc ~ variable, mean)

## output the table
setwd("../../")
write.table(summaryData, file="summary_data.txt", row.name=FALSE)

# Data Dictionary for UCI Machine Learning Post Processed DataSet

The dataset is organized as a table with 180 observations and 81 variables.

Each observation corresponds to the mean of each measurement across the specified subject and activity.

There are 30 unique subjects who were measured across 6 unique activities;  hence there are 180 observations.

The following is the columnar layout of the dataset:

1. subjectCode:  The unique identifier of the subject with a range of 1-30
1. activityDesc: The activity being performed by the subject while sampled corresponding to:
	1. LAYING
	1. SITTING
	1. STANDING
	1. WALKING
	1. WALKING_DOWNSTAIRS
	1. WALKING_UPSTAIRS

Columns 3 - 81 correspond to the average measurements, corresponding to the unique grouping of columns 1 & 2 for the following variables:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

and their mean(), std(), and freqMean() measurements as applicable.

The column names in the dataset are labeled in a readable fashion.
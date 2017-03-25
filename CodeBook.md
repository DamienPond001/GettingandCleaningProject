# Getting and Cleaning Data
## Course Project

For this project, it was required that datasets as downloaded at 
[link]( https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) be merged into a single data set (further information describing aspects of the data at [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)). From this merged data, a "tidy" dataset was then to be formed. The procedure involved in the merging and tidying of the data is as described in the accompanying README file.

Here, the contents of the tidy dataset are described. The tidy data set has 6 columns:

* Subjects - Participant numbers:
    * 1-30
    
    
* Activity_Labels - Activities the particpants had to perform
    * WALKING
    * WALKING_UPSTAIRS
    * WALKING_DOWNSTAIRS
    * SITTING
    * STANDING
    * LAYING


* Feature - variables used on the feature vector
    * tBodyAcc - time domain body acceleration signal
    * tGravityAcc - time domain gravity acceleration signal
    * tBodyAccJerk - time domain body acceleration Jerk signal
    * tBodyGyro - time domain body gyroscopic signal
    * tBodyGyroJerk - time domain body gyroscopic signal
    * tBodyAccMag - time domain body acceleration magnitude 
    * tGravityAccMag - time domain gravity acceleration magnitude
    * tBodyAccJerkMag - time domain body acceleration Jerk magnitude
    * tBodyGyroMag - time domain body gyroscopic magnitude
    * tBodyGyroJerkMag - time domain body gyroscopic Jerk magnitude
    * fBodyAcc - frequency body acceleration vector
    * fBodyAccJerk - frequency body acceleration Jerk vector
    * fBodyGyro - frequency body gyroscopic vector
    * fBodyAccMag - frequency body acceleration magnitude
    * fBodyAccJerkMag - frequency body acceleration Jerk magnitude
    * fBodyGyroMag - frequency body gyroscopic magnitude
    * fBodyGyroJerkMag - frequency body gyroscopic Jerk magnitude

    
* Measure - set of variables that were estimated from these features
    * mean() - Mean value
    * std() - Standard deviation

    
* Axis - axis along which feature was measured
    * X
    * Y
    * Z
    * Na

    
* Mean - mean value of variable/subject/activity
    
    

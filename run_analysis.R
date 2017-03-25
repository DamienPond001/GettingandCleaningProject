#####################################################################
#
# Code to fetch, merge and tidy training and testing data found at:
#
#           https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# Refer to Codebook and README for further information
#
#####################################################################

#Load necessary libraries
library(dplyr)
library(tidyr)

#Check for file existance. Fetch and unzip file if not already downloaded
if(!file.exists("./Dataset.zip"))
{
    URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(URL, destfile = "./Dataset.zip", method = "curl")
    
    unzip("./Dataset.zip")
    #Creates UCI HAR Dataset folder
}

#Read in features list
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE, col.names = c("", "Features"))

#Extract Training data
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE, col.names = "Subjects")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE, col.names = "Labels")
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)

#Combine training data
combinedTrain <- cbind(subjectTrain, yTrain, xTrain)

#Free memory of unneeded objects
rm(list = c("subjectTrain", "yTrain", "xTrain"))

#Extract Testing data
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE, col.names = "Subjects")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE, col.names = "Labels")
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)

#combine testing data
combinedTest <- cbind(subjectTest, yTest, xTest)

#Free memory of unneeded objects
rm(list = c("subjectTest", "yTest", "xTest"))

#Merge testing and training (Note, could be done with rbind() in this case)
combinedData <- merge(combinedTest, combinedTrain, all = TRUE)

#Arrange combined data by Subject
combinedData <- arrange(combinedData, Subjects)

#Give columns proper names. Names from features.txt used for Measurement names
colnames(combinedData) <- c("Subjects", "Activity_Labels", features$Features)

#Delete unnecessary objects
rm(list = c("combinedTest", "combinedTrain"))

#Extract columns of interest (Note: it was decided that names with mean() and std() were of interested, not just "mean" in the name. 
#Thus, names with "meanFreq" in their title were omitted)
names <- colnames(combinedData)
combinedData <- combinedData[,c("Subjects", "Activity_Labels", names[grepl("std()|mean()", names) & !grepl("meanFreq", names)])]

#Read in activity names
actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE, col.names = c("Label", "Activity"))

#Replace activity number with activities according to activity_labels.txt
combinedData <- mutate(combinedData, Activity_Labels = sapply(combinedData$Activity_Labels, 
                                                       function(x){actLabels$Activity[actLabels$Label==x]}))

####################
#
#     Tidy data
#
####################

#Replace hyphens with underscore 
colnames(combinedData) <- gsub("-", "_",names(combinedData))

#Calculate the mean values by variable, subject and activity
#Note, here an "variable" is taken as each column in "combineData" (not including "Subjects" and "Activity_Label")
#Furthermore, each of these variables are interpreted as being variable values under a variable name "Feature_Measure_Axis"
# and, by the "tidy data" guidelines discussed in Wickham, H., 2014. Tidy data. The Journal of Statistical Software 59 (10), are
#are designated their own column
tidycombinedData <- combinedData %>% 
                    gather(Feature_Measure_Axis, count, -(c(Subjects, Activity_Labels))) %>%
                    group_by(Subjects, Activity_Labels, Feature_Measure_Axis) %>%
                    summarise(Mean = mean(count))

#In addition to the above comment on tidy data, "Feature_Measure_Axis" contains 3 variables in the same column (Refer to swirl tutorial
#on tidy data for similar example). These variables are split into individual columns, "Feature", "Measure" and "Axis"
tidycombinedData <- separate(tidycombinedData, Feature_Measure_Axis, c("Feature", "Measure", "Axis"))

#Write tidy dataset to file
write.table(tidycombinedData, "TidyData.txt",row.name=FALSE)
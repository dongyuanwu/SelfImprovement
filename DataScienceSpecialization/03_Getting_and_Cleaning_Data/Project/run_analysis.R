##################################################################

# Getting and Cleaning Data - Project

# Requires:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

##################################################################

##################################################################
# Load packages
##################################################################

library(reshape2) # reshape dataset (melt, dcast)


##################################################################
# 1. Merges the training and the test sets to create one data set.
##################################################################

## activity labels
activitylabel <- read.table("activity_labels.txt", as.is = TRUE)

## features
features <- read.table("features.txt", as.is = TRUE)

# training set
trainsubject <- read.table("train/subject_train.txt")
trainx <- read.table("train/X_train.txt")
trainy <- read.table("train/y_train.txt")
train <- cbind(trainsubject, trainy, trainx)

# testing set
testsubject <- read.table("test/subject_test.txt")
testx <- read.table("test/X_test.txt")
testy <- read.table("test/y_test.txt")
test <- cbind(testsubject, testy, testx)

# merge datasets and assign colnames
dataset <- rbind(train, test)
colnames(dataset) <- c("subject", "activity", features[, 2])


##################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##################################################################

subdata <- dataset[, grepl("subject|activity|mean|std", colnames(dataset))]


##################################################################
# 3. Uses descriptive activity names to name the activities in the data set.
##################################################################

subdata$activity <- factor(subdata$activity, levels = activitylabel[, 1],
                           labels = activitylabel[, 2])


##################################################################
# 4. Appropriately labels the data set with descriptive variable names.
##################################################################

## reorganize the colnames
colnames(subdata) <- gsub("-", "_", colnames(subdata))
colnames(subdata) <- gsub("[()]", "", colnames(subdata))


##################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
##################################################################

temp <- melt(subdata, id = c("subject", "activity"))
averagedata <- dcast(temp, subject + activity ~ variable, mean)

write.table(averagedata, "tidy_dataset.txt", row.names = FALSE, quote = FALSE)

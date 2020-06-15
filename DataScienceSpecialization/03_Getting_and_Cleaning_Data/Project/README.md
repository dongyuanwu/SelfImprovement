# getting-and-cleaning-data-project

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the original data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## This repo contains the following files

- `README.md`: Provides an overview of the data set and how it was created.
- `Codebook.md`: Describes all the variables and summaries calculated, along with units, and any other relevant information.
- `tidy_dataset.txt`: A tidy data set with the average of each variable for each activity and each subject.
- `run_analysis.R`: The R script was used to create the tidy data set.


## Steps for creating the tidy data set

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set.
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

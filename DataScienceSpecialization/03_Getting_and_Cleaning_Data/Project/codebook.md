# Code Book for Getting and Cleaning Data Course Project

This code book is for the data set file `tidy_dataset.txt`, which is a tidy data set with the mean value of of each variable for each activity and each subject.

## Overview

This data set has 180 rows (without variables' names) and 81 columns. Each row represents one subject and activity and contains 79 mean value of signal measurements.

## Variables

### Identifiers

- `subject`: Each number identifies the subject. Its range is from 1 to 30 (integer).
- `activity`: Total 6 activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

### Average of of Measurements

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time (prefix 't' to denote time domain signals) and frequency domain (prefix 'f' to denote frequency domain signals).

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

All measurements are normalized and bounded within [-1,1].

#### Time Domain Signals

- `tBodyAcc_mean_X`: Mean value of time domain body acceleration signals in the X direction.
- `tBodyAcc_mean_Y`: Mean value of time domain body acceleration signals in the Y direction.
- `tBodyAcc_mean_Z`: Mean value of time domain body acceleration signals in the Z direction.

- `tBodyAcc_std_X`: Standard deviation of time domain body acceleration signals in the X direction.
- `tBodyAcc_std_Y`: Standard deviation of time domain body acceleration signals in the Y direction.
- `tBodyAcc_std_Z`: Standard deviation of time domain body acceleration signals in the Z direction.

- `tGravityAcc_mean_X`: Mean value of time domain gravity acceleration signals in the X direction.
- `tGravityAcc_mean_Y`: Mean value of time domain gravity acceleration signals in the Y direction.
- `tGravityAcc_mean_Z`: Mean value of time domain gravity acceleration signals in the Z direction.

- `tGravityAcc_std_X`: Standard deviation of time domain gravity acceleration signals in the X direction.
- `tGravityAcc_std_Y`: Standard deviation of time domain gravity acceleration signals in the Y direction.
- `tGravityAcc_std_Z`: Standard deviation of time domain gravity acceleration signals in the Z direction.

- `tBodyAccJerk_mean_X`: Mean value of time domain body acceleration Jerk signals in the X direction.
- `tBodyAccJerk_mean_Y`: Mean value of time domain body acceleration Jerk signals in the Y direction.
- `tBodyAccJerk_mean_Z`: Mean value of time domain body acceleration Jerk signals in the Z direction.

- `tBodyAccJerk_std_X`: Standard deviation of time domain body acceleration Jerk signals in the X direction.
- `tBodyAccJerk_std_Y`: Standard deviation of time domain body acceleration Jerk signals in the Y direction.
- `tBodyAccJerk_std_Z`: Standard deviation of time domain body acceleration Jerk signals in the Z direction.

- `tBodyGyro_mean_X`: Mean value of time domain body angular velocity signals in the X direction.
- `tBodyGyro_mean_Y`: Mean value of time domain body angular velocity signals in the Y direction.
- `tBodyGyro_mean_Z`: Mean value of time domain body angular velocity signals in the Z direction.

- `tBodyGyro_std_X`: Standard deviation of time domain body angular velocity signals in the X direction.
- `tBodyGyro_std_Y`: Standard deviation of time domain body angular velocity signals in the Y direction.
- `tBodyGyro_std_Z`: Standard deviation of time domain body angular velocity signals in the Z direction.

- `tBodyGyroJerk_mean_X`: Mean value of time domain body angular velocity Jerk signals in the X direction.
- `tBodyGyroJerk_mean_Y`: Mean value of time domain body angular velocity Jerk signals in the Y direction.
- `tBodyGyroJerk_mean_Z`: Mean value of time domain body angular velocity Jerk signals in the Z direction.

- `tBodyGyroJerk_std_X`: Standard deviation of time domain body angular velocity Jerk signals in the X direction.
- `tBodyGyroJerk_std_Y`: Standard deviation of time domain body angular velocity Jerk signals in the Y direction.
- `tBodyGyroJerk_std_Z`: Standard deviation of time domain body angular velocity Jerk signals in the Z direction.

- `tBodyAccMag_mean`: Mean value of magnitude of time domain body acceleration signals.
- `tBodyAccMag_std`: Standard deviation of magnitude of time domain body acceleration signals.
- `tGravityAccMag_mean`: Mean value of magnitude of time domain gravity acceleration signals.
- `tGravityAccMag_std`: Standard deviation of magnitude of time domain gravity acceleration signals.
- `tBodyAccJerkMag_mean`: Mean value of magnitude of time domain body acceleration Jerk signals.
- `tBodyAccJerkMag_std`: Standard deviation of magnitude of time domain body acceleration Jerk signals.
- `tBodyGyroMag_mean`: Mean value of magnitude of time domain body angular velocity signals.
- `tBodyGyroMag_std`: Standard deviation of magnitude of time domain body angular velocity signals.
- `tBodyGyroJerkMag_mean`: Mean value of magnitude of time domain body angular velocity Jerk signals.
- `tBodyGyroJerkMag_std`: Standard deviation of magnitude of time domain body angular velocity Jerk signals.

#### Frequency Domain Signals

- `fBodyAcc_mean_X`: Mean value of frequency domain body acceleration signals in the X direction.
- `fBodyAcc_mean_Y`: Mean value of frequency domain body acceleration signals in the Y direction.
- `fBodyAcc_mean_Z`: Mean value of frequency domain body acceleration signals in the Z direction.

- `fBodyAcc_std_X`: Standard deviation of frequency domain body acceleration signals in the X direction.
- `fBodyAcc_std_Y`: Standard deviation of frequency domain body acceleration signals in the Y direction.
- `fBodyAcc_std_Z`: Standard deviation of frequency domain body acceleration signals in the Z direction.

- `fBodyAcc_meanFreq_X`: Weighted average of the frequency components of frequency domain body acceleration signals in the X direction.
- `fBodyAcc_meanFreq_Y`: Weighted average of the frequency components of frequency domain body acceleration signals in the Y direction.
- `fBodyAcc_meanFreq_Z`: Weighted average of the frequency components of frequency domain body acceleration signals in the Z direction.

- `fBodyAccJerk_mean_X`: Mean value of frequency domain body acceleration Jerk signals in the X direction.
- `fBodyAccJerk_mean_Y`: Mean value of frequency domain body acceleration Jerk signals in the Y direction.
- `fBodyAccJerk_mean_Z`: Mean value of frequency domain body acceleration Jerk signals in the Z direction.

- `fBodyAccJerk_std_X`: Standard deviation of frequency domain body acceleration Jerk signals in the X direction.
- `fBodyAccJerk_std_Y`: Standard deviation of frequency domain body acceleration Jerk signals in the Y direction.
- `fBodyAccJerk_std_Z`: Standard deviation of frequency domain body acceleration Jerk signals in the Z direction.

- `fBodyAccJerk_meanFreq_X`: Weighted average of the frequency components of frequency domain body acceleration Jerk signals in the X direction.
- `fBodyAccJerk_meanFreq_Y`: Weighted average of the frequency components of frequency domain body acceleration Jerk signals in the Y direction.
- `fBodyAccJerk_meanFreq_Z`: Weighted average of the frequency components of frequency domain body acceleration Jerk signals in the Z direction.

- `fBodyGyro_mean_X`: Mean value of frequency domain body angular velocity signals in the X direction.
- `fBodyGyro_mean_Y`: Mean value of frequency domain body angular velocity signals in the Y direction.
- `fBodyGyro_mean_Z`: Mean value of frequency domain body angular velocity signals in the Z direction.

- `fBodyGyro_std_X`: Standard deviation of frequency domain body angular velocity signals in the X direction.
- `fBodyGyro_std_Y`: Standard deviation of frequency domain body angular velocity signals in the Y direction.
- `fBodyGyro_std_Z`: Standard deviation of frequency domain body angular velocity signals in the Z direction.

- `fBodyGyro_meanFreq_X`: Weighted average of the frequency components of frequency domain body angular velocity signals in the X direction.
- `fBodyGyro_meanFreq_Y`: Weighted average of the frequency components of frequency domain body angular velocity signals in the Y direction.
- `fBodyGyro_meanFreq_Z`: Weighted average of the frequency components of frequency domain body angular velocity signals in the Z direction.

- `fBodyAccMag_mean`: Mean value of magnitude of frequency domain body acceleration signals.
- `fBodyAccMag_std`: Standard deviation of magnitude of frequency domain body acceleration signals.
- `fBodyAccMag_meanFreq`: Weighted average of the frequency components of frequency domain body acceleration signals.

- `fBodyBodyAccJerkMag_mean`: Mean value of magnitude of frequency domain body acceleration Jerk signals.
- `fBodyBodyAccJerkMag_std`: Standard deviation of magnitude of frequency domain body acceleration Jerk signals.
- `fBodyBodyAccJerkMag_meanFreq`: Weighted average of the frequency components of frequency domain body acceleration Jerk signals.

- `fBodyBodyGyroMag_mean`: Mean value of magnitude of frequency domain body angular velocity signals.
- `fBodyBodyGyroMag_std`: Standard deviation of magnitude of frequency domain body angular velocity signals.
- `fBodyBodyGyroMag_meanFreq`: Weighted average of the frequency components of frequency domain body angular velocity signals.

- `fBodyBodyGyroJerkMag_mean`: Mean value of magnitude of frequency domain body angular velocity Jerk signals.
- `fBodyBodyGyroJerkMag_std`: Standard deviation of magnitude of frequency domain body angular velocity Jerk signals.
- `fBodyBodyGyroJerkMag_meanFreq`: Weighted average of the frequency components of frequency domain body angular velocity Jerk signals.

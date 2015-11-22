# Code Book

In this document, I will review the variables, the data, and any functions/actions performed in the run_analysis.R file, 
in order to clean up the initial raw data.

* The site where the data were obtained:
  * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* The data for the project is:
  * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Data
The initial data sets are the file "X_train.txt", and "X_test.txt". 
Those can be found in data.dir/train and data.dir/test.
In this step, I have joined the two data set in a one "big" data frame, by 
using the R-command ```rbind(df1, df2)```.

Therefore, the second step has been extracting only the measurements on the mean and standard 
deviation for each measurements. 
The complete list of variables of each feature vector is available 
in ```futures.txt```. First, I assigned the names to the variables in the joined dataset, i.e
```
features <- read.table(file.path(data.dir, "features.txt"))
features_names <- as.character(features[,2])
names(join_dataset) <- features_names
```
Then, I used the ```grep()``` function to search for the string I was matching. 
Example usage: 
```
extract <- join_dataset[, grep("\\bmean\\b|\\bstd\\b", features_names)]
```
### Measurements Means
All variables present now in the joined dataset are the mean of a measurement.
I conveniently renamed those variables, e.g., substituting the initial lower case letters
```t``` and ```f``` in an human-readable string ```Time_``` and ```Freq_```, 
or removing ```''```, and converting ```mean``` and ```std``` in ```_Mean``` and ```_Std```
respectively. 

## Subject and Activity
These variables identify the unique subject/activity pair:
* Subject: in the file ```train/subject_train.txt```, each row identifies the subject who performed the 
activity. It is an ID identifiers, and its range is from 1 to 30. 
* Activity: in the file ```activity_labels.txt```, there is the string activity name:
  * Walking
  * Walking Upstairs
  * Walking Downstairs
  * Sitting
  * Standing
  
## Final Tidy Data Set 
The cleaned up data contains a single row for each subject/activity pair - described above - , 
and a single column for each measurement.
Below an example of the name of measurements 
  - Time_BodyAcc_MeanX
  - Time_BodyAcc_MeanY 
  - Time_BodyAcc_MeanZ 
  - Time_BodyAcc_StdX
  - Time_BodyAcc_StdY
  - Time_BodyAcc_StdZ
  - Time_GravityAcc_MeanX 
  - Time_GravityAcc_MeanY  
  - Time_GravityAcc_MeanZ 
  - Time_GravityAcc_StdX 
  - Time_GravityAcc_StdY 
  - Time_GravityAcc_StdZ
  - Time_BodyAccJerk_MeanX 
  - Time_BodyAccJerk_MeanY 
  - Time_BodyAccJerk_MeanZ 
  - Time_BodyAccJerk_StdX 
  - Time_BodyAccJerk_StdY 
  - Time_BodyAccJerk_StdZ 
  - Time_BodyGyro_MeanX 
  - Time_BodyGyro_MeanY 
  - Time_BodyGyro_MeanZ 
  - Time_BodyGyro_StdX 
  - Time_BodyGyro_StdY 
  - Time_BodyGyro_StdZ 
  - Time_BodyGyroJerk_MeanX 
  - Time_BodyGyroJerk_MeanY 
  - Time_BodyGyroJerk_MeanZ 
  - Time_BodyGyroJerk_StdX 
  - Time_BodyGyroJerk_StdY 
  - Time_BodyGyroJerk_StdZ 
  - Time_BodyAccMag_Mean 
  - Time_BodyAccMag_Std 
  - Time_GravityAccMag_Mean
  - Time_GravityAccMag_Std 
  - Time_BodyAccJerkMag_Mean 
  - Time_BodyAccJerkMag_Std 
  - Time_BodyGyroMag_Mean 
  - Time_BodyGyroMag_Std 
  - Time_BodyGyroJerkMag_Mean
  - Time_BodyGyroJerkMag_Std 
  - Freq_BodyAcc_MeanX
  - Freq_BodyAcc_MeanY
  - Freq_BodyAcc_MeanZ
  - Freq_BodyAcc_StdX
  - Freq_BodyAcc_StdY
  - Freq_BodyAcc_StdZ
  - Freq_BodyAccJerk_MeanX
  - Freq_BodyAccJerk_MeanY
  - Freq_BodyAccJerk_MeanZ
  - Freq_BodyAccJerk_StdX
  - Freq_BodyAccJerk_StdY
  - Freq_BodyAccJerk_StdZ
  - Freq_BodyGyro_MeanX
  - Freq_BodyGyro_MeanY
  - Freq_BodyGyro_MeanZ
  - Freq_BodyGyro_StdX
  - Freq_BodyGyro_StdY
  - Freq_BodyGyro_StdZ
  - Freq_BodyAccMag_Mean
  - Freq_BodyAccMag_Std
  - Freq_BodyAccJerkMag_Mean
  - Freq_BodyAccJerkMag_Std
  - Freq_BodyGyroMag_Mean 
  - Freq_BodyGyroMag_Std
  - Freq_BodyGyroJerkMag_Mean
  - Freq_BodyGyroJerkMag_Std

P.S. The reader could find it useful to have a look into the README.txt file, cointained in the unzipped UCI HAR Dataset

## Mean tidy data set
From the data set above, a second, independent tidy data set with the average of each variable for each activity and each subject has been creatd

# Data Science: Getting and Cleaning-Data

The goal of this project has been to prepare tidy data that can be used for later analysis. 
The raw data set concerns with the "Recognition of Human Activity, by using Smartphones". 
Through a few steps, the different initial sets of data (i.e., test and train)
have been converted in an unique, and cleaner collection of data. 
In this regards, a more detailed description of the variables can be found in the CodeBook.md document. 

For our purposes, only the mean and standard deviation variables were kept. 
The final single data set (called tidy_dataset.txt) contains also subject identifiers, and activity labels, 
opportunely converted in a more human-readable format. 
The basic naming convention is:

Time_(or Freq_)measurement_Mean(or _Std)XYZ

where Time_ or Freq_ indicate whether the measurement comes from the time or frequency domain, measurement is one of the original measurement features, e.g., BodyGyro, _Mean or _Std either indicate whether the measurement was a mean or standard deviation variable, and XYZ is X, Y, or Z, indicating the axis along which the measurement was taken, or nothing, for magnitude measurements.

Then, those variables have been further summarized by taking their mean for each subject/activity pair.
A second, independent tidy data set with the average of each variable, for each activity and each subject, 
has been produced, and it can be found in the mean_tidy_dataset.txt file. 
The basic naming convention is: 

Average_Time_(or Freq_)measurement_Mean(or _Std)XYZ 

# Let's set working directory -- absolute path
setwd("/Users/joedibernardo/Projects/DATASCIENCE/GettingandCleaningData/week3")

# 1. Check if file exists, and download file 
filename <- "Project_Dataset.zip"

if(!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = filename, method = "curl")
  dateDownloaded <- date() # record the download date
  data.dir <- "UCI HAR Dataset"
  if(!file.exists(data.dir)){
    unzip(filename, exdir = ".")  
    # UCI HAR Dataset is - actually - the unzipped downloaded data set
  }
  data.dir
}

# 2. Merging the training and the test sets, to create one data set
training <- read.table(file.path(data.dir, "train", "X_train.txt"))
#dim(training_set)  # 7352 x 561
test <- read.table(file.path(data.dir, "test", "X_test.txt") )
#dim(test_set) # 2947 x 561
join_dataset <- rbind(training, test)
dim(join_dataset) # 10299 x 561 (dataset of activities x tests)
#head(join_dataset)

# 3. Extracting only the measurements on the mean and standard 
# deviation for each measurements. The set of variables that were 
# estimated from these signals are: mean(), std(), mad() etc. etc.
# The complete list of variables of each feature vector is available 
# in "futures.txt"
features <- read.table(file.path(data.dir, "features.txt"))
features_names <- as.character(features[,2])
# dim(features_set)  # 561 x 2. 
# The col. # 2 is the name of the variables.  
# So, let's assign names to the 561 VARs in the joined dataset. 
names(join_dataset) <- features_names
head(join_dataset, 6)

# Now we need to extract the measurements of the interest for us. 
# Use grep() to search for the string you're matching. 
# use word boundary \b which matches a between a word and non-word character 
# measurements <- grep("\\bmean\\b|\\bstd\\b", features_names)

extract <- join_dataset[, grep("\\bmean\\b|\\bstd\\b", features_names)]
#dim(extract) # 10299 * 66
names(extract) <- gsub("^t", "Time_", names(extract))
names(extract) <- gsub("^f", "Freq_", names(extract))
names(extract) <- gsub("BodyBody", "Body", names(extract))
names(extract) <- gsub("-", "", names(extract))
names(extract) <- gsub("mean", "_Mean", names(extract))
names(extract) <- gsub("std", "_Std", names(extract))
names(extract) <- gsub("\\(\\)", "", names(extract))
# extract

# 4. Uses descriptive activity names to name the activities 
# in the data set.
train_activities <- read.table(file.path(data.dir, "train", "y_train.txt"))
test_activities <- read.table(file.path(data.dir, "test", "y_test.txt"))
activities <- rbind(train_activities, test_activities)[,1]

activity_labels <- read.table(file.path(data.dir, "activity_labels.txt"))[,2]
activities_names <- activity_labels[activities]

# 5. Appropriately labels the data set with descriptive variable names. 
train_subject <- read.table(file.path(data.dir, "train", "subject_train.txt"))
test_subject <- read.table(file.path(data.dir, "test", "subject_test.txt"))
subjects <- rbind(train_subject, test_subject)[,1]
# subjects

tidy <- cbind(Subject = subjects, Activity = activities_names, extract)
write.table(tidy, "./tidy_dataset.txt")

# 5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
library(plyr)
library(dplyr)
mean_variable <- function(dt) {colMeans(dt[, -c(1,2)])} 
# define a function to compute a mean on the columns of the data frame, 
# except subject and activities. 
mean_tidy <- ddply(tidy, .(Subject, Activity), mean_variable)
names(mean_tidy)[-c(1,2)] <- paste("Average", names(mean_tidy)[-c(1,2)], sep = "_")
write.table(mean_tidy, "./mean_tidy_dataset.txt")



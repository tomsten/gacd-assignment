#This script will complete the following tasks:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#The script uses some functionality from the dplyr package, so we need to make sure that is loaded in at the beginning.
library(dplyr)

#I've downloaded all of the data files into a folder in my active workspace, and now i'm pulling each of the files into R for analysis.
test_set <- read.table("GACD assignment/UCI HAR dataset/test/X_test.txt")
train_set <- read.table("GACD assignment/UCI HAR dataset/train/X_train.txt")
test_labels <- read.table("GACD assignment/UCI HAR dataset/test/y_test.txt")
train_labels <- read.table("GACD assignment/UCI HAR dataset/train/y_train.txt")
test_subjects <- read.table("GACD assignment/UCI HAR dataset/test/subject_test.txt")
train_subjects <- read.table("GACD assignment/UCI HAR dataset/train/subject_train.txt")
activity_labels <- read.table("GACD assignment/UCI HAR dataset/activity_labels.txt")
features <- read.table("GACD assignment/UCI HAR dataset/features.txt")

#The first requirement for the assignment is to merge the test and training sets into one data set ready for analysis. 
#I've used the rbind function to bind together the test and training data sets for the data, label and subject files that will all be required later.
merged_set <- rbind(train_set, test_set)
merged_labels <- rbind(train_labels, test_labels)
merged_subjects <- rbind(train_subjects, test_subjects)

#The second requirement for the assignment is to gather the data for only the measurements that include the mean and standard deviation.
#I've used the grep function to find the column numbers and names where the column includes either the mean or the standard deviation.

selection_columns <- grep("mean|std", features[,2])
selection_names <- grep("mean|std", features[,2], value=TRUE)

#Using the columns discovered above that contain the mean and standard deviation data, subset the merged_set created earlier to now contain only the rows containing standard deviation and mean data. This new set is called the sdmean_set.

sdmean_set <- merged_set[, selection_columns]

#matched the data set labels with the activity labels file, so the descriptive activity names are used as required in point 3 above.
merged_labels <- activity_labels[match(merged_labels[, 1],activity_labels[, 1]), 2]
combined_set <- cbind(sdmean_set,merged_labels,merged_subjects)

#renames the columns in the total data set to contain the descriptive names found in the features file that were selected int the selection_names variable above. Add extra names for the new columns labels and subjects.
names(combined_set) <- c(selection_names, "activity", "subject")
tidy_set <- combined_set

#creating a new data set that contains the average of each variable for each activity completed by each subject.
avg_set <- tidy_set %>% group_by(activity, subject) %>% summarize_all(funs(mean))

avg_set
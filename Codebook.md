### Introduction

This Codebook will explain the different variables and data points created as
a result of running the 'run_analysis.R' script.

### Files
test_set - test data
train_set - train data
test_labels - test label data
train_labels - train label data
test_subjects - test subject data
train_subjects - train subject data
activity_labels - list of activity labels
features - list of features

### Variables

merged_set - data set containing both test and train data sets
merged_labels - data set containing both test and train label data
merged_subjects - data set containing both test and train subject data
selection_columns - data set containing the column numbers of all standard deviation and mean fields
selection_names - data set containing the column names of all standard deviation and mean fields
sdmean_set - merged data set containing only the standard deviation and mean data points
combined_set - data set containing the sdmean_set, merged labels and merged subjects combined into one final data set that contains all observations and is correctly labelled
tidy_set - renamed version of combined_set
avg_set - data set containing the average data for each subject across all activities

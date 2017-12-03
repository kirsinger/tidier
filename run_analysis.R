# UCI HAR Data Set Tidier
#
# Author: Kai Hirsinger (kai.hirsinger@gmail.com)
# Since: November 2017
#
# Script for creating a "tidied" version of the UCI HAR dataset, consisting
# of accelerometer measurements taken from a Samsung Galaxy S smartphone
# while subjects are performing various activities.
# 

#############
# Libraries #
#############

library(dplyr)


#############
# Constants #
#############

# Labels
ACTIVITY_LABELS <- './UCI HAR Dataset/activity_labels.txt'
FEATURE_LABELS <- './UCI HAR Dataset/features.txt'

# Training Data
X_TRAIN <- './UCI HAR Dataset/train/X_train.txt'
Y_TRAIN <- './UCI HAR Dataset/train/y_train.txt'
SUBJECT_TRAIN <- './UCI HAR Dataset/train/subject_train.txt'

# Test Data
X_TEST <- './UCI HAR Dataset/test/X_test.txt'
Y_TEST <- './UCI HAR Dataset/test/y_test.txt'
SUBJECT_TEST <- './UCI HAR Dataset/test/subject_test.txt'


#############################################
# Data Loading and Pre-Processing Functions #
#############################################

load_uci_har_dataset <- function(x, y, subjects, activity_labels, feature_labels) {
    # Load and label features
    feature_labels <- read.csv(
        feature_labels,
        header=FALSE,
        sep='',
        col.names=c('column_number', 'feature_name')
    )
    x <- read.csv(
        x,
        header=FALSE,
        sep='',
        col.names=feature_labels$feature_name,
        strip.white=TRUE
    )

    # Extract measurements on mean and standard deviation
    x <- x[,grep('((M|m)ean)|(std)', colnames(x), value=TRUE)]

    # Load subjects and append to features
    subjects <- read.csv(
        subjects,
        header=FALSE,
        col.names=c('subject_id')
    )
    x$subject_id <- subjects$subject_id
    
    # Load and label activity labels
    y <- read.csv(
        y,
        header=FALSE,
        col.names=c('activity_code')
    )
    labels <- read.csv(
        activity_labels,
        header=FALSE,
        sep='',
        col.names=c('activity_code', 'activity_name')
    )
    x$activity_code <- y$activity_code
    uci_har_dataset <- merge(x, labels, by.x='activity_code', by.y='activity_code')
    
    # Remove the activity code as the labels are more informative
    uci_har_dataset$activity_code <- NULL 

    uci_har_dataset
}


#################
# Main Function #
#################

# Load and merge training and test data sets
train <- load_uci_har_dataset(
    x=X_TRAIN,
    y=Y_TRAIN,
    subjects=SUBJECT_TRAIN,
    activity_labels=ACTIVITY_LABELS,
    feature_labels=FEATURE_LABELS
)
test <- load_uci_har_dataset(
    x=X_TEST,
    y=Y_TEST,
    subjects=SUBJECT_TEST,
    activity_labels=ACTIVITY_LABELS,
    feature_labels=FEATURE_LABELS
)
full_data_set <- rbind(train, test)

# Calculate average (mean) of each variable for each activity and each subject
means_by_subject_and_activity <- full_data_set %>% group_by(subject_id, activity_name) %>% summarise_all(funs(mean))

# Write result to CSV
write.table(
    means_by_subject_and_activity,
    'tidy_data.txt',
    row.name=FALSE
)


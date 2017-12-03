# UCI HAR Tidied Dataset Codebook
This document describes the CSV file produced by the script `run_analysis.R`. More information about the operation and usage of this script can be found in `README.md`.

## Processing Steps
The script `run_analysis.R` produces a CSV encoded dataset which is saved to the file `tidy_data.csv`. This file is produced by applying the following operations to the UCI HAR dataset (which can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip):
1. Training and test datasets are loaded as follows:
    * Feature vectors are loaded into a new dataframe.
    * The features in this dataframe are limited to measurements representing a mean or standard deviation. This is done by applying a regular expression to the column names.
    * Subject ids and numerical label codes are appended to dataframe containing the features as new columns.
    * Descriptive labels are appended to this dataframe by merging the feature label names on the numerical label code column.
    * The column containing the numerical label code is removed, as this is less informative than the actual label descriptions.
2. Training and test datasets are merged to obtain a full dataset with all observations.
3. The resulting dataset is grouped by subject id and activity description, and each variable is summarised using the `mean` function.
4. The summarised output is dumped to the file `tidy_data.csv`

## Dataset Structure
The resulting file `tidy_data.csv` is structured as follows:
* Each row is an observation of an activity performed by a subject.
* An observation consists of **averaged** accelerometer measurements collected from a Samsung Galxy S smartphone.
* For this dataset, only the mean and standard deviation measurements are considered for each observation.

## Variables
The following variables have been added to this dataset:
1. subject_id: the numerical ID of the observed subject.
2. activity_name: the activity performed by the subject as they were observed.

The remaining variables were extracted from the original dataset, and are documented in `features_info.txt`.


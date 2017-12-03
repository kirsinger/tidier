# UCI HAR Data Set Tidier

## Description
The script `run_analysis.R` implements a set of functions for ingesting and tidying the [UCI HAR dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). This script was written to satisfy the requirements of the peer graded assignment for [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning) on [Coursera](https://www.coursera.org).

The structure of the file produced by this script, as well as a detailed description of the data processing operations performed by the script, are provided in the file `CodeBook.md` in this repository.

## Usage
1. Download the dataset [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
2. Extract the dataset to the directory `UCI HAR Dataset`. This directory should be in the same directory as the `run_analysis.R` script.
3. Run the script using the following command: `Rscript run_analysis.R`.
4. The output from the script will be saved to the file `tidy_data.csv`.


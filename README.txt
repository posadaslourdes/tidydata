MY SUBMISSION CONTAINS
-PosadasData: data set is tidy.
-run_analyses: the required scripts. 
-Codebook1: contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
-README: that explains the analysis files is clear and understandable.


A RESOURCES
A1 *****UCI HAR DATASET
Files
TEST : 
subject_test,
 X_test,
 Y_test
TRAIN: 
subject_test,
X_test,
 Y_test
README
Activity lablesFeatures
Features info

A2****PACKAGES
#intall packages to work
install.packages("dplyr")
install.packages("data.table")
install.packages("tidyr")
install.packages("grep")
 
# load packages
library(dplyr)
library(data.table)
library(tidyr)
library(grep)
 
A3****DOWNLOAD AND READ TABLES AND CREATE TABLES

B HOMEWORK: each action in Rsintax is explain with aclaration between#
B1.Merges the training and the test sets to create one data set.
B2 Extracts only the measurements on the mean and standard deviation for each measurement.
B3 Uses descriptive activity names to name the activities in the data set
B4 Appropriately labels the data set with descriptive variable names.
B5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
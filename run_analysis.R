#intall packages to work
install.packages("dplyr")
install.packages("data.table")
install.packages("tidyr")

# load packages
library(dplyr)
library(data.table)
library(tidyr)

#dowload data from web 

if(!file.exists("./data")){dir.create("./data")}

Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

f<-file.path(getwd(),"Dataset.zip")

download.file(Url,f)

unzip(zipfile="./data/Dataset.zip",exdir="./data")

h <- "C:/Users/Maria.Posadas/Desktop/data/UCI HAR Dataset"

#read test files and create data test files  subject/x/y
#activity y / data x

TestSubject  <- tbl_df(read.table(file.path(h, "test" , "subject_test.txt" )))

TestY  <- tbl_df(read.table(file.path(h, "test" , "Y_test.txt" )))

TestX <- tbl_df(read.table(file.path(h, "test" , "X_test.txt" )))

#read files and create data train files  subject/x/y
TrainSubject  <- tbl_df(read.table(file.path(h, "train" , "subject_train.txt" )))

TrainY  <- tbl_df(read.table(file.path(h, "train" , "Y_train.txt" )))

TrainX <- tbl_df(read.table(file.path(h, "train" , "X_train.txt" )))

##### 1.Merges the training and the test sets to create one data set.

# BInd training and the test sets for subject, activity (Y) and data (X) and rename variables "subject" and "activity"
#Makes one data.table from a list of many
Subjects <- rbind(TestSubject, TrainSubject)
setnames(Subjects, "V1", "subject")

Activity<- rbind(TestY, TrainY)
setnames(Activity, "V1", "activity")

Table <- rbind(TrainX, TestX)

#read file features.txt - Names of column variables in the dataTable
Features <- tbl_df(read.table(file.path(h, "features.txt")))
#name variables according to feature e.g.(V1 = "tBodyAcc-mean()-X")

setnames(Features, names(Features), c("featureNum", "featureName"))
colnames(Table) <- Features$featureName



#read file activity_labels.txt - Links the class labels with their activity name.
activityLabels<- tbl_df(read.table(file.path(h, "activity_labels.txt")))
#column names for activity labels
setnames(activityLabels, names(activityLabels), c("activity","activityName"))

# Merge columns
SubjectActivity<- cbind(Subjects, Activity)
Table <- cbind(SubjectActivity, Table)

####2. Extracts only the measurements on the mean and standard deviation for each measurement.

DescriptiveFeatures <- grep("mean\\(\\)|std\\(\\)",Features$featureName,value=TRUE) 

DescriptiveFeatures <- union(c("subject","activity"), DescriptiveFeatures)
Table<- subset(Table,select=DescriptiveFeatures) 

##### 3. Uses descriptive activity names to name the activities in the data set.

Table <- merge(activityLabels, Table , by="activity", all.x=TRUE)
Table$activityName <- as.character(Table$activityName)
SubAct<- aggregate(. ~ subject - activityName, data = Table, mean) 
Table<- tbl_df(arrange(SubAct,subject,activityName))


##### 4. Appropriately labels the data set with descriptive variable names.
#see original names
head(str(Table))
#packages to work
install.packages("grep")
library(grep)
#change name labels> gsub perform replacement of the first and all matches respectively
#see features_info

names(Table)<-gsub("std()", " StandardDeviation", names(Table))
names(Table)<-gsub("mean()", "MeanValue", names(Table))
names(Table)<-gsub("max()", " LargestValue ", names(Table))
names(Table)<-gsub("min()", " SmallestValue ", names(Table))
names(Table)<-gsub("sma ()", " SignalMagnitudeArea ", names(Table))
names(Table)<-gsub("energy ()","EnergyMeasure", names(Table)) 
names(Table)<-gsub("iqr()", "InterquartileRange ", names(Table))
names(Table)<-gsub("entropy ()", " SignalEntropy ", names(Table))
names(Table)<-gsub("arCoeff ()", " AutorregresionCoefficients ", names(Table))
names(Table)<-gsub("maxInds ()", "IndexOfTheFrequencyComponent ", names(Table))
names(Table)<-gsub("meanFreq ()", "WeightedAverageOfTheFrequency ",names(Table))
names(Table)<-gsub("skewness ()", "SkewnessOfTheFrequency ",names(Table))
names(Table)<-gsub("kurtosis()", "KurtosisOfTheFrequency",names(Table))
names(Table)<-gsub("bandsEnergy ()", " EnergyFrequencyInterval ", names(Table))
names(Table)<-gsub("angle ()", "AngleVectors ", names(Table))
names(Table)<-gsub("^t","time", names(Table))
names(Table)<-gsub("^f","frequency", names(Table))
names(Table)<-gsub("Acc","Accelerometer",names(Table))
names(Table)<-gsub("Gyro","Gyroscope",names(Table))
names(Table)<-gsub("Mag","Magnitude",names(Table))
names(Table)<-gsub("BodyBody","Body",names(Table))
   

                   
#see new names

head(str(Table))

##### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

write.table(Table, "PosadasData.txt", row.name=FALSE)

#move PosadasDAta to path file h
PosadasData <- tbl_df(read.table(file.path(h, "PosadasData.txt" )))
#see clean data table
head(str(PosadasData))
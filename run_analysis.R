library(dplyr)
##------1. Browsing dataset
# README file
readMe <- readLines("README.txt")
readMe
##browsing trainning data
## get feature info
featuresInfo <- readLines("features_info.txt")




##------2. Merge training data


##merge y_train and activity_labels

actLables <- read.table("activity_labels.txt")  ## get labels
yTrain <- read.table("./train/y_train.txt")     ## extract y_train
activity <- merge(yTrain, actLables,by = "V1", all = FALSE)$V2


## combine activity and x_train
xTrain <- read.table("./train/X_train.txt")
features <- read.table("features.txt")
newNames <- features[[2]]  ##change column name of xTrain
colnames(xTrain) <- newNames
xyTrain <- cbind(activity, xTrain)

## merge xyTrain and subject
subject <- read.table("./train/subject_train.txt")      ## subjective list
subject <- rename(subject, subject = V1)        ##change the column name        

##final dataset for training dataset
xyTrain <- cbind(subject, xyTrain)



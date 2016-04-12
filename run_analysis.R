getwd()
## browsing the README file
readMe <- readLines("README.txt")
readMe
##feature info
featuresInfo <- readLines("features_info.txt")

featuresInfo

##get features

features <- read.table("features.txt")

features

list.files()
## get labels
actLables <- read.table("activity_labels.txt")

##get trainning data
list.files("./train")
## subjective list
subTrain <- read.table("./train/subject_train.txt")
## extract x_train and y_train
xTrain <- read.table("./train/X_train.txt")
yTrain <- read.table("./train/y_train.txt")


##Merge features and xTrain 
newNames <- as.character(features[[2]])

oldNames <- xTrain[, c[1:561]]
class(xTrain)
mode(xTrain)









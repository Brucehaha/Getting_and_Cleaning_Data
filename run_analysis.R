
##------one. Browsing dataset
# README file
readMe <- readLines("README.txt")
readMe
##browsing trainning data
## get feature info
featuresInfo <- readLines("features_info.txt")
list.files("./test")



##------two. Getting and Cleaning data
run.analysis <- function(dir) {
        cat("[run_analysis.R]","Author by Henning Li", "\n")
        cat("[run_analysis.R]","Created at 12-April-2016", "\n")
        library(dplyr)
        ##------1. Merge training data
                cat("[run_analysis.R]","Choose the working data directory", "\n")
                setwd(dir)
                ##merge y_train and activity_labels AND Uses descriptive activity names to name the activities in the data set
                
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
                
        
        
        ##------2. Merge test data AND Uses descriptive activity names to name the activities in the data set
                
                actLables <- read.table("activity_labels.txt")  ## get labels
                yTest <- read.table("./test/y_test.txt")     ## extract y_test
                activity <- merge(yTest, actLables,by = "V1", all = FALSE)$V2
                
                
                ## combine activity and x_test
                xTest <- read.table("./test/X_test.txt")
                features <- read.table("features.txt")
                newNames <- features[[2]]  
                colnames(xTest) <- newNames      ##change column name of xTest
                xyTest <- cbind(activity, xTest)
                
                ## merge xyTest and subject
                subjectTest<- read.table("./test/subject_test.txt")      ## subjective list
                subjectTest<- rename(subjectTest, subject = V1)        ##change the column name        
                
                ##final dataset for test dataset
                xyTest <- cbind(subjectTest, xyTest)
                
                
        ##------3. Merges the training and the test sets to create one data set.
                data <-rbind(xyTrain, xyTest)
        
        ##------4. Extracts only the measurements on the mean and standard deviation for each measurement.
        
                x <- grep("[Mm]ean|[Ss]td|activity|subject", colnames(data))
                data <- data[,x]
                
        
        
        ##------5. create independent tidy data set with the average of each variable for each activity and each subject.
                library(reshape2)
                dataMelt <- melt(data, id = c("subject","activity"))    ##melt data in to id variables and measure variables
                dataDcast <- dcast(dataMelt, subject + activity ~ variable, mean)
                
        ##------6. output the datasets
                # Save the clean data.
                cat("[run_analysis.R]","Choose directory to output CleanData.txt and dataDcast.txt", "\n")
                setwd(choose.dir())
                path <- file.path("cleanData.txt")
                write.table(data, path, row.names = FALSE)
                ##Save the aggregated datasets
                path <- file.path("dataDcast.txt")
                write.table(dataDcast, path, row.names = FALSE)
                cat("[run_analysis.R]","output finish", "\n")

}
##run function
run.analysis(choose.dir())


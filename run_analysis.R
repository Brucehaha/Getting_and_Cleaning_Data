
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
        library(reshape2)
        cat("[run_analysis.R]","Choose the working data directory", "\n")
        setwd(choose.dir())
         
        ##common lables with 6 obs. of 2 vars
         actLables <- read.table("activity_labels.txt")
         ##561 obs. of 2 vars
         features <- read.table("features.txt")
        
        cat("[run_analysis.R]","merging train dataset...", "\n")
        ##------1. reshape train data
               
               
                ## train subject---extract train subject preparing for merging data
                        ##with 7352 obs of 1 vars
                        train.subject <- read.table("./train/subject_train.txt")      
                        names(train.subject) <- "subject"   
                
                ## train activity---merge y_train with activity_labels and get the train activity name vector
                        ## with 7352 obs. of 1 vars
                        train.y <- read.table("./train/y_train.txt")
                        ## with 7652 activity obs. of 1 vars. As actLables is a factor, which need to be transfered to data frame
                        train.activity <- data.frame(actLables[train.y[,1],2])
                        names(train.activity) <- "activity"
                   
                ## train x --- change the name of  train activity with train.x
                        ##with 7352 obs of 561 vars
                        train.x <- read.table("./train/X_train.txt")
                        ## change names of the column
                        newNames <- features[[2]]  
                        colnames(train.x) <- newNames
                       
                     
                            
                
                ##combine train.subject, train.activity and train.x
                        train.xy <- cbind(train.subject, train.activity, train.x)
                        
        cat("[run_analysis.R]","merging test dataset...", "\n")
        ##------2. Merge test data 
                        
                ## train subject---extract train subject preparing for merging data
                        ##with 2947 obs of 1 vars 
                        test.subject<- read.table("./test/subject_test.txt") 
                        test.subject<- rename(test.subject, subject = V1)
                
                ## Test activity --- merge y_train with activity_labels and get the train activity name vector
                        ## with 2947 obs. of 1 vars
                        test.y <- read.table("./test/y_test.txt")
                        ## with 2947 activity obs. of 1 vars. As actLables is a factor, which need to be transfered to data frame
                        test.activity <- data.frame(merge(test.y, actLables,by = "V1", all = FALSE)[,2])
                        names(test.activity) <- "activity"
        
        
                ## Test x --- change the name of  train activity with train.x
                        ##with 2947 obs of 561 vars
                        test.x <- read.table("./test/X_test.txt")
                        ## change measures' name
                        newNames <- features[[2]]  
                        names(test.x) <- newNames    
                        
                          
                        
                ##combine test.subject, test.activity and test.x.
                        test.xy <- cbind(test.subject,test.activity, test.x)
        
        cat("[run_analysis.R]","merging train and test dataset...", "\n")
        
        ##------3. Merges the training and the test sets to create one data set.
                        
                        data <-rbind(train.xy, test.xy)
        
        cat("[run_analysis.R]","outputing dataset...", "\n")
        ##------4. Extracts only the measurements on the mean and standard deviation for each measurement.
        
                        x <- grep("[Mm]ean|[Ss]td|activity|subject", colnames(data))
                        data <- data[,x]
        
        
        
        ##------5. create independent tidy data set with the average of each variable for each activity and each subject
                
                        dataMelt <- melt(data, id = c("subject","activity"))    ##melt data in to id variables and measure variables
                        dataDcast <- dcast(dataMelt, subject + activity ~ variable, mean)
                        
                        ##alternative method     
                        ##library(plyr)
                        ##averages <- ddply(data, .(subject, activity), function(x) colMeans(x[,3:88]))
        
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

packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)


setwd("C:/Users/Sid/Desktop/coursera")
getwd()

url <-url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "Dataset.zip"
if(!file.exists(path)){dir.create(path )}
 download.file(url,file.path(path,f))

outDir <-"C:/Users/Sid/Desktop/coursera"
 unzip(f,exdir=outDir)
path2 <- file.path(path,"UCI HAR Dataset")
 files <- list.files(path2,recursive = TRUE)
 files




 dataSubjectTest <- read.table(file.path(path2,"test","Y_test.txt"),header = FALSE)
 dataSubjectTrain <- read.table(file.path(path2,"train","Y_train.txt"),header = FALSE)
 dataSubjectTest <- read.table(file.path(path2,"test","subject_test.txt"),header = FALSE)
 dataSubjectTrain <- read.table(file.path(path2,"train","subject_train.txt"),header = FALSE)
 dataActivityTest <- read.table(file.path(path2,"test","Y_test.txt"),header=FALSE)
 dataActivityTrain <- read.table(file.path(path2,"train","Y_train.txt"),header=FALSE)
 dataFeaturesTest <- read.table(file.path(path2,"test","X_test.txt"),header = FALSE)
 dataFeaturesTrain <- read.table(file.path(path2,"train","X_train.txt"),header = FALSE)
 dataSubject <- rbind(dataSubjectTrain,dataSubjectTest)
 dataActivity <- rbind(dataActivityTrain,dataActivityTest)
 dataFeature <- rbind(dataFeaturesTrain,dataFeaturesTest)
 names(dataSubject) <- c("subject")
 names(dataActivity) <- c("activity")
dataFeaturesNames <- read.table(file.path(path2,"features.txt"),head=FALSE)


names(dataFeature) <- dataFeaturesNames$V2
 dataCombine <- cbind(dataSubject,dataActivity)
 Data <- cbind(dataFeature,dataCombine)

subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)",dataFeaturesNames$V2)]
 selectedNames <- c(as.character(subdataFeaturesNames),"subject","activity")
Data <- subset(Data,select=selectedNames)


activityLabels <- read.table(file.path(path2, "activity_labels.txt"),header = FALSE)

 names(Data) <- gsub("^t","time",names(Data))
 names(Data)<-gsub("^f", "frequency", names(Data))
 names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
 names(Data)<-gsub("Mag", "Magnitude", names(Data))
 names(Data)<-gsub("BodyBody", "Body", names(Data))
 names(Data)

 library(plyr);
 Data2<-aggregate(. ~subject + activity, Data, mean)
 Data2<-Data2[order(Data2$subject,Data2$activity),]
 write.table(Data2, file = "tidydata.txt",row.name=FALSE)
 


library(knitr)
knit2html("codebook.Rmd"); 




# getting and cleaning data
# project
site<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path<-getwd()
pathtest<-paste(path,"./UCI HAR Dataset/test",sep="")
pathtrain<-paste(path,"./UCI HAR Dataset/train",sep="")
pathUCI<-paste(path,"./UCI HAR Dataset",sep="")
download.file(site,"data.zip")
unzip("data.zip")
#
# Get the train and test data set
#
setwd(pathtrain)
train<-read.csv("X_train.txt",sep="")
tra_class<-read.csv("Y_train.txt",sep="")
setwd(pathtest)
test<-read.csv("X_test.txt",sep="")
test_class<-read.csv("Y_test.txt",sep="")
#
# merging the data sets
#
library(dplyr)
names(train)<-names(test)
all<-rbind(train,test)
#
# adding variable names to the data set
#
setwd(pathUCI)
feature<-read.csv("features.txt",sep="",header=FALSE)
feature<-feature[2]
feature %>% mutate_if(is.factor, as.character) -> feature
feature1<-as.vector(matrix(unlist(t(feature)), byrow=T, 1, 561))

#
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
#
ext<-grep("mean|std",feature1)
variables<-grep("mean|std",feature1,value=TRUE)
colnames(all)<-feature1
extmeanstd<-all[ext]
View(extmeanstd)
#
# 3.Uses descriptive activity names to name the activities in the data set
#
activitydescriptive<-read.csv("activity_labels.txt",sep="",header = FALSE)
activitydescriptive<-activitydescriptive[2]
activitydescriptive<-as.vector(matrix(unlist(t(activitydescriptive)), byrow=T, 1, 6))
activity<-rbind(tra_class,test_class)
activitydes<-activity %>%
  mutate(activitydescriptive=activitydescriptive[X5])
allwithactivity<-cbind(activitydes[2],all)
View(allwithactivity)

#
# 4.Appropriately labels the data set with descriptive variable names
#
feature1<-gsub("[()]","",feature1)
names(all)<-feature1

#
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
trainsubject<-read.csv("train/subject_train.txt",sep="")
testsubject<-read.csv("test/subject_test.txt",sep="")
names(trainsubject)<-names(testsubject)
subject<-rbind(trainsubject,testsubject)
names(subject)<-"subject"
fullname<-c()
subject_activity_all<-cbind(subject,allwithactivity)
View(subject_activity_all)
extmean<-grep("mean|std",names(second_dataset))
second_dataset<-cbind(subject_activity_all[1:2],subject_activity_all[extmean])
library(tidyr)
second<-aggregate(. ~subject + activitydescriptive, second_dataset, mean)
setwd(path)
write.table(second,"tidy.txt",row.names=FALSE)

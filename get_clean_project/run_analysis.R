#downloading the file

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("project_data")){
        dir.create("project_data")
}
download.file(url,destfile="./project_data/data.zip")
need<-unzip("./project_data/data.zip",overwrite=T)
unlink("./project_data",recursive=T)

#set working directory to the extracted location

setwd("C:/Users/Allyas/datasciencecoursera/UCI HAR Dataset")
library(data.table)

# reading the train and test data sets
train_x<-read.table("./train/X_train.txt")
train_y<-read.table("./train/y_train.txt")
train_sub<-read.table("./train/subject_train.txt")

test_x<-read.table("./test/X_test.txt")
test_y<-read.table("./test/y_test.txt")
test_sub<-read.table("./test/subject_test.txt")

# bringing them to gether or merge
data_x<-rbind(train_x,test_x)
data_y<-rbind(train_y,test_y)
data_sub<-rbind(train_sub,test_sub)

allfeatures<-read.table("./features.txt")

#extracting only the mean and standard deviation
look_for_mean_and_std<-grep("-(mean|std)\\(\\)",allfeatures[,2])
data_x<-data_x[,look_for_mean_and_std]

#naming appropraitely
names(data_x)<-allfeatures[look_for_mean_and_std,2]

act_labels<-read.table("./activity_labels.txt")
data_y<-act_labels[data_y[,1],2]

#converting into data frame

data_y<-as.data.frame(data_y)

# now I could rename it
names(data_y)<-c("activity")
names(data_sub)<-c("subject")
final_data<-cbind(data_x,data_y,data_sub)
#convert to a datatable. I wanted to save time so created final_data1 else could use final_data
final_data1<-data.table(final_data)
#getting the new data set

new<-final_data1[,lapply(.SD,mean),by=c("activity","subject")]
write.table(new, "new.txt", row.name=FALSE)






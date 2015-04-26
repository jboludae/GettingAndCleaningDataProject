# We load the dplyr library
library(dplyr)
# We define a function that creates a vector of descriptive variables
f<-function(x){
  a<-gsub('-','',x)
  b<-sub('tBody','TotalBody',a)
  a<-sub('mean()',"Meanselect",b,fixed=T,)
  b<-sub('std()',"Stdselect",a,fixed=T)
  a<-sub('tGravity','TotalGravity',b,fixed=T)
  b<-sub('fBody','FrequencyBody',a,fixed=T)
  b
}
#We read the test data first
X_test<-read.table("data/test/X_test.txt")
# now the activity and the subject
y_test<-read.table("data/test/y_test.txt")
subject_test<-read.table("data/test/subject_test.txt")
# we load the features so we can give descriptive column names to our data set
features<-read.table("data/features.txt",colClasses="character")
names(X_test)<-f(features$V2)
# we add activity number and subject variables to our data set
names(subject_test)<-"Subject"
names(y_test)<-"Activity"
# we merge everything in a single data frame
test<-data.frame(subject_test,y_test,X_test)
# we do the same for the train data
X_train<-read.table("data/train/X_train.txt")
y_train<-read.table("data/train/y_train.txt")
subject_train<-read.table("data/train/subject_train.txt")
names(X_train)<-f(features$V2)
names(subject_train)<-"Subject"
names(y_train)<-"Activity"
train<-data.frame(subject_train,y_train,X_train)
# we merge both tables
merged<-rbind(test,train)
# we extract the measurements on mean and standard deviation
merged_mean_std<-merged[,c(1,2,which(grepl("select",names(merged),fixed=F)))]
# we remove the flag "select" from names
names(merged_mean_std)<-sub("select","",names(merged_mean_std))
# we load the activity labels from the txt file
activity_labels<-read.table("data/activity_labels.txt",colClasses=c("integer","character"))
# we add a column with the descriptive activity names
merged_mean_std<-merge(merged_mean_std,activity_labels,by.x="Activity",by.y="V1",sort=F)
merged_mean_std$Activity<-merged_mean_std$V2
merged_mean_std$V2<-NULL
# we rearrange the columns so subject and activity are in first place
merged_mean_std<-select(merged_mean_std,Subject,Activity,everything())
merged_mean_std<-arrange(merged_mean_std,Subject,Activity)
# we group by subject and by activity
merged_mean_std<-group_by(merged_mean_std,Subject,Activity)
# we calculate the mean for each of the groups and assign the new table to the final data set
sum_merged_mean_std<-summarise_each(merged_mean_std,funs(mean),-c(Subject,Activity))
# we remove all useless variables from environment
rm(activity_labels,features,merged,subject_test,subject_train,test,train,X_test,X_train,y_test,y_train)

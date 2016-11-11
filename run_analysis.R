rm(list=ls(all=TRUE))
setwd("C:/Users/ALi/Documents/data_cleaning/data_cleaning_prj")

X_test <- read.table("./test/X_test.txt",header=FALSE)
y_test <- read.table("./test/y_test.txt",header=FALSE)
subject_test <- read.table("./test/subject_test.txt", header=FALSE)
features <- read.table("./features.txt",header=FALSE)
ds_test <- data.frame(subject_test, y_test, X_test)
names(ds_test) <- c("subject","activity",as.character(features[,2]))
activity_labels <- read.table("activity_labels.txt",header=FALSE)
ds_test$activity <- factor(ds_test$activity,labels = activity_labels[,2])
ds_test <- cbind(data.frame(set = rep("test",nrow(ds_test))),ds_test)

X_train <- read.table("./train/X_train.txt",header=FALSE)
y_train <- read.table("./train/y_train.txt",header=FALSE)
subject_train <- read.table("./train/subject_train.txt", header=FALSE)
ds_train <- data.frame(subject_train, y_train, X_train)
names(ds_train) <- c("subject", "activity",as.character(features[,2]))
ds_train$activity <- factor(ds_train$activity,labels = activity_labels[,2])
ds_train <- cbind(data.frame(set = rep("train",nrow(ds_train))),ds_train)

ds_all <- rbind(ds_test,ds_train)

col_select <- grep("mean|std",names(ds_all))
ds_select <- ds_all[,c(2,3,col_select)]
ds_select_2 <-  aggregate(.~ activity + subject, data = ds_select, mean)
write.table(ds_select_2,"tidy_data_set_step_5.txt",row.names = FALSE,sep=",")
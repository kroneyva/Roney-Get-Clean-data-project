library(dplyr)
# load the human activity recognition using smartphone 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "./dataset.zip")
# unzip the file and place the contents in a new directory called "UCI HAR Dataset"
unzip("dataset.zip")

#Create list for names for the columns and rows that will be used for merging the data
read_colnames<- read.table("./UCI HAR Dataset/features.txt", sep = "", header = FALSE)
read_colnames[,2]<-as.character(read_colnames[,2])
read_rownames<-read.table("./UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
#read_rownames<-as.character(read_rownames[,2])

#The only features needed are the mean (mean) and standard deviations(std), therefore only those features
#will be keep
req_col<-grep(".*std.*|.*mean.*", read_colnames[,2])
req_col_names<-read_colnames[req_col,2]
req_col_names <-  gsub('[-()]', '', req_col_names)

#read in and combined test data folder
test_set<- read.table("./UCI HAR Dataset/test/X_test.txt",sep = "")[req_col] #test set
test_labels<-read.table("./UCI HAR Dataset/test/y_test.txt",sep = "") # activity labels
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",sep = "") #subject id of the test
new_testset <- cbind(test_subject,test_labels,test_set) #combine by column the 3 dataframes, while merge is a potential it would require two iteration to combine 3 data frames
colnames(new_testset)<-c("Subject","Activity",req_col_names) # change the column header labels
rm(test_set)


#read in and combined train data folder
train_set<- read.table("./UCI HAR Dataset/train/X_train.txt",sep = "")[req_col] #train set
train_labels<-read.table("./UCI HAR Dataset/train/y_train.txt",sep = "") # activity labels
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",sep = "") #subject id of the train
new_trainset <- cbind(train_subject,train_labels,train_set) #combine by column the 3 dataframes, while merge is a potential it would require two iteration to combine 3 data frames
colnames(new_trainset)<-c("Subject","Activity",req_col_names) # change the column header labels
rm(train_set)

#create a single dataset with both test and train data.
complete_dataset <- rbind(new_trainset,new_testset)

#next is to create a new tidy dataset (mean_Var_ds) using complete_dataset with the average (mean) of each variable (columns) for each activity (colname="Activity) and each subject (colname="Subject). 
#my interpertation of the requirement is to compute the mean for each variable organize by grouping the activity then by subject.  
#to create mean_Var_ds need to group the data.  I chose to use the aggregrate function.  aggregrate will split the data into subsets
#based upon the two conditions, then compute the mean for each variable, and return a new data set with mean for each
#variable by activity and subject.    
#first step is create grouping lists

subj_list <- factor(complete_dataset$Subj)
activity_list<- factor(complete_dataset$Activity)

mean_Var_ds <- aggregate(complete_dataset,by=list(activity_list, subj_list),FUN = "mean")
#remove unneeded columns

mean_Var_ds<- mean_Var_ds[,-(3:4)]
colnames(mean_Var_ds)<-c("Activity","Subject",req_col_names)
mean_Var_ds$Activity <- factor(mean_Var_ds$Activity, levels = read_rownames[,1], labels = read_rownames[,2])

# write mean_Var_ds to a text file
write.table(mean_Var_ds,file = "tidy.txt", quote = FALSE,row.names = FALSE)



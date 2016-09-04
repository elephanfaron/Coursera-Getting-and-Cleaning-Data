library(dplyr)

####
#1. REading the data sets and merging them
###


#reading the test and train data set
testset <- read.table("./test/X_test.txt")
trainset <- read.table("./train/X_train.txt")


#reading features and setting them as the column names
features <- read.table("features.txt", header = FALSE)
features <- features$V2
colnames(testset) <- features
colnames(trainset) <- features

#reading the test and train labels (ie activities)
#adding the labels as the first column of each data set
testlabels <- read.table("./test/y_test.txt")
testlabels <- testlabels$V1
trainlabels <- read.table("./train/y_train.txt")
trainlabels <- trainlabels$V1
testset <- cbind(testlabels, testset)
trainset <- cbind(trainlabels, trainset)
colnames(testset)[1] <- "Activity"
colnames(trainset)[1] <- "Activity"

print("activity done")

#reading and adding the subject id as the first column of each dataset
testsubjects <- read.table("./test/subject_test.txt")
testsubjects <- testsubjects$V1
trainsubjects <- read.table("./train/subject_train.txt")
trainsubjects <- trainsubjects$V1
testset <- cbind(testsubjects, testset)
trainset <- cbind(trainsubjects, trainset)
colnames(testset)[1] <- "subjectid"
colnames(trainset)[1] <- "subjectid"

print("subject done")

#Merging the 2 datasets, sorting and cleaning
dataset <- rbind(testset, trainset)
rm(features, testlabels, trainlabels, testset, trainset)

print("merging done")

###
#2. Extracting only mean and std deviation measurements
###
extract <- grep("mean|std", names(dataset), ignore.case = TRUE)
dataset <- dataset[c(1,2,extract)] #not forgetting the activity and subject column
rm(extract)
dataset <- select(dataset, -grep("angle", names(dataset)))
dataset <- select(dataset, -grep("[mM]ean[Ff]req", names(dataset)))

print("extract done")

###
#3. naming the activities in the dataset
###
activitytable <- read.table("./activity_labels.txt")
activitytable$V2 <- tolower(gsub("_","",activitytable$V2))
dataset$Activity <- activitytable$V2[dataset$Activity]
rm(activitytable)

print("activities renamed")

###
#4. labelling the dataset with descriptive variable names
###
names(dataset) <- gsub("mean", "Mean", names(dataset))
names(dataset) <- gsub("std", "Std", names(dataset))
names(dataset) <- gsub("-", "", names(dataset))
names(dataset) <- gsub("\\()", "", names(dataset))

###
#5. creating a second data set presenting the average for each activity and each subject
###
meanDS <- dataset %>% group_by(Activity, subjectid) %>% summarize_each(funs(mean))

###
#6. Exporting the data in txt files.
###
if (!file.exists("Tidy Data")) {
  dir.create("Tidy Data")
}
write.table(dataset, "./Tidy Data/dataset.txt", row.names = FALSE)
write.table(meanDS, "./Tidy Data/meanDS.txt", row.names = FALSE)



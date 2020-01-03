library(dplyr)
 
# Download zip into folder
if(!file.exists("Assignment.zip")) {
	url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(url, "Assignment.zip", method="curl")
}

if(!file.exists("UCI HAR Dataset")) {
	unzip("Assignment.zip")
}

# Read in data to variables
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Merge data
training <- cbind(subject_train, x_train, y_train)
testing <- cbind(subject_test, x_test, y_test)
merged <- rbind(training, testing)

# Extract mean/std
tidy_merged <- merged %>% select(subject, code, contains("mean"), contains("std"))

# Use descriptive names
tidy_merged$code <- activities[tidy_merged$code, 2]

# Label data set
names(tidy_merged)[2] = "activity"
names(tidy_merged) <- gsub("Acc", "Accelerometer", names(tidy_merged))
names(tidy_merged) <- gsub("Gyro", "Gyroscope", names(tidy_merged))
names(tidy_merged) <- gsub("BodyBody", "Body", names(tidy_merged))
names(tidy_merged) <- gsub("Mag", "Magnitude", names(tidy_merged))
names(tidy_merged) <- gsub("^t", "Time", names(tidy_merged))
names(tidy_merged) <- gsub("^f", "Frequency", names(tidy_merged))
names(tidy_merged) <- gsub("tBody", "TimeBody", names(tidy_merged))
names(tidy_merged) <- gsub("-mean()", "Mean", names(tidy_merged), ignore.case = TRUE)
names(tidy_merged) <- gsub("-std()", "STD", names(tidy_merged), ignore.case = TRUE)
names(tidy_merged) <- gsub("-freq()", "Frequency", names(tidy_merged), ignore.case = TRUE)
names(tidy_merged) <- gsub("angle", "Angle", names(tidy_merged))
names(tidy_merged) <- gsub("gravity", "Gravity", names(tidy_merged))

# Create 2nd, independent tidy data set
more_data <- tidy_merged %>%
	group_by(subject, activity) %>%
	summarise_each(funs(mean))

# Write out this data
write.table(more_data, "more_data.txt", row.name=FALSE)
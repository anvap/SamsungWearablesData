# Install and load the required libraries if they are not present yet
pkg <- c("plyr", "dplyr", "reshape2")
new.pkg <- pkg[!(pkg %in% installed.packages())]
if (length(new.pkg)) {
    install.packages(new.pkg)  
}
for (package in pkg) {
    require(package, character.only = TRUE)  
}
# Remove the data from the environment as they are not needed anymore
rm(pkg,new.pkg,package)

# Check whether the Samsung data is present in the correct folder name and if not, give a warning.
if (file.exists("UCI HAR Dataset")){   
    # Gather the data from the correct files.
    # First read in the features file.
    # So that the correct feature name can be used for reading in the x datasets with col.names.
    # I do this now as otherwise the column order could be different when I applied functions to it.
    features <- read.table("UCI HAR Dataset/features.txt")
    x_train <- read.table("UCI HAR Dataset/train/X_train.txt",
                          col.names=features[,2])
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt",
                          col.names="activity")
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                                col.names="subject")
    x_test <- read.table("UCI HAR Dataset/test/X_test.txt",
                         col.names=features[,2])
    y_test <- read.table("UCI HAR Dataset/test/y_test.txt",
                         col.names="activity")
    subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                               col.names="subject")
    
    #1 Merge the training and the test sets to create one data set.
    # First merge the trainin data and test data into separate dataframes (subject, activity and features).
    merge_train <- cbind(subject_train, y_train, x_train)
    merge_test <- cbind(subject_test, y_test, x_test)
    # Then merge those two dataset (train & test), to create one dataset
    merged_data <- rbind(merge_train,merge_test)
    # Remove the data from the environment as they are not needed anymore
    rm(features, x_train, y_train, subject_train, x_test, y_test, subject_test, merge_train, merge_test)
    
    #2 Extracts only the measurements on the mean and standard deviation for each measurement. 
    # I chose to only select the measurements on basic mean and standard deviation.
    # (e.g. not meanFreq as this is about the frequency average)
    # These have a dot before and after because all symbols (i.e. -,(,)) in the feature names were replaced with dots.
    # I also want to keep the subject and activity columns.
    selected_data <- select(merged_data, matches("subject|activity|\\.mean\\.|\\.std\\."))
    
    #3 Uses descriptive activity names to name the activities in the data set
    # First get the activity labels from the file
    # Then map the values in the data (number) to the descriptive activity name (label)
    activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
    colnames(activity_labels) <- c("number","label")
    activity_labels$label <- as.character(activity_labels$label)
    selected_data$activity <- mapvalues(selected_data$activity,
                                        from = activity_labels$number,
                                        to = activity_labels$label)
    # Remove the data from the environment as they are not needed anymore
    rm(activity_labels)
    
    #4 Appropriately labels the data set with descriptive variable names.
    # The colnames were already named with the correct feature when reading the data in.
    # However, when reading the data in, the symbols (i.e. -,(,)) were replaced with dots.
    # Which resulted in a lot of extra dots, which I remove here.
    names(selected_data) <- gsub("\\.\\.", "", names(selected_data))
    # There was a typo on some of the features which caused them to contain BodyBody instead of Body
    names(selected_data) <- gsub("BodyBody", "Body", names(selected_data))
    # There were some abbreviations in the feature name, which I replaced with the full name
    names(selected_data) <- gsub("^t", "time", names(selected_data))
    names(selected_data) <- gsub("Acc", "Acceleration", names(selected_data))
    names(selected_data) <- gsub("Gyro", "Gyroscope", names(selected_data))
    names(selected_data) <- gsub("Mag", "Magnitude", names(selected_data))
    names(selected_data) <- gsub("f", "frequency", names(selected_data))
    # The final variable name is structured like this:
    ## feature.measurement.axis
    ### where feature is explained further in the codebook?
    ### where measurement is either mean or standard deviation (std)
    ### where axis can be X, Y, Z or no axis specified
    
    #5 From the data set in step 4, creates a second, independent tidy data set
    # with the average of each variable for each activity and each subject.
    # For this I decided to have the following columns:
    ## variable - activity - subject - average
    # This way the data will show for each variable different attributes
    # with the focus on the variable, not the activity or subject.
    # I choose this as the question first asks about the average of each variable
    # Also, I prefer the data to not be too wide.
    tidy_data <- selected_data %>%
        melt(id.vars = c("activity", "subject"),
             variable.name = "variable", 
             value.name = "value") %>%
        group_by(variable, activity, subject) %>%
        summarise(average = mean(value))
    
    # The final result is:
    ## the merged_data from step 1,
    ## the selected_data from step 4,
    ## and the tidy_data from step 5
    View(tidy_data)
    write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)

} else {
    warning("Samsung data is not present in the correct folder. Please make sure the Samsung data is unzipped correctly in the 'UCI HAR Dataset' folder")
}
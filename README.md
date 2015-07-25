### Introduction
This script will allow you to turn the Samsung wearables data into a tidy data set. The tidy dataset will give you for each signaltype from a subjects samsung phone, an average per activity and per subject.
This script can be run as long as the (raw) Samsung data is in your working directory.

If you do not have the data in your working directory, there will be a warning message. If so, please run the following script first:

    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, "course_assignment.zip", method="curl")
    unzip("course_assignment.zip")

### Run the script
to run the script use:

    source("run_analysis.R")
    
In the script, the necessary packages are loaded (i.e. plyr, dplyr and reshape2).
Afterwards the data is read and merged into one dataset.
From there on, specific variables (on the mean and standard deviation) are selected.
And finally the averages are calculated for each variable, for each activity and each subject. This results in the final 'tidy_data' dataframe.

### The output of the script
Please note that it could take a few moments before the output of the script appears and messages of loading the required packages could appear.

The script will open the tidy_data dataframe and will save a tidy_data.txt file to your working directory.
If you would want to read this tidy_data.txt file in later, you need to use the following script:

    data <- read.table("tidy_data.txt", header=TRUE)
    View(data)    
    
In the environment you will also find:

- the merged_data dataframe (with more measurements than only mean and standard deviation)
- the selected_data dataframe (the data before the averages were calculated)

---------
### References
Reference of the Samsung data: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
    

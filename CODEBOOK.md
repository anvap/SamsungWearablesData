## DATA DICTIONARY - tidy_data.txt
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.

Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist.

Using its embedded accelerometer and gyroscope, Samsung captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

### Variable
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. 

To remove noise, the signals were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.

Each acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm.

For some of the signals, a Fast Fourier Transform (FFT) was applied (Note the 'frequency' to indicate frequency domain signals). 

For each signal, the set of variables that were estimated from these signals are: 

* .mean: Mean value
* .std: Standard deviation

The three-dimensional signals (each variable has a .X, .Y or .Z direction):

* timeGravityAcceleration
* timeBodyAcceleration
* timeBodyAccelerationJerk
* timeBodyGyroscope
* timeBodyGyroscopeJerk
* frequenceBodyAcceleration
* frequenceBodyAccelerationJerk
* frequenceBodyGyroscope

Magnitude signals (based on the three-dimensional signals, the magnitude signals were calculated using the Euclidean norm):

* timeBodyAccelerationJerkMagnitude
* timeBodyAccelerationMagnitude
* timeBodyGyroscopeJerkMagnitude
* timeBodyGyroscopeMagnitude
* timeGravityAccelerationMagnitude
* frequencyBodyAccelerationJerkMagnitude
* frequencyBodyAccelerationMagnitude
* frequencyBodyGyroscopeJerkMagnitude
* frequencyBodyGyroscopeMagnitude

### Activity
There are 6 activities performed by the subjects:

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

### Subject
Each number identifies a subject who performed the activity. Its range is from 1 to 30. 

### Average
For each variable the average was calculated, for each activity and each subject.
Features are normalized and bounded within [-1,1].

---------
### References
Reference of the Samsung data: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
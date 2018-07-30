## Raw data
Data we used for this project represents data that collected from the accelerometers from the Samsung Galaxy S smartphone. Raw data has the 2 following part:
* train
* test

Number of observation for train and test data sets are different (row length), but number of their features are the same (column length).

## project's procedure
The peer-graded assignment for this course has the five following steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Step 1 (getting and merging data)
1. For this part I first download zip data from the following website and then unzip the data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
2. For doing this projet I used the following R packages function.
* dplyr
* tidyr
3. Read both train and test data set and merge them by using cbind function (the result data-frame ("all") has 10297*561 dimension)

### Step 2 (selecting and cleaning data)
1. First Download feature data set to use for fining the position of mean and std in the "all" dataset
1. For this part we only need mean and standard deviation (std) features. So, we need to search in the features and select those that have std or mean in their name (I called it "extmeanstd").
2. The result for this part has dimension of 10297*79 ("extmeanstd")

### Step 3 (combine new column to old data)
1. Read activity and descriptive activity ( it contains 6 different activities)
2. Combine and merge the descriptive activity to "extmeanstd" data set and name the new dataset "allwithactivity".
3. The result for this part has dimension of 10297*80 

### Step 4 (rename the data set)
1. delete "()" character from feature data set and use it as the name of "all" data set

### Step 5 (group data and get the mean for each variable)
1. Read and combine "subject" data set to the previous data set (using cbind function).
2. aggreagate data by subject and activity and get the mean for all variables
3. The final dataset has the dimension of 180*81

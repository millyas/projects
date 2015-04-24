#Introduction
The script run_analysis.R performs the 5 steps as described in the project's definition.

First, all the similar data is merged using the rbind() function. By similar, we address those files having the same number of columns and referring to the same entities (train and test).
Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt using grep().
As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
On the whole dataset, those columns with unclear column names are corrected.
Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called new.txt, and uploaded to this repository.
#Variables
train_x, train_y, test_x, test_y, train_sub and test_sub contain the data from the downloaded files.
data_x, data_y and data_sub merge the previous datasets to further analysis.
features contains the correct names for the data_x dataset, which are applied to the column names stored in look_for_mean_and_std, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
data_final merges data_x, data_y and data_sub in a big dataset.
Finally, new contains the relevant averages which will be later stored in a .txt file. we obtain this by using the table command which helps us to use the lapply function thus getting the averages data for all columns 1 to 66.
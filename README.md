#1: Loading, cleaning & merging data
First I load the datasets (features.txt, activity_labels.txt, subject_test.txt, subject_train.txt, X_test.txt, X_train.txt, Y_test.txt, Y_train.txt) into R, through the data.table() command
In the process of reading the features.txt dataset, I call the columns: c("n", "functions")
In the process of reading the activity_labels.txt I call the columns: c("code", "activity")
In the process of reading both subject_test.txt and subject_train.txt I call the column: "subject"
In the process of reading both the X_test.txt and X_train.txt I call the columns by the name of features$functions 

I append the X_test.txt and X_train.txt to create the xmerged dataset through the rbind command (X_test and X_train have the same number of columns).
Later I append the Y_test.txt and Y_train.txt to create the ymerged dataset through the rbind command (Y_test and Y_train have the same number of columns). Then I change the name of the column (there's only one column) to "code", because the data in that column corresponds to the activity code.
Then I merge the ymerged dataset (created previously) with the activity_labels.txt, in order to know the name of the activity rather than the activity code that appears in the ymerged dataset.
Then I append the subject_train.txt and subject_test.txt into one dataset called subjectmerged.
After that I create the xymerged binding the columns from xmerged, ymerged and subjectmerged
Finally I create the xymerged2 dataframe, which is the xymerged dataset but converting the last three columns (code, activity, subject) in the first three columns of the dataset, just to facilitate the analysis. 

#2. Find out the mean and sd for each variable
I create a function called a, which creates a data.frame called output(data.frame) and two vectors, one called means, another one called sd, and another one called names, which extracts the names of the columns of the dataset. 
Then I make a for loop, which loops over the columns of the dataset and fills the vector means and sd (created previously) with the mean and sd (respectively) of each measurement.
Finally I fill the empty output dataframe through column-binding the three previous vectors(names, means and sd).
Then I pass the as.dataframe function to be sure that it is a dataframe, and I eliminate the first three rows, because they aren't numerical and so their mean and sd cannot be calculated.
Finally I try the function and it works

#3. Find out the average for each variable for each activity and each subject
I group_by activity and subject  the xymerged2 dataset and use the summarise_all function to pass the mean() function to all the grouped variables. I assign this result to a new data.frame called xymerged_grouped3
Finally I use the write.table function to extract the data from this dataframe and write it into a .txt file, to submiti it to Coursera.

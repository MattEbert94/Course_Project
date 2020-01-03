## run_analysis.R Explanation

The run_analysis.R file downloads the data from the ZIP file and extracts it to a local variable. This data is used throughout to be manipulated and adjusted to meet the assignment criteria.

The data is assigned to different variables as shown below:
- features: from features.txt
- activities: from activities.txt
- subject_train: from subject_train.txt
- x_train: from x_train.txt
- y_train: from y_train.txt
- subject_test: from subject_test.txt
- x_test: from x_test.txt
- y_test: from y_test.txt

The data was then merged together to form one dataset that encompasses all the training and test data. The data was merged used a combination of cbind()'s and rbind()'s into one final merged variable.

The mean and standard deviation were then extracted into tidy_merged and assigned specific names.

The columns were then reassigned names to be more specific to the data.

Finally, the data was outputted to a more_data.txt file.

# GettingAndCleaningDataProject
This script follows the instructions from the project step by step, from reading
the data from, to creating the required tidy data set IN ITS WIDE FORM.
The script starts loading the only library we will use: dplyr.
It then defines a function f() that takes as inpunt a "names" vector
and outputs a tidy version of it: no ".", as less abreviations as possible,
etc. It also adds a flag called "select" in order to make easy to select
the variables that contain "mean()" and "std()" (step 2).
 The process works as follows:
 1. We read X_test.txt, y_test.txt, features.txt and subject_test.txt
 2. We name the columns of X_test.txt using the function we defined with
 the 560+ features vector as input. We now have "tidy" and descriptive names for X_test.
 3. We add columns specifying Subject and Activity
 4. We repeat step 1, 2 and 3 for the train data
 5. We merge the test and train data using rbind to obtain "merged"
 6. Using the grepl function and the "select" flag created by my f() function,
 we extract only the mean() and std() columns. We then remove the "select" flag
 by using the sub() function -> our data is now stored under the merged_mean_std variable
 7. We read the activity labels from the activity_labels.txt file
 8. We merge activity_labels with merged_mean_std, and then substitute the activity numbers
 by its descriptive names. The process does not feel very elegant to me, but does the job.
 9. We rearrange columns and rows so the dataset looks more tidy using select() to arrange
 columns and arrange() to arrange rows
 10. We grop_by subject and activity
 11. We use the summarise_each function to apply the mean() function to each group and column
 of course we exclude the Subject and Activity columns from this step
 12. We remove all useless variables from the environment

And that's it! A tidy data set in a wide form, with descriptive variable names!
Hope the code and explanation was clear enough.
Final Class Project --- Cleaning and Tidying Data Sets
-------------------------------------------------------
Code Book File: Explaining Data Manipulation and Thought Process

First, I will list the variable names for the 'final_tidy' data frame that is produced by 'run_analysis.R':

"Subject.ID", "Activity.Label", "t Body Acc mean X", "t Body Acc mean Y", "t Body Acc mean Z", "t Gravity Acc mean X", "t Gravity Acc mean Y", "t Gravity Acc mean Z", "t Body Acc Jerk mean X", "t Body Acc Jerk mean Y", "t Body Acc Jerk mean Z","t Body Gyro mean X", "t Body Gyro mean Y", "t Body Gyro mean Z", "t Body Gyro Jerk mean X", "t Body Gyro Jerk mean Y", "t Body Gyro Jerk mean Z", "t Body Acc Mag mean", "t Gravity Acc Mag mean", "t Body Acc Jerk Mag mean", "t Body Gyro Mag mean", "t Body Gyro Jerk Mag mean", "f Body Acc mean X", "f Body Acc mean Y", "f Body Acc mean Z", "f Body Acc mean Freq X", "f Body Acc mean Freq Y", "f Body Acc mean Freq Z", "f Body Acc Jerk mean X", "f Body Acc Jerk mean Y", "f Body Acc Jerk mean Z", "f Body Acc Jerk mean Freq X", "f Body Acc Jerk mean Freq Y", "f Body Acc Jerk mean Freq Z", "f Body Gyro mean X", "f Body Gyro mean Y", "f Body Gyro mean Z", "f Body Gyro mean Freq X", "f Body Gyro mean Freq Y", "f Body Gyro mean Freq Z", "f Body Acc Mag mean", "f Body Acc Mag mean Freq", "f Body Body Acc Jerk Mag mean", "f Body Body Acc Jerk Mag mean Freq", "f Body Body Gyro Mag mean", "f Body Body Gyro Mag mean Freq", "f Body Body Gyro Jerk Mag mean", "f Body Body Gyro Jerk Mag mean Freq", "anglet Body Acc Mean,gravity", "anglet Body Acc Jerk Mean,gravity Mean", "anglet Body Gyro Mean,gravity Mean", "anglet Body Gyro Jerk Mean,gravity Mean", "angle X,gravity Mean", "angle Y,gravity Mean", "angle Z,gravity Mean", "t Body Acc std X", "t Body Acc std Y", "t Body Acc std Z", "t Gravity Acc std X", "t Gravity Acc std Y", "t Gravity Acc std Z", "t Body Acc Jerk std X", "t Body Acc Jerk std Y", "t Body Acc Jerk std Z", "t Body Gyro std X", "t Body Gyro std Y", "t Body Gyro std Z", "t Body Gyro Jerk std X", "t Body Gyro Jerk std Y", "t Body Gyro Jerk std Z", "t Body Acc Mag std", "t Gravity Acc Mag std", "t Body Acc Jerk Mag std", "t Body Gyro Mag std", "t Body Gyro Jerk Mag std", "f Body Acc std X", "f Body Acc std Y", "f Body Acc std Z", "f Body Acc Jerk std X", "f Body Acc Jerk std Y", "f Body Acc Jerk std Z", "f Body Gyro std X", "f Body Gyro std Y", "f Body Gyro std Z", "f Body Acc Mag std", "f Body Body Acc Jerk Mag std", "f Body Body Gyro Mag std", and "f Body Body Gyro Jerk Mag std"

The first variable, 'Subject.ID' reports the identidy of the subject for a particular observation (This ID is unique, and comes fomr either the original 'train' or 'test' data sets).  The second variable, 'Activity.Label' reports the particular activity (Walking, Sitting, etc.) that a certain subject was being tested under for a particular observation/row.  The rest of the variables report the AVERAGE of the particular feature/test that the Samsung technology was recording for the particular subject/activty combination.  They have been cleaned up from the original column titles, such that there are spaces that allows for ease of readability and differentiation between the 't and f' and the 'X, Y, and Z' portions of the Samsung recording.

The data (180 observations by 88 variables) is presented such that 'Subject.ID' is an integer from 1 - 30, labeling the particular subject under study, 'Activity.Label' is a factor of 6 levels ranging from Sitting, Walaking, etc., and the rest of the data set is made up of numeric numbers.

----------------------------------------------------------------------
The 'run_analysis.R' code contains comments informing the reader about the purpose of each part of the code, but I will describe, briefly, what the analysis entailed and my thought process for tidiness:

1.) I loaded the activity labels and feature labels, to be used to identify what activity each sucbject was under when tested, and to identify the readings of each feature of the SAmsung technology during those observations.  Furthermore, I loaded up the 'train' and 'test' data, which included the actual data, activity labels, and subject IDs.

2.) I used the 'plyr' packge to join the activity labels within the 'train' and 'test' data sets to the activity labels themselves, so that I would know explicity what activity each subject was under (Walking, Sitting, etc.)

3.) I renamed the column names for the subject IDs for both the 'train' and 'test' subject IDs to read 'Subject ID'

4.) I column binded the 'train' and 'test' data sets, activity labels, and subject IDs, respectively (in this step, I explicity renamed the column for activities as 'Activity Label').

5.) I row binded the 'train' and 'test' data sets created in 4.), and then I changed the column names of all of the columns corresponding to the features/tests according to the features read from the 'features.txt' file.  (At this point, step one of the assignment was completed).

6.) I then extracted all of the features that contained 'mean' or 'std' from their name, and combined then into a new data set with the 'Subject ID' and 'Activity Label'. (At this point, step two of the assignment was completed).

7.) I used the 'tools' package to change all the 'Activity Label' factors to 'TitleCase', meaning that every word is capitalized in the titles, but are otherwise lowercase, making them readable and tidy.  Then, I systematically removed '-', and '()' from the feature column titles.  Finally, I insterted spaces in between each word in the feature column titles, ultimately making them both easily readbale and tidy. (At this point, step three and four of the assignment was completed).

8.) Finally, I systematically split the data set according to 'Subject ID' and 'Activity Label', AVERAGED the data according to that grouping, and then recombined the data into a 180 obervation by 88 variable data frame (the 180 observations come from there being 30 subjects, each undergoing 6 activities (30 times 6=180), to be averaged over 86 different Samsung features).  This 'final_tidy' data frame contains the average of all the SAmsung features, organized according to the single observations provided by 'Subject ID' and 'Activity Label'.

9.) The 'final_tidy' data set is written to the workign directory with write.table() using row.names = FALSE

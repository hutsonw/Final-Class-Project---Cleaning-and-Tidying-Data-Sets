# Final-Class-Project---Cleaning-and-Tidying-Data-Sets
Repository for the Final Class Project for the Cleaning and Tidiness Data Set

This is the README.md file associated with the Final Peer Reviewed Project associated with the Cleaning and Tidying Data Set Course offered by Johns Hopkins University

This repository contains three files:
README.md
CodeBook.md
run_analysis.R

The README file informs the reader what the relevant files are in this repository, what the run_analysis.R code assumes about the starting conditions necessary to run the code, and what the CodeBook.md file contains.

1.) The relevant files located in this repository have already been listed above.

2a.) The run_analysis.R code assumes that you set your working directory is set to the folder that contains the 'UCI HAR Dataset' folder (which is the one that you took out of the .zip file provided for this assignment).  PLEASE NOTE: THE CODE SETS YOUR WORKING DIRECTORY FOR YOU!  THUS, all you need to do at the beginning of the code is provide the string that corresponds to the path where the 'UCI HAR Dataset' folder is located, and your working directory is set.

2b.) The run_analysis.R code assumes that you have the 'tools' and 'plyr' packages installed in order to run the code.  Since this course teaches us to use routines that utilize these packages, we should have these packages already installed.  However, if you don't, just make sure that you install the 'tools' and 'plyr' packages before running run_analysis.R.

Once 2a.) and 2b.) are satisfied, you will be able to successfully run the code 'run_analysis.R', which will produce a final, tidy data frame called 'final_tidy' and will write this data frame as a txt file onto your working directory entitled 'Final_Tidy.txt'  By searching through the 'final_tidy' data frame or uploaded .txt file, you will find the required information asked for in the assignment organized with tidy and readable variable names.  NOTE: The 'final_tidy' data frame, in my opinion, is easier to read and parse through for testing the tidiness and readability of the processed data.

3.) The CodeBook.md file gives a basic walkthough of what the 'run_analysis.R' code does with respect to manipulating the original data, as well as providing my thought process for cleaning up the data.  That being said, the 'run_analysis.R' code already has detailed comments listed throughout the code, which the reader should also find helpful when working through my submission.

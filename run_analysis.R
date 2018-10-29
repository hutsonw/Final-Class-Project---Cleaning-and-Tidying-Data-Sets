# run_analysis Code (For Week 4 Peer Reviewed Activity)

# First, remove everything from your environment
rm(list = ls())

# working_dir sets the working directory for this analysis.  This assumes that that
# you are setting your working directory to be where the folder 'UCI HAR Dataset'
# is located (the one that you extract from the .zip file for this assignment).
# Change this code accordingly for you computer/system, but always set the
# directory to be the one where the 'UCI HAR Dataset' folder is located.

setwd(paste('C:/Users/hutso/Desktop/Desktop/',
        'Coursera_JohnsHopkins_DataScience/Course 3 - Data Cleaning/',
        'Week 4 Quiz',sep=''))

# Load activity_labels.txt and features.txt. The former will be used to label
# the respective subjects activity for a particular observation, and the later will
# be used to extract the particular feature or type of observation for a subjects activity

activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
features <- read.table('./UCI HAR Dataset/features.txt')

# Load the 'train' data set, the 'train' feature labels,
# and the 'train' subject labels

train_data <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_labels <- read.table('./UCI HAR Dataset/train/y_train.txt')
train_subjects <- read.table('./UCI HAR Dataset/train/subject_train.txt')

# Load the 'test' data set the 'test' feature labels,
# and the 'test' subject labels

test_data <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_labels <- read.table('./UCI HAR Dataset/test/y_test.txt')
test_subjects <- read.table('./UCI HAR Dataset/test/subject_test.txt')

# Merge/join 'test_labels' and 'train_labels' with activity labels
# Please note: This assumes that you have installed the 'plyr' package,
# so in stall that package before running this code

library(plyr)
train_labels_real <- join(train_labels,activity_labels)
test_labels_real <- join(test_labels,activity_labels)

# Rename column names for subjects, for both the 'train' and 'test'
# data sets

colnames(train_subjects)[colnames(train_subjects) == 'V1'] <- 'Subject ID'
colnames(test_subjects)[colnames(test_subjects) == 'V1'] <- 'Subject ID'

# Column bind the subjects, labels and data for the 'train' and 'test'
# data sets, respectively

test_data_all <- cbind(test_subjects,'Activity Label' = test_labels_real$V2,test_data)
train_data_all <- cbind(train_subjects,'Activity Label' = train_labels_real$V2,train_data)

# Row bind the 'train' and 'test' data sets to ultimately create the unified data set

data_all <- rbind(train_data_all,test_data_all)

# Change column names of the 'train_data' and 'test_data' according to the
# 'features' data frame. Please note, with this, step one of the Peer Reviewed Activity is complete

for (aa in seq(1,length(test_data),by = 1)){
        colnames(data_all)[colnames(data_all) == paste('V',as.character(aa),sep = '')] <- as.character(features$V2[aa])
}

# Select only those columns that correspond to a mean or an std of a particulaar
# measurement/feature, and save this as a new data set. Note: This completes step 2 of the Peer
# Reviewed Activity

mean_col <-grep('*[Mm]ean*',names(data_all))
std_col <- grep('*[Ss][Tt][Dd]*',names(data_all))

data_all_mean <- data_all[,mean_col]
data_all_std <- data_all[,std_col]

data_Mean_STD <- cbind('Subject ID' = data_all$`Subject ID`,'Activity Label' = data_all$`Activity Label`,data_all_mean,data_all_std)

# Update the Activity Labels to tidy and easily readable.  Note: You must load the library 'tools
# in order for this to work.  Thus, if not downloaded, please download the package 'tools'.  Also, this
# completes step 3 of the Peer Reviewed Activity

library(tools)
data_Mean_STD$`Activity Label` <- as.factor(toTitleCase(tolower(gsub('_',' ',data_Mean_STD$`Activity Label`))))

# Update the Variable Names to be tidy and readable. Note: This completes step 4 of the Peer Reviewed Activity

for (aa in seq(1,length(data_Mean_STD),by = 1)){
        if (!is.na(match(aa,grep('-',names(data_Mean_STD))))){
                colnames(data_Mean_STD)[aa] <- gsub('-',' ',colnames(data_Mean_STD)[aa])
        }
        
        if (!is.na(match(aa,grep('[()]',names(data_Mean_STD))))){
                colnames(data_Mean_STD)[aa] <- gsub('[()]','',colnames(data_Mean_STD)[aa])
        }
        if (!is.na(match(aa,grep('([a-z])([A-Z])',names(data_Mean_STD))))) {
                colnames(data_Mean_STD)[aa] <- gsub('([a-z])([A-Z])','\\1 \\2',colnames(data_Mean_STD)[aa])
        }
}

# Make the final tidy dataset, wherein every feature/test is averaged and
# organized according to subject and activity label

data_SubSplit <- split(data_Mean_STD,data_Mean_STD$`Subject ID`)
act_Split <- names(split(data_SubSplit[[1]],data_SubSplit[[1]]$`Activity Label`))

subID <-length(data_SubSplit)
numAct <- length(act_Split)

final_tidy_part1 <- data.frame('Subject ID' = rep(seq(1,subID,by=1),each = numAct),'Activity Label' = rep(act_Split,times = subID))
cc <- 1

for (aa in seq(1,subID,by = 1)){
        temp <- data_SubSplit[[aa]]
        temp_split <- split(temp,temp$`Activity Label`)
        for (bb in seq(1,numAct, by = 1)){
                temp_split2 <- temp_split[[bb]]
                avg_split <- sapply(temp_split2[,3:88],mean)
                
                if (cc == 1){
                        final_tidy_part2 <- data.frame(unname(t(avg_split)))
                        colnames(final_tidy_part2) <- names(avg_split)
                } else{
                        final_tidy_part2 <- rbind(final_tidy_part2,unname(avg_split))
                }
                cc <- cc + 1
        }
}

# Below is the final, tidy data set that has one observation, according to subject
# activity, and feature/test, where each feature/test is averaged! WHEN GRADING
# THIS CODE, THIS IS THE DATA.FRAME THAT WAS SUBMITTED FOR THE PEER REVIEW ACTIVITY

final_tidy <- cbind(final_tidy_part1,final_tidy_part2)

# This code writes the final, tidy data set into the working directory that was
# set at the beginning of this analysis.  Using the Instructions for the Peer Review
# Activity, the written table has one extra row and the column names were not preserved 
write.table(final_tidy,file = './Final_Tidy.txt', row.names = FALSE)
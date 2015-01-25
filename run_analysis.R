options(rpubs.upload.method = "internal")
setwd('S:/Analytics/R/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/')
#1) Merges the training and the test sets to create one data set.
# Read in the data from files
features     = read.table('./features.txt',header=FALSE); 
Type = read.table('./activity_labels.txt',header=FALSE); 
subjectTrainingdata = read.table('./train/subject_train.txt',header=FALSE); 
xTrainingdata       = read.table('./train/x_train.txt',header=FALSE); 
yTrainingdata       = read.table('./train/y_train.txt',header=FALSE);

# Assigin column names
colnames(Type)  = c('AId','ActivityType');
colnames(subjectTrainingdata)  = "SId";
nrow(features)
ncol(xTrainingdata)
#Assign each of the feature to cols of Xtrain
colnames(xTrainingdata)        = features[,2]; 
colnames(yTrainingdata)        = "AId";

# Merge data to create training data
training = cbind(yTrainingdata,subjectTrainingdata,xTrainingdata);



subjectTesting = read.table('./test/subject_test.txt',header=FALSE); 
xTesting       = read.table('./test/x_test.txt',header=FALSE); 
yTesting       = read.table('./test/y_test.txt',header=FALSE); 

# Assigin column names
colnames(subjectTesting) = "SId";
nrow(features)
ncol(xTesting)
#Assign each of the feature to cols of Xtrain
colnames(xTesting)       = features[,2]; 
colnames(yTesting)       = "AId";


# Merge data to create Test data
testing = cbind(yTesting,subjectTesting,xTesting)
names(training)

# Combine training and test data to create a final data set
Data = rbind(training,testData)
cnames  = colnames(finalData); 
#2) Extracts only the measurements on the mean and standard deviation for each measurement.
flag = (grepl("AId",cnames) | grepl("SId",cnames) | grepl("-mean..",cnames) | grepl("-std..",cnames));

#NOW data contain X Y Z mean too, we need to remove that

#flag = (grepl("AId",colNames) | grepl("SId",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# 
Data1 = Data[flag==TRUE];
cnames  = colnames(Data1);
flagxyz=(grepl("-X",cnames) | grepl("-Y",cnames)|grepl("-Z",cnames))
Data2 = Data1[flagxyz==FALSE];

# 3 Uses descriptive activity names to name the activities in the data set
Data3 = merge(Data2,Type,by='AId',all.x=TRUE);
#4 Appropriately labels the data set with descriptive variable names.
#couldnt understand
#5
cleandata<-aggregate(Data2, by=list(SId = Data2$SId, AId = Data2$AId), FUN=mean, na.rm=TRUE)
#Remove the SId and AId columns from this
cleandata <- subset(cleandata, select = -c(1,2,4) )
cleandata = merge(cleandata,Type,by='AId',all.x=TRUE)
cleandata <- subset(cleandata, select = -c(1) )
write.table(cleandata, './cleandata.txt',row.names=TRUE,sep='\t');


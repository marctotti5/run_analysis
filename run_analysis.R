# run_analysis
Final project of Cleaning and Tyding Data in R from Coursera
getwd()
setwd("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset")


#1. Merge the datasets
rf("")
features <- read.table("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset/features.txt", sep="", col.names=c("n", "functions"))
activities <- read.table("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset/activity_labels.txt", sep="", col.names = c("code", "activity"))
subject_test <- read.table("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset/test/subject_test.txt", sep="", col.names = "subject")
subject_train <- read.table("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset/train/subject_train.txt", sep="", col.names = "subject")

xtest <- read.table("././test/X_test.txt", sep="", col.names=features$functions)
xtrain <- read.table("././train/X_train.txt", sep="", col.names=features$functions)
xmerged <- rbind(xtest, xtrain)
View(xmerged)

library(tidyverse)

ytest <- read.table("././test/y_test.txt", sep="")
ytrain <- read.table("././train/y_train.txt", sep="")
ymerged <- rbind(ytest, ytrain)
colnames(ymerged) <- "code"
ymerged <- merge(ymerged, activities, by="code")
ymerged %>% group_by(activity) %>% summarise(count=n())

subjectmerged <- rbind(subject_test, subject_train)

nrow(xymerged)
xymerged <- cbind(xmerged, ymerged, subjectmerged)
nrow(xymerged)
colnames(xymerged)

xymerged2 <- xymerged[, c(562, 563, 564, 1:561)]
xymerged2$subject

View(xymerged2)

# 2. Find out the mean and sd for each variable
a <- function(x){
        output <- data.frame()
        means <- numeric()
        deviations <- numeric()
        for(i in seq_along(x)){
                names <- colnames(x)
                means <- c(means, mean(x[,i], na.rm=TRUE))
                deviations <- c(deviations, sd(x[,i], na.rm=TRUE))
        }
        output <- cbind(names, means, deviations)
        output
}

t <- a(xymerged2)

#4. Find out average for each variable for each activity and each subject
xymerged_grouped3 <- xymerged2 %>% group_by(activity, subject) %>% summarise_all("mean")



getwd()
setwd("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset")


#1. Merge the datasets
features <- read.table("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset/features.txt", sep="", col.names=c("n", "functions"))
activities <- read.table("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset/activity_labels.txt", sep="", col.names = c("code", "activity"))
subject_test <- read.table("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset/test/subject_test.txt", sep="", col.names = "subject")
subject_train <- read.table("C:/Users/marct/OneDrive - Tecnocampus Mataro-Maresme/Documentos/CURSOS/R PATH COURSERA/Cleaning & Tidying Data in R/Week 4/UCI HAR Dataset/train/subject_train.txt", sep="", col.names = "subject")

xtest <- read.table("././test/X_test.txt", sep="", col.names=features$functions)
xtrain <- read.table("././train/X_train.txt", sep="", col.names=features$functions)
xmerged <- rbind(xtest, xtrain)

ytest <- read.table("././test/y_test.txt", sep="")
ytrain <- read.table("././train/y_train.txt", sep="")
ymerged <- rbind(ytest, ytrain)

colnames(ymerged) <- "code"
ymerged <- merge(ymerged, activities, by="code")

subjectmerged <- rbind(subject_test, subject_train)
xymerged <- cbind(xmerged, ymerged, subjectmerged)

xymerged2 <- xymerged[, c(562, 563, 564, 1:561)]

#2. Find out the mean and sd for each variable
a <- function(x){
        output <- data.frame()
        means <- numeric()
        sd <- numeric()
        names <- colnames(x)
        for(i in seq_along(x)){
                means <- c(means, mean(x[,i], na.rm=TRUE))
                sd <- c(sd, sd(x[,i], na.rm=TRUE))
        }
        output <- cbind(names, means, sd)
        as.data.frame(output[-1:-3,])
}

t <- a(xymerged2)
t
#3. Find out average for each variable for each activity and each subject
xymerged_grouped3 <- xymerged2 %>% group_by(activity, subject) %>% summarise_all("mean") %>% arrange(subject)
xymerged_grouped3

write.table(xymerged_grouped3, row.name=F, file="runanalysis.txt")


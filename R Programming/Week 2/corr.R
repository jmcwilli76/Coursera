source('D:/Temp/Coursera/R Programing/Week 2 Programming Data/complete.R')
corr <- function(directory, threshold = 0) {
  numComplete <- subset(complete(directory),nobs >= threshold)
  #  Get the files and data
  fileList <- list.files(path= directory, pattern = "*.csv")
  for(file in fileList){
    filePathName = paste(directory, file, sep = "/")
    if (exists("myDataFrame")){
      myDataFrame <- rbind(myDataFrame,subset(read.csv(filePathName, header = TRUE, sep = ","), ID %in% as.vector(numComplete$id)))
      #myDataFrame <- rbind(myDataFrame,read.csv(filePathName, header = TRUE, sep = ","))
    } else {
      myDataFrame <- subset(read.csv(filePathName, header = TRUE, sep = ","), ID %in% as.vector(numComplete$id))
      #myDataFrame <- read.csv(filePathName, header = TRUE, sep = ",")
    }
  }
  my.df <- subset(myDataFrame,!is.na(sulfate) & !is.na(nitrate),select = c(sulfate, nitrate, ID))
  #my.df <- myDataFrame
  NumVectReturn <- as.vector(numeric(0))
  for(n.ID in numComplete$id){
    my.subcor <- cor(subset(my.df,my.df$ID == n.ID, select = c(sulfate, nitrate)))
    #print(my.subcor[1,2])
    NumVectReturn <- append(NumVectReturn,my.subcor[1,2])
  }
  #my.df <- subset(myDataFrame,!is.na(sulfate) & !is.na(nitrate) & ID %in% as.vector(numComplete$Group.1))
  #my.df
  #cor(my.df, use = "complete.obs")
  NumVectReturn
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
}
complete <- function(directory, id = 1:332) {
  fileList <- list.files(path= directory, pattern = "*.csv")
  for(file in fileList){
    filePathName = paste(directory, file, sep = "/")
    if (exists("myDataFrame")){
      myDataFrame <- rbind(myDataFrame,subset(read.csv(filePathName, header = TRUE, sep = ","), ID %in% id))
      #myDataFrame <- rbind(myDataFrame,read.csv(filePathName, header = TRUE, sep = ","))
    } else {
      #myDataFrame <- subset(read.csv(filePathName, header = TRUE, sep = ","), ID %in% id)
      myDataFrame <- read.csv(filePathName, header = TRUE, sep = ",")
    }
  }
  dpReturn <- data.frame(id = numeric(0), nobs = numeric(0))
  for(i in id){
    my.TargetRows <- subset(myDataFrame,ID == i)
    my.SubRows <- subset(my.TargetRows,!is.na(sulfate) & !is.na(nitrate))
    my.Return <- c(i,nrow(my.SubRows))
    
    dpReturn <- rbind(dpReturn,my.Return)
  }
  #dataPollutant <- subset(myDataFrame,(ID %in% id & !is.na(sulfate) & !is.na(nitrate)))
  #dpReturn <- aggregate.data.frame(dataPollutant$ID,by = list(dataPollutant$ID), FUN = length)
  colnames(dpReturn) <- c("id","nobs")
  dpReturn
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
}
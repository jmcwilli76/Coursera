pollutantmean <- function(directory, pollutant, id = 1:332) {
  #print (directory)
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
  
  dataPollutant <- subset(myDataFrame,ID %in% id, select = pollutant)

  mean(dataPollutant[[1]], na.rm = TRUE)
}
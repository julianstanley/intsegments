#' Core: Creates a filtered consensus segments file based on a traditional segments file
#' @import utils 
#' @import CNTools 
#' @param sourceData (dataframe or matrix) the original segments table
#' @param namesArray (array) contains 5 elements, in order:
#'  namesArray[1]: The column name identifying the segment's chromosome
#'  namesArray[2]: The column name identifying the genomic start location
#'  namesArray[3]: The column name identifying the genomic stop location
#'  namesArray[4]: The column name identifying the mean log2 ratio of the segment
#'  namesArray[5]: The column name identifying the sample that the segment represents
#' @param filterThreshold (float) between 0 and 1.0, the threshold for filtering based on mean absolute deviation
#' @return A filtered dataframe of consensus segments
#' @examples 
#' # Read the raw segment data
#' data(segData)
#' segData <- subset(segData, segData$Type == "TotalCN")
#' reduceSegment(segData, 
#' c("Chromosome", "StartPosition", "StopPosition", 
#' "Median.Log2.Ratio", "FileName"))
#' @export
 

reduceSegment <- function(sourceData, namesArray, filterThreshold) {
  
  cnseg <- CNSeg(segList = sourceData, 
                 chromosome = namesArray[[1]], start = namesArray[[2]], 
                 stop = namesArray[[3]], segMean = namesArray[[4]], 
                 id = namesArray[[5]])
  
  rdseg <- getRS(cnseg, by = "region", imput = FALSE, XY = FALSE, what = "mean")
  
  filteredrs <- madFilter(rdseg, filterThreshold)
  
  return(attributes(filteredrs)[1])
}

#' segment(sourceData, namesArray, filterThreshold) creates segments with CNSeg from raw data
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
#' "Median.Log2.Ratio", "FileName"), 0.8)
#' @export
 

segment <- function(sourceData, namesArray, filterThreshold) {
  chromosome = namesArray[1]
  start = namesArray[2]
  stop = namesArray[3]
  segMean = namesArray[4]
  id = namesArray[5]
  
  cnseg <- CNSeg(segList = sourceData, 
                 chromosome = chromosome, end = stop, 
                 start = start, segMean = segMean, 
                 id = id)
  
  rdseg <- getRS(cnseg, by = "region", imput = FALSE, XY = FALSE, what = "mean")
  
  filteredrs <- madFilter(rdseg, filterThreshold)
  
  return(attributes(filteredrs)[1])
}

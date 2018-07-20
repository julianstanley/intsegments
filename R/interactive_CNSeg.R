#' Imports the inital variables from a segments file
#' @return chromosome The "chromosome" variable is created
#' @export

import_segments <- function() {
  path <- readline(prompt = paste("Enter full tab-delineated file path",
                                  "(e.g. C:/mysegments.csv): "))
  
  segData <- read.csv(path, 
                      stringsAsFactors = FALSE,
                      sep = "\t")
  
  print(paste("Your column names are: ", colnames(segData)))
  
  chromosome <- readline(prompt = paste("Enter the column name", 
                                                 "containing chromosome labels: "))
  if(is.null(segData[[chromosome]])) {
    warning("Warning: No chromosome data")
  }
  
  start <- readline(prompt = "Enter the column name containing the genomic position that starts each segment: ")
  
  if (is.null(segData[[start]])) {
    warning("Warning: No start position data")
  }

  end <- readline(prompt = "Enter the column name containing the genomic position that ends each segment: ")
  
  if (is.null(segData[[end]])) {
    warning("Warning: No end position data")
  }
  
  segMean <- readline(prompt = "Enter the column name containing the mean log2 ratio of the segment: ")
  
  if (is.null(segData[[segMean]])) {
    warning("Warning: No segment mean data")
  }
  
  id <- readline(prompt = "Enter the column name containing the sample ID from which each segment was taken: ")
  
  if (is.null(segData[[id]])) {
    warning("Warning: No id data")
  }
  
  threshold <- readline(prompt = "Enter the mean absolute deviation threshold value between 0 and 1 (enter 1 for no filtering): ")
  
  return(CNSeg(segData, c(chromosome, start, end, segMean, id), threshold))
}
#' Imports the inital variables from a segments file
#' @param interactive_input_path A full file path to the tab-delineated imput file
#' @param more Will add more
#' @return chromosome The "chromosome" variable is created
#' @examples import_segments()
#' @export

import_segments <- function() {

path <- readline(prompt = paste("Enter full tab-delineated file path",
                                "(e.g. C:/mysegments.csv): "))

segData <- read.csv(path, 
                    stringsAsFactors = FALSE, sep = "\t")

print(paste("Your column names are: ", colnames(segData)))


chromosome <- segData[[readline(prompt = paste("Enter the column name", 
                                               "containing chromosome labels: "))]]

if(is.null(chromosome)) {
  warning("Warning: No chromosome data")
}

start <- segData[[readline(prompt = "Enter the column name containing the genomic position that starts each segment: ")]]

if (is.null(start)) {
  warning("Warning: No start position data")
}

end <- readline(prompt = "Enter the column name containing the genomic position that ends each segment: ")
segMean <- readline(prompt = "Enter the column name containing the mean log2 ratio of the segment")
id <- readline(prompt = "Enter the column name containing the sample ID from which each segment was taken")


}
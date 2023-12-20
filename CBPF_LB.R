library(openair)

# Load the data
mydata <- read.csv(file.choose(), header = TRUE)

# Get a list of all pollutant columns that start with "F" followed by one or more digits
pollutants <- names(mydata)[grep("^F\\d+$", names(mydata))]

# Specify the base folder to save the plots
output_folder_base <- "C:/Users/LB945465/Desktop/PMF Cannister sites"

# Define a vector of percentiles
percentiles <- c(50, 75, 90)

# Loop through each percentile and then through each pollutant to save the plots
for (perc in percentiles) {
  
  # Create a specific output folder for the current percentile
  output_folder <- paste0(output_folder_base, "/", perc, "th_percentile/")
  
  if(!dir.exists(output_folder)){
    dir.create(output_folder, recursive = TRUE)
  }
  
  for (pollutant in pollutants) {
    
    # Define the file name
    file_name <- paste0(output_folder, pollutant, "_polarPlot.png")
    
    # Create the plot
    png(filename = file_name)
    polarPlot(mydata, 
              pollutant = pollutant, 
              col = "jet", 
              key.position = "bottom",
              key.footer = NULL, 
              statistic = "cpf", 
              percentile = perc,
              force.positive = FALSE)
    Sys.sleep(2) # Adding a delay to ensure plot has time to be created
    dev.off()
  }
}

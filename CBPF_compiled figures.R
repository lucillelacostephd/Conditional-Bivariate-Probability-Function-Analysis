library(openair)
library(grid)
library(png)
library(gridExtra)

# Load the data
mydata <- read.csv(file.choose(), header = TRUE)

# Get a list of all pollutant columns that start with "F" followed by one or more digits
pollutants <- names(mydata)[grep("^F\\d+$", names(mydata))]

# Determine the number of plots to create (maximum 3 x 4)
num_plots <- min(length(pollutants), 12)

# Specify the base folder to save the plots
output_folder_base <- "C:/Users/LB945465/Desktop/PMF_Cannister_sites/"

# Create a list to store individual plots
plot_list <- list()

# Set the percentile to 75 for all plots
percentile_value <- 75

for (i in 1:num_plots) {
  # Create a specific output folder
  output_folder <- paste0(output_folder_base, "/75th_percentile/")
  
  if (!dir.exists(output_folder)) {
    dir.create(output_folder, recursive = TRUE)
  }
  
  # Define the file name
  file_name <- paste0(output_folder, pollutants[i], "_polarPlot.png")
  
  # Create the plot with the specified percentile
  polarPlot(mydata, 
            pollutant = pollutants[i], 
            col = "jet", 
            key.position = "bottom",
            key.footer = NULL, 
            statistic = "cpf", 
            percentile = percentile_value,
            force.positive = FALSE)
  
  # Save the plot as a PNG file with transparent background and 300 DPI
  dev.copy(png, filename = file_name, bg = "transparent")
  dev.off()
  
  # Add the plot to the list
  img <- readPNG(file_name)
  raster_grob <- rasterGrob(img)
  plot_list[[i]] <- raster_grob
}

# Combine all plots into a single figure with adjusted aesthetics
combined_figure <- do.call(grid.arrange, c(plot_list, ncol = 3))

# Set the overall figure size and reduce spacing between plots
png(filename = combined_file_name, width = 1600, height = 1200, bg = "transparent")
grid.draw(combined_figure)
dev.off()

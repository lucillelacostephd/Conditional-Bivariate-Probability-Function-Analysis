# Conditional Bivariate Probability Function

This repository contains two scripts:

R Script: Generates polar plots for multiple pollutants based on a percentile approach using the openair library.

Python Script: Merges raw data files into a unified format for further analysis.

R Script: Polar Plot Generator

# Description

This R script reads in air quality data, processes specified pollutant columns, and creates polar plots for different percentiles (50th, 75th, and 90th). The generated plots are saved to a user-defined directory, organized by percentile.

# Prerequisites

R installed on your system.

openair library installed in R.

# How to Use

Load the script in R.

Select the data file when prompted (file.choose() function).

Modify the output_folder_base variable to specify where plots should be saved.

Run the script.

Script Highlights

Identifies pollutant columns dynamically using regular expressions (columns starting with F followed by digits).

Creates output directories for each percentile (50th, 75th, 90th).

Generates polar plots using the polarPlot() function.

# Output

Polar plots saved as PNG files, organized into percentile-specific folders within the specified base directory.

Python Script: Data Merger

# Description

This Python script merges multiple raw data files into a single cohesive dataset. It ensures proper alignment of columns and formats the output for further analysis.

# Prerequisites

Python 3.7 or later.

Libraries: pandas.

# How to Use

Place the raw data files in a folder.

Modify the script to point to the folder containing your raw files.

Run the script.

The merged data will be saved to the specified output directory.

# Script Highlights

Handles multiple files dynamically.

Aligns and normalizes columns for consistency.

Outputs a clean, formatted dataset for further use.

# Output

A merged CSV file containing data from all input files.

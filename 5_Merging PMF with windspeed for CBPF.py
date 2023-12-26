# -*- coding: utf-8 -*-
"""
Created on Tue Aug 22 16:12:25 2023
This script is to merge wind speed and direction dataset with the PMF source
contribution dataset. Use absolute concentrations for source contributions, 
this is the Contributions_conc worksheet of the Base results excel file.
@author: lb945465
"""

import pandas as pd

# Load the dataframe with columns ws_ms and wd
df1 = pd.read_csv(r'C:\Users\LB945465\OneDrive - University at Albany - SUNY\State University of New York\NYSERDA VOC project\Data\Wind data\Requested_metdata_for_LA.GUARDIA.AIRPORT.csv', usecols=["date_LT", "ws_ms", "wd"])  
df1=df1.set_index("date_LT")
df1=df1.rename_axis("Date")

# Load the excel worksheet as a dataframe
excel_file = pd.ExcelFile(r"C:\mydata\Optimal solution\ICDN\Base_Results.xlsx")  # Change the file name and path accordingly
df2 = excel_file.parse("Contributions_conc")
df2=df2.set_index("Date")

# Divide each value in df2 by the sum of the row
df2_normalized = df2.div(df2.sum(axis=1), axis=0)

# Rename specific columns in df2_normalized
df2_normalized.rename(columns={'Factor 1': 'F1', 
                               'Factor 2': 'F2',
                               'Factor 3': 'F3',
                               'Factor 4': 'F4',
                               'Factor 5': 'F5',
                               'Factor 6': 'F6',
                               'Factor 7': 'F7',
                               }, inplace=True)

# Merge the dataframes using the shared index "Date"
merged_df = df1.merge(df2_normalized, left_index=True, right_index=True)

# Clean the merged_df by dropping rows with ws_ms less than 1 or equal to 0
merged_df = merged_df[(merged_df["ws_ms"] > 0) & (merged_df["ws_ms"] >= 1)]

# Clean the merged_df by dropping rows with NaN in ws_ms or wd
merged_df = merged_df.dropna(subset=["ws_ms", "wd"])

# Rename specific columns in merged_df
merged_df.rename(columns={'ws_ms': 'ws', 
                               }, inplace=True)

# Display the merged dataframe
print(merged_df)

# Save the cleaned and merged dataframe to an Excel file
output_file = "CBPF_merged.csv"
merged_df.to_csv(output_file, index=True)

print("Cleaned and merged dataframe saved to", output_file)


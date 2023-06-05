library(dplyr)
library(stringr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(reshape2)
library(plotly)
library(maps)
library(mapdata)

source("final_project.r")
df <- read.csv("final_df.csv")

barplot_crime <- function(df, data, crime) {
  col_num <- which(colnames(df) == crime)
  
  if(data == 0) {
    new_col_num <- col_num - 7
    crime <- names(df)[new_col_num]
    data_word <- "States"
  } else {
    data_word <- "Colleges"
  }
  
  crime_df <- subset(df, select = crime)
  title <- paste0(crime, " Crime Rates in ", data_word, " across the US")
  
  p <- ggplot(crime_df, aes(x = abb, y = get(crime))) +
    geom_col(fill = "darkgreen") +
    labs(x = "State",
         y = "Crime Count",
         title = title)
  
  return(p)
}

piechart_crime <- function(df, selected_crime) {
  filtered_df <- df[, c("State", selected_crime)]
  
  filtered_df <- as.data.frame(filtered_df)
  
  pie_chart <- plot_ly(filtered_df, labels = ~State, values = ~get(selected_crime), type = "pie")
  pie_chart <- layout(pie_chart, title = "Crime Distribution by State")
  
  return(pie_chart)
}

plot_map <- function(df, data_map, map_crime) {
  if (data_map == 0) {
    filtered_df <- df
  } else if (data_map == 1) {
    filtered_df <- subset(df, Region == "West")
  } else if (data_map == 2) {
    filtered_df <- subset(df, State == "WASHINGTON")
  }
  
  us_map <- map_data("state")
  
  filtered_df$region <- tolower(filtered_df$State)
  
  merged_data <- left_join(us_map, filtered_df, by = "region")
  
  filt_merged_data <- merged_data[complete.cases(merged_data$long, merged_data$lat) & !is.na(merged_data$State), ]
  
  title <- paste0(map_crime, " Crime Rate Map Visualization")
  
  p <- ggplot(filt_merged_data, aes(x = long, y = lat, group = region)) +
    geom_polygon(aes(fill = .data[[map_crime]]), color = "black", size = 0.1) +
    scale_fill_gradient(low = "#90EE90", high = "#013220") +
    coord_map() +
    labs(x = "Longitude", y = "Latitude", fill = map_crime, title = title)
  
  
  return(p)
}
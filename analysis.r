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
    geom_col(fill = "steelblue") +
    labs(x = "State",
         y = "Crime Count",
         title = title)
  
  return(p)
}

piechart_crime <- function(df, selected_crime) {
  filtered_df <- df[, c("State", selected_crime)]
  
  filtered_df <- as.data.frame(filtered_df)
  
  pie_chart <- plot_ly(filtered_df, labels = ~State, values = ~get(selected_crime), type = "pie")
  
  return(pie_chart)
}

plot_map <- function(df, data_map, map_crime) {
  # Filter the dataframe based on user inputs
  if (data_map == 0) {
    filtered_df <- df
  } else if (data_map == 1) {
    filtered_df <- subset(df, Region == "West")
  } else if (data_map == 2) {
    filtered_df <- subset(df, State == "Washington")
  }
  
  us_map <- map_data("state")

  us_map$region <- tolower(us_map$region)

  filtered_df$State <- tolower(filtered_df$State)
  
  merged_data <- merge(us_map, filtered_df, by.x = "region", by.y = "State", all.x = TRUE)
  
  p <- ggplot(merged_data, aes(x = long, y = lat, group = group, fill = get(map_crime))) +
    geom_polygon(color = "black") +
    scale_fill_gradient(low = "lightblue", high = "darkred") +
    coord_map() +
    labs(fill = map_crime)
  
  return(p)
}

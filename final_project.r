library(dplyr)
library(stringr)
library(testthat)
library("readxl")
library(writexl)

# Loads in the datasets
df_1 <- read.csv("crime_in_us.csv")
df_2 <- read_excel("oncampuscrime161718.xls")

#Filtering df_2

#df_2 <- na.omit(df_2)
df_2 <- df_2[complete.cases(df_2$Total), ]
df_2 <- df_2[complete.cases(df_2$State), ]

df_2 <- df_2[, -c(1, 4, 5, 7, 8, 10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 46, 47, 48)]

abb <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN",
         "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV",
         "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN",
         "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY")
college_df <- data.frame(abb)

fill_method <- function(col) {
  state_vec <- numeric(length(abb))
  for (i in seq_along(abb)) {
    filt_state <- filter(df_2, State == abb[i])
    state_vec[i] <- sum(filt_state[[col]])
  }

  return(state_vec)
}
college_df$population <- fill_method("Total")
college_df$Murder <- fill_method("MURD18")
college_df$Rape <- fill_method("RAPE18")
college_df$Robbery <- fill_method("ROBBE18")
college_df$Aggravated.Assault <- fill_method("AGG_A18")
college_df$Burglary <- fill_method("BURGLA18")
college_df$Motor.Vehicle.Theft <- fill_method("VEHIC18")


#Filtering df_1
df_1 <- filter(df_1, X == "State Total")
state_name <- str_trim(str_extract(df_1$Table.5, "[^,]*$"))

state_name <- tolower(state_name)
state_abb <- state.abb[match(state_name, tolower(state.name))]
df_1$state_code <- state_abb

# Removing unnecessary columns
df_1 <- select(df_1, -X, -X.1, -X.3, -X.8, -X.10, -X.12, -X.13)

#Renaming column names
colnames(df_1) <- c("State", "US.Population", "US.Murder.and.Manslaughter", "US.Rape", "US.Robbery", "US.Aggravated.Assault", "US.Burglary", "US.Motor.Vehicle.Theft", "abb")


# Merging the datasets
df <- merge(df_1, college_df, by = "abb")

# New Numerical Variable
college_rapes <- df$Rape
us_rapes <- as.numeric(gsub(",", "", df$US.Rape))
perc_rapes <- numeric(length(college_rapes))

for(i in seq_along(perc_rapes)) {
  num1 <- college_rapes[i]
  num2 <- us_rapes[i]
  perc <- (num1 / num2) *100
  perc_rapes[i] <- perc
}
  
df$Percent.College.Rapes <- perc_rapes

# New Categorical Variable
region_vec <- c("Northeast", "Midwest", "South", "West")
northeast_states <- c("CT", "ME", "MA", "NH", "RI", "VT", "NJ", "NY", "PA")
midwest_states <- c("IL", "IN", "MI", "OH", "WI", "IA", "KS", "MN", "MO", "NE", "ND", "SD")
south_states <- c("DE", "FL", "GA", "MD", "NC", "SC", "VA", "DC", "WV", "AL", "KY", "MS", "TN", "AR", "LA", "OK", "TX")
west_states <- c("AZ", "CO", "ID", "MT", "NV", "NM", "UT", "WY", "AK", "CA", "HI", "OR", "WA")

for (i in seq_along(df$abb)) {
  if (df$abb[i] %in% northeast_states) {
    df$Region[i] <- region_vec[1]
  } else if (df$abb[i] %in% midwest_states) {
    df$Region[i] <- region_vec[2]
  } else if (df$abb[i] %in% south_states) {
    df$Region[i] <- region_vec[3]
  } else if (df$abb[i] %in% west_states) {
    df$Region[i] <- region_vec[4]
  }
}

# New Categorical Variable
safety_categories <- c("High", "Medium", "Low")

df$College.Rape.Safety.Level <- ifelse(df$Percent.College.Rapes > 8, safety_categories[3],
                          ifelse(df$Percent.College.Rapes < 3, safety_categories[1],
                                 safety_categories[2]))


#Summarize DF

# Define the column names for the summary data frame
summary_cols <- c('sum', 'mean', 'min', 'max')

# Create an empty data frame with the summary columns
summary_df <- data.frame(matrix(ncol = length(summary_cols), nrow = 0))
colnames(summary_df) <- summary_cols

# Iterate over each column of the original data frame
for (col in colnames(df)[3:17]) {
  
  if (class(df[[col]]) != "numeric") {
    df[[col]] <- as.numeric(gsub(",", "", df[[col]]))
  }
  # Calculate summary statistics for the column
  sum_val <- sum(df[[col]])
  mean_val <- mean(df[[col]])
  min_val <- min(df[[col]])
  max_val <- max(df[[col]])
  
  # Append the summary statistics to the data frame
  summary_df <- rbind(summary_df, c(sum_val, mean_val, min_val, max_val))
}

colnames(summary_df) <- summary_cols

# Assign column names to the summary data frame
rownames(summary_df) <- colnames(df)[3:17]

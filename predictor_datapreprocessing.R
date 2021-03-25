# load library
library(plyr)
library(rvest)
library(tidyverse)
library(readr)
library(ggplot2)
library (splines)
library(stringr)

#read all .csv documents
setwd("D:/dataexpo/data/acs_2019/county_1yr/demographic")
temp = list.files(pattern="*.csv")

for (i in 1:length(temp)) {
  df <- read.csv(temp[i])
  names(df)[1] <- "Label"
  # first remember the names
  coln <- df$Label
  # transpose all but the first column (name)
  df <- as.data.frame(t(df[,-1]))
  colnames(df) <- coln
  assign(temp[i], df[c(TRUE,FALSE,FALSE,FALSE),]) 
}


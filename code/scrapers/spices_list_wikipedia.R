#import libraries
library(rvest)
library(stringr)
library(tibble)
library(dplyr)
library(readr)

#url of wikipedia page of spices
url <- "https://en.wikipedia.org/wiki/Category:Spices"

#get spices from wikipedia page
spices <- read_html(url) %>%
  html_nodes("#mw-pages .mw-category-group+ .mw-category-group a") %>%
  html_text(trim = TRUE)

#clean up spices (convert to lower case) and convert to df
spices_cleaned <- spices %>%
  tolower() %>%
  as_tibble() %>%
  rename(spices = value)

#write data to csv
write_csv(spices_cleaned, here::here("data/spices_dictionary.csv"))

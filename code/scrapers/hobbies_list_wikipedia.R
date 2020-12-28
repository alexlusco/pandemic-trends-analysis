#import libraries
library(rvest)
library(stringr)
library(tibble)
library(dplyr)
library(readr)

#url of wikipedia page of hobbies
url <- "https://en.wikipedia.org/wiki/List_of_hobbies"

#get hobbies from wikipedia page
hobbies <- read_html(url) %>%
  html_nodes("ul:nth-child(13) li , .div-col li") %>%
  html_text(trim = TRUE)

#clean up hobbies (remove footenotes, convert to lower case) and convert to df
hobbies_cleaned <- hobbies %>%
  str_remove("\\[[0-9]+\\]") %>%
  tolower() %>%
  as_tibble(hobbies_cleaned) %>%
  rename(hobbies = value)

#write data to csv
write_csv(hobbies_cleaned, here::here("data/hobbies_dictionary.csv"))

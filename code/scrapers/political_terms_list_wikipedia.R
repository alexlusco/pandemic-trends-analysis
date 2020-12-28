#import libraries
library(rvest)
library(stringr)
library(tibble)
library(dplyr)
library(readr)

#url of wikipedia pages of political terminology
urls <- c("https://en.wikipedia.org/w/index.php?title=Category:Political_terminology&pageuntil=Merit+System%0AMerit+system#mw-pages",
          "https://en.wikipedia.org/w/index.php?title=Category:Political_terminology&pagefrom=Merit+System%0AMerit+system#mw-pages",
          "https://en.wikipedia.org/w/index.php?title=Category:Political_terminology&pagefrom=Victimless+crime#mw-pages")

#get political terms from pages
terms <- list()

for (u in urls){
  
  page <- read_html(u)
  
  nodes <- html_nodes(page, "#mw-pages .mw-category-group a")
  
  terms[[u]] <- html_text(nodes, trim = TRUE)
}

#clean and convert to df
terms_cleaned <- unlist(terms)

terms_cleaned <- terms_cleaned %>%
  tolower() %>%
  as_tibble() %>%
  rename(political_terminology = value)

#write data to csv
write_csv(terms_cleaned, here::here("data/political_terms_dictionary.csv"))

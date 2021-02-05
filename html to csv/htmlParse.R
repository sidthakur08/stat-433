library(rvest)
library(dplyr)
library(tidyverse)

file <- read_html("https://guide.wisc.edu/faculty/")

uls <- file %>% html_nodes(css=".uw-people")
for (ul in uls){
  text <- ul %>% html_nodes("li p")
  break
}

file %>% html_nodes("li p")

library(rvest)
library(dplyr)

file <- read_html("prof.html")
file %>% xml_structure()
file %>% html_nodes("div")
file %>% html_nodes("tr")
file %>% html_nodes("td")
file %>% html_nodes("span")

selector = '//*[(@id = "textcontainer")] | //*[contains(concat( " ", @class, " " ), concat( " ", "uw-people", " " ))]'
file %>% html_nodes(xpath = selector)

span <- file %>% html_nodes("span")

file %>% html_nodes("td") %>% html_nodes("span")

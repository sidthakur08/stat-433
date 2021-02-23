library(nycflights13)
library(tidyverse)
# nycflights13::airports
colnames(flights)
colnames(weather)
flights$time_hour
weather$time_hour

data <- flights %>% left_join(weather,by="time_hour")
colnames(data)

'
1. Make a table that describes each plane. It should have a column for tailnum, another column for average arrival delay, and another for the year the plane was manufactured.
2. Make a table where each row is a day of the year. The first column is the date. The 2:4 columns give the number of (scheduled) departures from EWR, LGA, and JFK.
3. Make a table where each row is a day of the year. Each destination airport is a column. The elements (day x destination) give the number of flights to that destination. What should NA’s be?
4. Of the planes built before 1980, what is the average flight distance?
5. Compute the average arrival delay for each destination airport. Plot this against the airports altitude.

'

library(nycflights13)
library(tidyverse)

flights
planes

1.
################################################
flights %>% filter(tailnum=="N10156")

data_1 <- planes %>% 
  left_join(flights,by="tailnum") %>%
  group_by(tailnum) %>%
  summarise(avg_arr_delay = mean(arr_delay)) %>%
  left_join(planes,by="tailnum") %>%
  select(c("tailnum","avg_arr_delay","year"))
data_1
################################################

2.
################################################
data_2 <- flights %>% 
  mutate(date=as.Date(with(flights, paste(year, month, day,sep="-")), "%Y-%m-%d")) %>%
  group_by(date,origin) %>%
  summarise(count=n()) %>%
  pivot_wider(names_from = origin,values_from = count)
data_2

3.
################################################
data_3 <- flights %>% 
  mutate(date=as.Date(with(flights, paste(year, month, day,sep="-")), "%Y-%m-%d")) %>%
  group_by(date,dest) %>%
  summarise(count=n()) %>%
  pivot_wider(names_from = dest, values_from = count)

data_3[is.na(data_3)] <- 0
data_3
################################################

4.
################################################
data_4 <- planes %>% 
  filter(year<1980) %>%
  left_join(flights,by="tailnum") %>%
  group_by(tailnum) %>%
  summarise(mean_distance = mean(distance))
data_4
################################################

5.
################################################
data_5 <- flights %>% 
  group_by(dest) %>%
  summarise(mean_arr_delay = mean(arr_delay)) %>%
  left_join(airports, by = c("dest"="faa")) %>%
  na.omit()
data_5

ggplot(data_5,aes(x=alt,y=mean_arr_delay)) + geom_line() +ggtitle("Mean Arrival Delay vs Altitude of the airports")
################################################

################################################
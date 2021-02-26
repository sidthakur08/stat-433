library(nycflights13)
library(tidyverse)
weather
airports
airlines
planes

flights
colnames(flights)
colSums(is.na(flights))

# To check at what time should one book tickets in order to get minimal delay
time_departure_delay <- flights %>%
  drop_na() %>%
  group_by(hour) %>%
  summarise(mean_dep_delay = mean(dep_delay,na.rm = TRUE))

ggplot(time_departure_delay,aes(y=mean_dep_delay,x=hour)) +
  geom_line() +
  scale_x_continuous(labels=as.character(time_departure_delay$hour),breaks=time_departure_delay$hour) +
  labs(x = "Time of Flight",
       y = "Departure Delay of Flight",
       title = "Mean Departure Delay of Flights vs Time of Flight",
       caption = "Data Source: nycflights13")

# Delay due to temperature at the airport
colnames(weather)
colSums(is.na(weather))

temp_departure_delay <- flights %>%
  left_join(weather,by=c("origin","time_hour")) %>%
  group_by(temp) %>%
  summarise(mean_dep_delay = mean(dep_delay,na.rm = TRUE)) %>%
  drop_na()

ggplot(temp_departure_delay, aes(y=mean_dep_delay,x=temp)) +
  geom_line() +
  geom_smooth(method = 'loess') + 
  labs(x = "Temperature",
       y = "Departure Delay of Flight",
       title = "Mean Departure Delay of Flights vs Temperature at the Airport",
       caption = "Data Source: nycflights13")


# 
airline_departure_delay <- flights %>% 
  left_join(airlines,by="carrier") %>%
  group_by(origin,name) %>%
  summarise(mean_dep_delay = mean(dep_delay,na.rm = TRUE))

ggplot(airline_departure_delay) +
  geom_point(mapping = aes(x = name, y=mean_dep_delay, color=origin)) +
  theme(axis.text.x = element_text(angle = 90))

library(tidyverse)
table1
table2
table3
table4a
table4b

table4c <-
  tibble(
    country = table4a$country,
    `1999` = table4a[["1999"]] / table4b[["1999"]] * 10000,
    `2000` = table4a[["2000"]] / table4b[["2000"]] * 10000
  )
table4c

#pivot_longer
table4a %>% pivot_longer(c(`1999`,`2000`), names_to = "year", values_to = "cases")
tidy4a <- table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
tidy4b <- table4b %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")
left_join(tidy4a, tidy4b)

# pivot_wider
table2
table2 %>% pivot_wider(names_from=type,values_from = count)


# exercise
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks

stocks %>%
  pivot_wider(names_from = year,values_from=return) %>%
  pivot_longer(c(`2015`,`2016`),names_to="year",values_to = "return",names_ptypes = list(year = double()))

# column type info is lost when we convert it from wide to long therefore the names_ptypes gives the col info

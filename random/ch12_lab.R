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


########################### Exercise #################################
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


people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
people
people %>% 
  pivot_wider(names_from = names, values_from = values)

people %>%
  group_by(name,names) %>%
  mutate('obs' = row_number()) %>%
  pivot_wider(names_from = names, values_from = values)


########################### Exercise #################################
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
preg
preg %>% 
  pivot_longer(c("male","female"), names_to = "gender",values_to = "count")

preg %>% 
  pivot_longer(c("male","female"), names_to = "gender",values_to = "count", values_drop_na = TRUE)


# separate and unite
table3

table3 %>% 
  separate(rate,c("cases","population"), sep = '/', convert = TRUE)
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2) %>%
  unite(new,century,year, sep = "")

# missing data
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)
stocks
# only 1 data is explicitly missing

stocks %>% 
  pivot_wider(names_from=year,values_from = return)
# one more data is implicitly missing

stocks %>%
  pivot_wider(names_from = year, values_from=return) %>%
  pivot_longer(c('2015','2016'),names_to = "year",values_to = "return",values_drop_na = TRUE)

stocks %>%
  complete(year,qtr)

treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)
treatment %>%
  fill(person)

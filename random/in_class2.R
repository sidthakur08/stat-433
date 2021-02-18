library(nycflights13)
library(dplyr)

# In addition to flights:
flights

# we have four related data frames:
airlines
airports
planes
weather



# This follows from chapter 13 of r4ds on "Relational data"
#   here, we have more than one table of data.  
#   All of the operations will be defined for two tables.  To "study" K tables, you "study" all K choose 2 pairs. 

# To work with relational data you need verbs that work with pairs of tables. 
# There are three families of verbs designed to work with relational data:
#   
#   Mutating joins, which add new variables to one data frame from matching observations in another.
# 
#   Filtering joins, which filter observations from one data frame based on whether or not they match an observation in the other table.
# 
#   Set operations, which treat observations as if they were set elements.
# 





# lots of playgrounds!
#  What I call playgrounds, database people call "keys".
#  What are the keys (playgrounds) in these tables?

# flights connects to planes via a single variable, tailnum.
# 
# flights connects to airlines through the carrier variable.
# 
# flights connects to airports in two ways: via the origin and dest variables.
# 
# flights connects to weather via origin (the location), and year, month, day and hour (the time).

# http://r4ds.had.co.nz/diagrams/relational-nycflights.png

# 
# There are two types of keys:
#   
#   A primary key uniquely identifies an observation in its own table. 
#   For example, planes$tailnum is a primary key because it uniquely  
#   identifies each plane in the planes table.
# 
#   A foreign key uniquely identifies an observation in another table. 
#   For example, the flights$tailnum is a foreign key because it 
#   appears in the flights table where it matches each flight to a unique plane.


# Is the primary key unique???

planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n > 1)

weather %>% filter(year==2013,month==11,day==3,hour==1,origin=='EWR') %>% View

# what is primary key in flights?
flights %>% group_by(month, day,carrier,origin) %>% count(flight) %>% filter(n>1)


# it's sometimes useful to add one with mutate() and row_number(). 
# That makes it easier to match observations if youâ€™ve done some 
# filtering and want to check back in with the original data. 
# This is called a surrogate key.
flights %>% mutate(myKey = row_number()) %>% select(myKey, year:dest) # puts the mykey as a first column and goes till dest


# Mutating joins, (1) join to tables and (2) add a column on the right side.

# for ease of display, make a narrower data set:
flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2



# Imagine you want to add the full 
# airline name to the flights2 data. 
# You can combine the airlines and flights2 data 
# frames with left_join():

flights2 %>%
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

# alternative syntax for this problem (often doesn't generalize)

flights2 %>%
  select(-origin, -dest) %>% 
  mutate(name = airlines$name[match(carrier, airlines$carrier)])

#  WHAT IS A LEFT JOIN?!
# http://r4ds.had.co.nz/diagrams/join-venn.png
# why might inner join be dangerous?  How are missing variables often stored? 

# http://r4ds.had.co.nz/relational-data.html#mutating-joins

(x <- tibble(key = c(1, 2, 3), val_x = c("x1", "x2", "x3")))
(y <- tibble(key = c(1, 2, 4), val_y = c("y1", "y2", "y3")))

x %>% 
  inner_join(y, by = "key")
x %>% 
  left_join(y, by = "key")
x %>% 
  right_join(y, by = "key")
x %>% 
  full_join(y, by = "key")


#  Duplicated keys!
#   are duplicated keys primary keys or foreign keys? 
#   in flights data which keys are duplicated? 
#   What do you *want* the join to do? 
(x <- tibble(key = c(1, 2, 2, 1), val_x = stringr::str_c("x", 1:4)))
(y <- tibble(key = 1:2, val_y = stringr::str_c("y", 1:2)))
left_join(x, y, by = "key")

#  strange things happen if the primary key is duplicated (all combinations!)
(x <- tibble(key = c(1, 2, 2, 3), val_x = stringr::str_c("x", 1:4)))
(y <- tibble(key = c(1, 2, 2, 3), val_y = stringr::str_c("y", 1:4)))
left_join(x, y, by = "key")


####  by="key"  because "key" exists in both tables.
#  what if it is named something different in one table?  
#  what if multiple columns are needed for the key?

weather
flights2 %>% left_join(weather)  # how does this join? no key defined! Joining, by = c("year", "month", "day", "hour", "origin")
flights2 %>% left_join(planes)  # how does this join? no key defined! should not join by year, tailnum and just tailnum
flights2 %>% left_join(planes, by ="tailnum")
flights2 %>% left_join(airports)
flights2 %>% left_join(airports, by = c("dest", "faa"))
flights2 %>% left_join(airports, by = c("dest" = "faa"))  # notice the syntax!!
flights2 %>% left_join(airports, c("origin" = "faa"))


# semi-join.
#   discard rows that don't have a match, but don't import any new columns.
airports
airports %>%
  semi_join(flights, c("faa" = "dest"))

# anti-join.
#   discard rows that DO have a match.
flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)


# troubleshooting:
# 
# Start by identifying the variables that form the primary key in each table. 
#   You should usually do this based on your understanding of the data, 
#   not empirically by looking for a combination of variables that give a unique identifier. 
#   If you just look for variables without thinking about what they mean, you might get (un)lucky and find a combination that's unique in your current data but the relationship might not be true in general.
# 

# Check that none of the variables in the primary key are missing. 
#   If a value is missing then it can't identify an observation!
#   
# Check that your foreign keys match primary keys in another table. 
#   The best way to do this is with an anti_join(). 
#   It's common for keys not to match because of data entry errors. 
#   Fixing these is often a lot of work.
# 
# If you do have missing keys, you'll need to be thoughtful about 
#   your use of inner vs. outer joins, carefully considering whether 
#   or not you want to drop rows that donâ€™t have a match.
# 
# Be aware that simply checking the number of rows before and after 
#   the join is not sufficient to ensure that your join has gone smoothly. 
#   If you have an inner join with duplicate keys in both tables, you 
#   might get unlucky as the number of dropped rows might exactly equal 
#   the number of duplicated rows!
#   
#   

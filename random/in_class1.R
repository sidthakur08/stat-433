#  readr and fread
rm(list = ls())

x = read.csv("http://pages.stat.wisc.edu/~karlrohe/ds479/data/badRead.csv")
x[rowSums(is.na(x)) > 0,]
x[1072,]
head(x)
str(x)

library(readr)
y = read_csv("http://pages.stat.wisc.edu/~karlrohe/ds479/data/badRead.csv")
y[rowSums(is.na(y)) > 0,]

library(data.table)
z = fread("http://pages.stat.wisc.edu/~karlrohe/ds479/data/badRead.csv")
sum(is.na(z))
z[rowSums(is.na(z)) > 0,]
z[1072,]


str(x)
str(y)
str(z)

sum(is.na(x))
sum(is.na(y))
sum(is.na(z))

# what do we do? 
#  Read the error!!  
#   Does this error look google-able?  What is "parsing"

y = read.csv("http://pages.stat.wisc.edu/~karlrohe/ds479/data/badRead.csv", colClasses = c("character", "character"))
str(y)
sum(is.na(y))  # cool! 
# y[rowSums(is.na(y)) > 0,]
y[1097,]
y[1072,]
y <- y[-c(1097),]
sum(is.na(y))

y[is.na(y)]

'col1 <- parse_integer(y[,2])

sum(is.na(col1))
col1[is.na(col1)]

col1 <- col1[!is.na(col1)]

mean(col1)'




mean(as.numeric(y[,2]))
which(is.na(as.numeric(y[,2])))
bad = which(is.na(as.numeric(y[,2])))
y[bad,]  # yeah, that's messy.
mean(y[-bad,2])
mean(as.numeric(y[-bad,2]))



#  what about fread?
fread("http://pages.stat.wisc.edu/~karlrohe/ds479/data/badRead.csv")
badFile = "http://pages.stat.wisc.edu/~karlrohe/ds479/data/badRead.csv"
read_lines(badFile,skip = 1071,n_max = 3)
# I guess you have to go into a text editor to fix it,
# or try skipping/restarting several times... ugh. any thoughts?
#  At this point, regular expressions can be particularly useful!!!  And python / more text friendly languages...
# https://github.com/Rdatatable/data.table/issues/711


read_csv(readr_example("challenge.csv"))
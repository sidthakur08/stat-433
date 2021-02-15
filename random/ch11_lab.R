library(tidyverse)

# read_csv() reads comma delimited files 
# read_csv2() reads semicolon separated files 
# read_tsv() reads tab delimited files 
# read_delim() reads in files with any delimiter.
# read_fwf() reads fixed width files. 
# --> You can specify fields either by their widths with fwf_widths() or their position with fwf_positions(). read_table() reads a common variation of fixed width files where columns are separated by white space.
# read_log() reads Apache style log files.

heights <- read_csv('data/heights.csv')

read_csv("a, b, c
1,2,3
4,5,6")

read_csv("first line
# okay this is a comment
x,y,z
1,2,3
4,5,6
7,8,9",comment="#",skip=1)

read_csv("x,y,z\n1,2,3\n4,5,6")

read_csv("x,y,z\n1,2,3\n 4,5,None",na="None")

# Ex1 -> 
read_delim("x|y|z\n1|2|3\n4|5|6",delim = "|")

# Ex4 ->
read_csv("x,y\n1,'a,b'",quote = "'")

# Ex5 ->
read_csv("a,b\n1,2,3\n4,5,6") # no problemo
read_csv("a,b,c\n1,2\n1,2,3,4") #si problemo
read_csv("a,b\n\"1") # si problemo
read_csv("a,b\n1,2\na,b") # no problemo
read_csv("a;b\n1;3") # si problemo use read_csv2

# Parsing a vector
# parse_*
# --> integer
# --> logical
# --> date, datetime, time
# --> double
# --> character
# --> factor

parse_number("It cost $123.45")
parse_number("123'456'789")
parse_number("123'456'789", locale = locale(grouping_mark = "'"))

# converts hexadecimal number to character
charToRaw("Sid")



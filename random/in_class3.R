# From 
# https://socviz.co/makeplot.html#mappings-link-data-to-things-you-see
# https://socviz.co/assets/ch-03-ggplot-formula-schematic.png
install.packages("gapminder")
library(gapminder)
library(ggplot2)
gapminder

p <- ggplot(data = gapminder)

# The mapping = aes(...) argument links variables to things you will see on the plot. 
# The x and y values are the most obvious ones. 
# Other aesthetic mappings can include, for example, color, shape, size, and line type (whether a line is solid or dashed, or some other pattern). Weâ€™ll see examples in a minute. A mapping does not directly say what particular, e.g., colors or shapes will be on the plot. Rather they say which variables in the data will be represented by visual elements like 
# a color, a shape, or a point on the plot area.
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))

# make the plot (it is still boring!)
p

p + geom_point()  
# great!  now add more layers


# Overall...
# 1) Tell the ggplot() function what our data is. 
#       The data = ... step.
# 2) Tell ggplot() what relationships we want to see.
#       The mapping = aes(...) step. 
#       For convenience we will put the results of the first two steps in an object called p.
# 3) Tell ggplot how we want to see the relationships in our data.  
#       Choose a geom.
# 4) Layer on geoms as needed, by adding them to the p object one at a time.
#       Use some additional functions to adjust scales, labels, tick marks, titles. 
#       Weâ€™ll learn more about some of these functions shortly...
#       The scale_, family, labs() and guides() functions. 


p + geom_smooth()

p + geom_point() + geom_smooth()

p + geom_point() + geom_smooth(method = "lm") 

p + geom_point() +
  geom_smooth(method = "gam") +
  scale_x_log10()

p + geom_point() +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar)

p <-  ggplot(data = gapminder,
             mapping = aes(x = gdpPercap,
                           y = lifeExp,
                           color = continent))
p

p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10(labels = scales::dollar)

# what is different in the following?

p <- ggplot(data = gapminder, 
            mapping = aes(x = gdpPercap, 
                          y = lifeExp))
p + geom_point(mapping = aes(color = continent)) +
  geom_smooth(method = "loess") +
  scale_x_log10(labels = scales::dollar)




p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp)) 

p + geom_point(alpha = 0.3) +
  geom_smooth(color = "orange", se = FALSE, size = 1.5, method = "lm") +
  scale_x_log10(labels = scales::dollar)


# Figure 3.13: A more polished plot of Life Expectancy vs GDP.
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point(alpha = 0.3) +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar) +
  labs(x = "GDP Per Capita", y = "Life Expectancy in Years",
       title = "Economic Growth and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")


p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(mapping = aes(color = log10(pop))) +
  scale_x_log10(labels = scales::dollar)
#  vs
p + geom_point(mapping = aes(size = log10(pop))) +
  scale_x_log10(labels = scales::dollar)
#  vs
p + geom_point(mapping = aes(alpha = log10(pop))) +
  scale_x_log10(labels = scales::dollar)

p + geom_point() +
  facet_wrap(~country) +
  scale_x_log10(labels = scales::dollar)










#  This follows chapter 3 in r4ds


library(ggplot2)
library(dplyr)

mpg


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

mpg %>%  ggplot + 
  geom_point(mapping = aes(x = displ, y = hwy))



# <DATA> %>% ggplot + 
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# aes = aesthetic properties  

# aesthetic |esËˆTHetik| (also esthetic)
# adjective
# concerned with beauty or the appreciation of beauty: the pictures give great aesthetic pleasure.
# â€¢ giving or designed to give pleasure through beauty; of pleasing appearance.
# noun [ in sing. ]
# a set of principles underlying and guiding the work of a particular artist or artistic movement: the Cubist aesthetic.

# faceting:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(~ class)


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(class ~ cyl)




# Compare these two plots:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))




#geoms

# compare these two plots

# left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# right
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))


ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))


ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))+ 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))

# here is a cheat sheet!  https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf


# here is the "theory" behind ggplot...
# source:  http://sctyner.github.io/ggplot_tutorial.html#1 


# gg = grammar of graphics.

# The grammar's "Parts of Speech"
# Data (noun/subject)
# Aesthetic mappings (adjectives)
# Geom (verb)
# Stat (adverb)
# Position (preposition)

# "Sentences" and "Paragraphs"
# All components combine to make a layer (sentence)
# Can places layers on top of each other (paragraph)
# String it all together with + (punctuation)




# there is a lot more if you are interested...
#  below is a template.  
#   I've never used stat or coordinate function... perhaps less useful... 
#   perhaps I haven't made it there yet.
# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>, 
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>
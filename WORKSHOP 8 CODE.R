#EVA TAKYI-KUFUOR
#11TH MARCH 2025
#WORKSHOP 8 


# For this we’ll use a puppy-equivalent of a dataset called Palmer --------
install.packages("palmerpenguins")
library(palmerpenguins)
# Install from CRAN
install.packages("tidyverse")
library(tidyverse)
View(penguins)


# Have a look at the code below and identify the bits that are hig --------
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g))


# Let’s check by mapping species to the aesthetic colour of geom_p --------
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g, colour = species))


# Does this cluster also correlate with the island the penguins ar --------
ggplot(data = penguins) +
  geom_point(mapping = aes(
    x = bill_length_mm,
    y = body_mass_g,
    colour = species,
    shape = island
  ))


# We can add additional layers to our plot by specifying additiona --------
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_smooth(mapping = aes(x = bill_length_mm, y = body_mass_g))


# we don’t have to repeat the mapping of variables if we use the s --------
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_smooth()


# Let’s map species again to colour ---------------------------------------
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species)) +
  geom_smooth()


# Copy and fix the code above, so that each species has its own fi --------
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species)) +
  geom_smooth(mapping = aes(colour = species))


# Once we’re happy with our plot we can assign it to a variable an --------
pengu_plot <-
  ggplot(data = penguins,
         mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(aes(colour = species))

#We can add layers to our plot
pengu_plot +
  geom_smooth()


# Write code to produce the following plot. Hint: Look at the docu --------
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) + 
  geom_point (aes(colour = species, shape = species)) + 
  geom_smooth(mapping = aes(colour = species),
              method = lm,
              se = F)


# We can save our plots to a file using ‘ggsave’. We can either gi --------
ggsave(filename = "penguin_plot_1.png", plot = pengu_plot)


# Or if we don’t pass it a variable it will save the last plot we  --------
pengu_plot +
  geom_smooth()

ggsave("penguin_plot_2.png")


# Look at the documentation for ggsave; save your latest plot with --------
ggsave(
  "penguin_plot_4.png",
  width = 200,
  height = 300,
  units = c("mm")
)


# if we’d like to investigate body_mass for each species, we can u --------
ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot(mapping = aes(colour = species))


# Change the code, so that it fills the boxes with colour instead  --------
ggplot(data = penguins,
       mapping = aes(x = species, fill = species, y = body_mass_g)) +
  geom_boxplot(mapping = aes(colour = species))

ggsave ("penguin_plot_5.png")


# Look at penguins using both head() and str(). Where can you see  --------
head(penguins) #species + island + sex = factors
str(penguins) #categories of other variables + levels of factors


# Here is an example where alphabetical order would be annoying: ----------
df_days <-
  data.frame(day = c("Mon", "Tues", "Wed", "Thu"),
             counts = c(3, 8, 10, 5))
df_days$day <- as.factor(df_days$day)
str(df_days)

ggplot(data = df_days, mapping = aes(x = day, y = counts)) +
  geom_col()


# Luckily we can change that very easily: ---------------------------------
df_days$day <- factor(df_days$day, levels = c("Mon", "Tues", "Wed", "Thu"))
str(df_days)

ggplot(data = df_days, mapping = aes(x = day, y = counts)) +
  geom_col()


# Write the code to reproduce this plot. You’ll have to use the da --------
penguins$species <- factor(penguins$species, levels = c("Chinstrap", "Gentoo", "Adelie"))  #to put species in particular order 
ggplot(data = penguins,
       mapping = aes(x = species, fill = island, y = body_mass_g)) +
  geom_point(aes(colour = island)) + geom_violin() 

ggsave("penguin_plot_6.png")


# Here is another example: ------------------------------------------------
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  coord_flip()


# Have a look at the documentation for geom_bar. What is the diffe --------
#coord_flip = flips x and y axis


# This is where the dplyr function filter() comes in. It does what --------
penguins %>% filter(!species == "Chinstrap") %>% #!species = every species but chinstrap
  ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species, shape = island))


# Use is.na(sex) with filter() to reproduce the plot below, so tha --------
penguins$species<-factor(penguins$species, levels = c("Adelie", "Chinstrap", "Gentoo"))
penguins %>% filter(!sex != "NA") %>%
ggplot (data = penguins, mapping = aes(x = species, fill = sex, y = body_mass_g)) +
  geom_violin()

ggsave("penguin_plot_7.png")


# The function to manipulate or add labels is labs(). ---------------------
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       fill = "Sex",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  )


# Here we have mapped a categorical, i.e. discrete, variable (sex) --------
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  ) +
  scale_fill_discrete(name = "Sex", # the legend title can be changed here or in labs()
                      labels = c("Female", "Male", "Unknown"),
                      type = c("yellow3", "magenta4", "grey"))


# Generate a new plot from the penguin data with at least two geom --------
penguins %>%
  ggplot(penguins, mapping = aes(x = species, y = flipper_length_mm)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Flipper length among penguins",
       subtitle = "Female penguins have longer flippers",
       x = "Species",
       y = "Flipper length (mm)",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
       ) +
  scale_fill_discrete(name = "Sex",
                      labels = c("Male", "Female", "Unknown"),
                      type = c("blue", "pink", "yellow"))

ggsave("penguin_plot_8.png")
ggsave("penguin_plot_9.png")


#EVA TAKYI-KUFUOR
#11TH MARCH 2025 
#WORKSHOP 8 CHALLENGE


# Read in the modelling table (“wmr_modelling.txt”) and reproduce  --------
malaria <- read.table(
  "wmr_modelling.txt",
  sep = "\t",
  na.strings = "NA",
  header = T
)
View(malaria)


# specific year of 2020 ---------------------------------------------------
malaria2020 <- malaria %>% filter(year == 2020) %>% arrange(deaths)
View(malaria2020)


# death order by country  -------------------------------------------------
malariadeathorder <- malaria2020$country

malaria2020$country <- factor(malaria2020$country, levels = malariadeathorder)


# final plot  -------------------------------------------------------------
ggplot (data = malaria2020, mapping = aes(x = deaths, y = country)) +
  geom_col() #because its not a bar graph

ggsave("malaria_death_plot.png")


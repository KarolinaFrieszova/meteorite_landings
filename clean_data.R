library(tidyverse)
library(janitor)
library(assertr)
meteorite_landings <- read_csv("raw_data/meteorite_landings.csv")

meteorites <- clean_names(meteorite_landings)

meteorites <- meteorites %>% 
  separate(geo_location, c("latitude", "longitude"), sep = ",") %>% 
  mutate(latitude = str_remove_all(latitude, "^\\("),
         longitude = str_remove_all(longitude, "\\)$"),
         latitude = as.numeric(latitude),
         longitude = as.numeric(longitude),
         latitude = coalesce(latitude, 0, na.rm = TRUE),
         longitude = coalesce(longitude, 0, na.rm = TRUE)) %>% 
  filter(mass_g > 1000) %>% 
  drop() %>% 
  arrange(year)

meteorites %>% 
  verify(latitude >= -90 & latitude <= 90) %>% 
  verify(longitude >= -180 & longitude <= 180) 

stopifnot(names(meteorites) %in% 
            c("id", "name", "mass_g", "year", "fall", "latitude", "longitude"))

write_csv(meteorites, "clean_data/meteorites.csv")
